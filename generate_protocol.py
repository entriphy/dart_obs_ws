import requests, re, io

def camel_to_snake(str):
   return re.sub(r'(?<!^)(?=[A-Z])', '_', str).lower().replace("web_socket", "websocket")

def pascal_to_camel(str) -> str:
    return str[0].lower() + str[1:]

def write(f: io.FileIO, text: str = "", indent: int = 0, newlines: int = 1, comment: bool = False):
    f.write("\t" * indent + ("/// " if comment else "") + text + "\n" * newlines)

def fix_field_type(field_type: str) -> str:
    return field_type.replace("Number", "num").replace("Array", "List").replace("Any", "dynamic").replace("Object", "Map<String, dynamic>").replace("Boolean", "bool")

if __name__ == "__main__":
    protocol = requests.get("https://raw.githubusercontent.com/obsproject/obs-websocket/master/docs/generated/protocol.json").json()

    f_requests = open("lib/protocol/requests.dart", "w")
    write(f_requests, "import 'responses.dart';")
    write(f_requests, "import '../obs_ws.dart';")
    write(f_requests, "import '../classes/request_response.dart';", newlines=2)
    write(f_requests, "extension Protocol on OBSWebSocket {")

    f_classes = open("lib/protocol/responses.dart", "w")
    write(f_classes, "import '../classes/request_response.dart';", newlines=2)

    for request in protocol["requests"]:
        has_return_fields = len(request["responseFields"]) > 0 
        return_type = "GenericResponse" if not has_return_fields else request["requestType"] + "Response"
        function_name = pascal_to_camel(request["requestType"])
        params = []
        request_params = []
        if len(request["requestFields"]) > 0:
            for field in request["requestFields"]:
                field_name = field["valueName"]
                if "." in field_name:
                    continue
                params.append(f"{'required ' if not field['valueOptional'] else ''}{fix_field_type(field['valueType'])}{'?' if field['valueOptional'] else ''} {field_name}")
                request_params.append(f"{'if (%s != null) ' % field_name if field['valueOptional'] else ''}\"{field_name}\": {field_name}")
        params_str = "" if len(params) == 0 else "{" + ", ".join(params) + "}"

        for desc in request["description"].split("\n"):
            write(f_requests, desc, indent=1, comment=True)
        write(f_requests, "* Category: " + request["category"].capitalize(), indent=1, comment=True)
        write(f_requests, "* Complexity: " + str(request["complexity"]) + "/5", indent=1, comment=True)
        write(f_requests, "* RPC Version: " + request["rpcVersion"], indent=1, comment=True)
        write(f_requests, "* Initial Version: " + request["initialVersion"], indent=1, comment=True)
        write(f_requests, indent=1, comment=True)
        if len(params) > 0:
            write(f_requests, "**Request fields:**", indent=1, comment=True)
            for field in request["requestFields"]:
                write(f_requests, f"* [{field['valueName']}]: {field['valueDescription'].replace(chr(92), ' ')}", indent=1, comment=True)

        if request["deprecated"]:
            write(f_requests, "@Deprecated(\"Deprecated\")", indent=1)
        write(f_requests, f"Future<{return_type}> {function_name}({params_str}) async => ", indent=1, newlines=0)
        if has_return_fields:
            write(f_requests, f"{return_type}.fromResponse(await call(\"{request['requestType']}\"{', {%s}' % ', '.join(request_params) if len(request_params) > 0 else ''}));", newlines=2)
        else:
            write(f_requests, f"call(\"{request['requestType']}\"{', {%s}' % ', '.join(request_params) if len(request_params) > 0 else ''});", newlines=2)

        if len(request["responseFields"]) > 0:
            write(f_classes, f"class {request['requestType']}Response extends RequestResponse {'{'}")
            for field in request["responseFields"]:
                field_name = field["valueName"]
                field_type = fix_field_type(field['valueType'])
                write(f_classes, field["valueDescription"], indent=1, comment=True)
                write(f_classes, f"{field_type}{'?' if 'null' in field['valueDescription'] else ''} get {field_name} => data[\"{field_name}\"]{'.cast<%s>()' % re.findall(r'List<(.+)>', field_type)[0] if field_type.startswith('List<') else ''};", indent=1, newlines=2)
            write(f_classes, f"{request['requestType']}Response(data, status) : super(data, status);", indent=1)
            write(f_classes, f"{request['requestType']}Response.fromResponse(resp) : this(resp.data, resp.status);", indent=1)
            write(f_classes, "}", newlines=2)
    write(f_requests, "}")

    f_requests.close()
    f_classes.close()

    f_enums = open("lib/protocol/enums.dart", "w")
    for enum in protocol["enums"]:
        if enum["enumType"] == "ObsMediaInputAction": # Kinda broken, but this is deprecated anyway
            continue

        write(f_enums, f"enum {enum['enumType']} {'{'}")
        for i, identifier in enumerate(enum["enumIdentifiers"]):
            for desc in identifier["description"].split("\n"):
                write(f_enums, desc, indent=1, comment=True)
            write(f_enums, "* RPC Version: " + str(identifier["rpcVersion"]), indent=1, comment=True)
            write(f_enums, "* Initial Version: " + identifier["initialVersion"], indent=1, comment=True)
            if identifier["deprecated"]:
                write(f_enums, "@Deprecated(\"Deprecated\")", indent=1)
            enum_value = identifier['enumValue']
            if type(enum_value) == str:
                if enum_value.startswith("("):
                    enum_value = enum_value[1:-1]
                if " | " in enum_value: # For EventSubscription
                    identifiers = enum_value.split(" | ")
                    values = [str(next(x for x in enum["enumIdentifiers"] if x["enumIdentifier"] == i)["enumValue"]) for i in identifiers]
                    enum_value = " | ".join(values)
            write(f_enums, f"{pascal_to_camel(identifier['enumIdentifier'])}({enum_value}){',' if i != len(enum['enumIdentifiers']) - 1 else ';'}", indent=1, newlines=2)
        write(f_enums, "final int value;", indent=1)
        write(f_enums, f"const {enum['enumType']}(this.value);", indent=1)
        write(f_enums, f"static {enum['enumType']} fromInt(int n) => {enum['enumType']}.values.firstWhere((val) => val.value == n);", indent=1)
        write(f_enums, "}", newlines=2)
    f_enums.close()

    f_events = open("lib/protocol/events.dart", "w")
    write(f_events, "import '../classes/event.dart';", newlines=2)

    events = []
    for event in protocol["events"]:
        for desc in event["description"].split("\n"):
            write(f_events, desc, comment=True)
        write(f_events, "* Subscription: " + event["eventSubscription"], comment=True)
        write(f_events, "* Category: " + event["category"].capitalize(), comment=True)
        write(f_events, "* Complexity: " + str(event["complexity"]) + "/5", comment=True)
        write(f_events, "* RPC Version: " + event["rpcVersion"], comment=True)
        write(f_events, "* Initial Version: " + event["initialVersion"], comment=True)
        write(f_events, f"class {event['eventType']} extends Event {'{'}")
        for field in event["dataFields"]:
            write(f_events, field["valueDescription"].replace("\n", " "), indent=1, comment=True)
            field_type = fix_field_type(field['valueType'])
            write(f_events, f"{field_type} get {field['valueName']} => data[\"{field['valueName']}\"]{'.cast<%s>()' % re.findall(r'List<(.+)>', field_type)[0] if field_type.startswith('List<') else ''};", indent=1, newlines=2)
        write(f_events, f"{event['eventType']}(super.data);", indent=1)
        write(f_events, "}", newlines=2)
        events.append(event["eventType"])

    write(f_events, "const Map<String, Event Function(Map<String, dynamic> data)> EventMap = {")
    for event in events:
        write(f_events, f"\"{event}\": {event}.new,", indent=1)
    write(f_events, "};", newlines=2)
    f_events.close()