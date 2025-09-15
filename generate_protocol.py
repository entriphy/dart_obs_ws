import io
import re
import requests

def camel_to_snake(str):
   return re.sub(r'(?<!^)(?=[A-Z])', '_', str).lower().replace("web_socket", "websocket")

def pascal_to_camel(str) -> str:
    return str[0].lower() + str[1:]

def snake_to_camel(str):
    split = str.split("_")
    return split[0] + "".join(s.title() for s in split[1:])

def write(f: io.FileIO, text: str = "", indent: int = 0, newlines: int = 1, comment: bool = False):
    f.write("  " * indent + ("/// " if comment else "") + text + "\n" * newlines)

def fix_field_type(field_type: str) -> str:
    return field_type.replace("Number", "num").replace("Array", "List").replace("Any", "dynamic").replace("Object", "Map<String, dynamic>").replace("Boolean", "bool")

if __name__ == "__main__":
    protocol = requests.get("https://raw.githubusercontent.com/obsproject/obs-websocket/master/docs/generated/protocol.json").json()

    f_requests = open("lib/src/protocol/requests.dart", "w")
    write(f_requests, "import '../obs_websocket.dart';", newlines=2)
    write(f_requests, "extension Requests on ObsWebSocket {")

    f_req_classes = open("lib/src/protocol/request_classes.dart", "w")
    write(f_req_classes, "import '../classes/request.dart';")
    write(f_req_classes, "import '../classes/response.dart';")
    write(f_req_classes, "import 'responses.dart';", newlines=2)

    f_classes = open("lib/src/protocol/responses.dart", "w")
    write(f_classes, "import '../classes/response.dart';", newlines=2)

    for request in protocol["requests"]:
        has_return_fields = len(request["responseFields"]) > 0
        request_type = request["requestType"]
        request_class = request_type + "Request"
        response_class = "ObsWebSocketResponse" if not has_return_fields else request_type + "Response"
        function_name = pascal_to_camel(request_type)
        params = []
        request_params = []
        params_fields = {}
        params_constructor = []
        if len(request["requestFields"]) > 0:
            for field in request["requestFields"]:
                field_name = field["valueName"]
                if "." in field_name:
                    continue
                field_type = fix_field_type(field['valueType'])
                params.append(f"{'required ' if not field['valueOptional'] else ''}{field_type}{'?' if field['valueOptional'] and field_type != 'dynamic' else ''} {field_name}")
                request_params.append(f"{'if (%s != null) ' % field_name if field['valueOptional'] else ''}\"{field_name}\": {field_name}")
                params_fields[field_name] = f"final {field_type}{'?' if field['valueOptional'] and field_type != 'dynamic' else ''} {field_name};"
                params_constructor.append(f"{'required ' if not field['valueOptional'] else ''}this.{field_name}")
        params_str = "" if len(params) == 0 else "{" + ", ".join(params) + "}"

        # requests.dart

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
                if "." not in field["valueName"]:
                    write(f_requests, f"* [{field['valueName']}]: {field['valueDescription'].replace(chr(92), ' ')}", indent=1, comment=True)
                else:
                    write(f_requests, f"* {field['valueName']}: {field['valueDescription'].replace(chr(92), ' ')}", indent=1, comment=True)

        if request["deprecated"]:
            write(f_requests, "@Deprecated(\"Deprecated\")", indent=1)
        write(f_requests, f"Future<{response_class}> {function_name}({params_str}) async => ", indent=1, newlines=0)
        if has_return_fields:
            write(f_requests, f"{response_class}.fromResponse(await call(\"{request['requestType']}\"{', {%s}' % ', '.join(request_params) if len(request_params) > 0 else ''}));", newlines=2)
        else:
            write(f_requests, f"call(\"{request['requestType']}\"{', {%s}' % ', '.join(request_params) if len(request_params) > 0 else ''});", newlines=2)

        # request_classes.dart

        for desc in request["description"].split("\n"):
            write(f_req_classes, desc, comment=True)
        write(f_req_classes, "* Category: " + request["category"].capitalize(), comment=True)
        write(f_req_classes, "* Complexity: " + str(request["complexity"]) + "/5", comment=True)
        write(f_req_classes, "* RPC Version: " + request["rpcVersion"], comment=True)
        write(f_req_classes, "* Initial Version: " + request["initialVersion"], comment=True)
        if request["deprecated"]:
            write(f_req_classes, "@Deprecated(\"Deprecated\")", indent=1)
        write(f_req_classes, f"class {request_class} extends ObsWebSocketRequest<{response_class}> {{")
        for field in request["requestFields"]:
            if field["valueName"] not in params_fields:
                continue
            write(f_req_classes, field['valueDescription'].replace(chr(92), ' '), indent=1, comment=True)
            write(f_req_classes, params_fields[field["valueName"]], indent=1, newlines=2)
        params_constructor_str = "" if len(params_constructor) == 0 else "{" + ", ".join(params_constructor) + "}"
        params_super_str = "{" + ", ".join([f'"{field}": {field}' for field in params_fields.keys()]) + "}"
        write(f_req_classes, f"{request_class}({params_constructor_str}) : super(\"{request_type}\", {params_super_str});", indent=1, newlines=2)
        write(f_req_classes, "@override", indent=1)
        write(f_req_classes, f"{response_class} serializeResponse(data, status) => {response_class}(data, status);", indent=1)
        write(f_req_classes, "}", newlines=2)


        # responses.dart

        if len(request["responseFields"]) > 0:
            write(f_classes, f"/// Response for {request['requestType']}")
            write(f_classes, f"class {request['requestType']}Response extends ObsWebSocketResponse {'{'}")
            for field in request["responseFields"]:
                field_name = field["valueName"]
                field_type = fix_field_type(field['valueType'])
                write(f_classes, field["valueDescription"], indent=1, comment=True)
                write(f_classes, f"{field_type}{'?' if 'null' in field['valueDescription'] and field_type != 'dynamic' else ''} get {field_name} => data[\"{field_name}\"]{'.cast<%s>()' % re.findall(r'List<(.+)>', field_type)[0] if field_type.startswith('List<') else ''};", indent=1, newlines=2)
            write(f_classes, f"{request['requestType']}Response(super.data, super.status);", indent=1)
            write(f_classes, f"{request['requestType']}Response.fromResponse(resp) : this(resp.data, resp.status);", indent=1)
            write(f_classes, "}", newlines=2)
    write(f_requests, "}")

    f_requests.close()
    f_req_classes.close()
    f_classes.close()

    f_enums = open("lib/src/protocol/enums.dart", "w")
    for enum in protocol["enums"]:
        enum_is_string = False
        enum_name = ('Obs' if not enum['enumType'].startswith('Obs') else '') + enum['enumType']
        write(f_enums, f"enum {enum_name} {'{'}")
        for i, identifier in enumerate(enum["enumIdentifiers"]):
            for desc in identifier["description"].split("\n"):
                write(f_enums, desc, indent=1, comment=True)
            write(f_enums, "* RPC Version: " + str(identifier["rpcVersion"]), indent=1, comment=True)
            write(f_enums, "* Initial Version: " + identifier["initialVersion"], indent=1, comment=True)
            if identifier["deprecated"]:
                write(f_enums, "@Deprecated(\"Deprecated\")", indent=1)
            enum_value = identifier["enumValue"]
            if type(enum_value) is str:
                if enum_value.startswith("OBS_"):
                    enum_is_string = True
                    enum_value = f'"{enum_value}"'
                else:
                    if enum_value.startswith("("):
                        enum_value = enum_value[1:-1]
                    if " | " in enum_value: # For EventSubscription
                        identifiers = enum_value.split(" | ")
                        values = [str(next(x for x in enum["enumIdentifiers"] if x["enumIdentifier"] == i)["enumValue"]) for i in identifiers]
                        enum_value = " | ".join(values)
            if enum_is_string:
                write(f_enums, f"{snake_to_camel(identifier['enumIdentifier'].lower())}({enum_value}){',' if i != len(enum['enumIdentifiers']) - 1 else ';'}", indent=1, newlines=2)
            else:
                write(f_enums, f"{pascal_to_camel(identifier['enumIdentifier'])}({enum_value}, \"{identifier['enumIdentifier']}\"){',' if i != len(enum['enumIdentifiers']) - 1 else ';'}", indent=1, newlines=2)
            
        write(f_enums, f"final {'String' if enum_is_string else 'int'} value;", indent=1)
        if not enum_is_string:
            write(f_enums, "final String name;", indent=1)
        write(f_enums, f"const {enum_name}(this.value{', this.name' if not enum_is_string else ''});", indent=1)
        write(f_enums, f"static {enum_name} from{'String' if enum_is_string else 'Int'}({'String' if enum_is_string else 'int'} n) => {enum_name}.values.firstWhere((val) => val.value == n);", indent=1)
        if not enum_is_string:
            write(f_enums, f"static {enum_name} fromString(String n) => {enum_name}.values.firstWhere((val) => val.name == n);", indent=1)
        write(f_enums, "}", newlines=2)
    f_enums.close()

    f_events = open("lib/src/protocol/events.dart", "w")
    write(f_events, "import '../classes/event.dart';", newlines=2)

    events = []
    for event in protocol["events"]:
        for desc in event["description"].split("\n"):
            write(f_events, desc.replace("TODO", "todo"), comment=True)
        write(f_events, "* Subscription: " + event["eventSubscription"], comment=True)
        write(f_events, "* Category: " + event["category"].capitalize(), comment=True)
        write(f_events, "* Complexity: " + str(event["complexity"]) + "/5", comment=True)
        write(f_events, "* RPC Version: " + event["rpcVersion"], comment=True)
        write(f_events, "* Initial Version: " + event["initialVersion"], comment=True)
        write(f_events, f"class {event['eventType']}Event extends ObsWebSocketEvent {'{'}")
        for field in event["dataFields"]:
            write(f_events, field["valueDescription"].replace("\n", " "), indent=1, comment=True)
            field_type = fix_field_type(field['valueType'])
            write(f_events, f"{field_type} get {field['valueName']} => data[\"{field['valueName']}\"]{'.cast<%s>()' % re.findall(r'List<(.+)>', field_type)[0] if field_type.startswith('List<') else ''};", indent=1, newlines=2)
        write(f_events, f"{event['eventType']}Event(super.type, super.data);", indent=1)
        write(f_events, "}", newlines=2)
        events.append(event["eventType"])

    write(f_events, "// ignore: constant_identifier_names")
    write(f_events, "const Map<String, ObsWebSocketEvent Function(String type, Map<String, dynamic> data)> eventMap = {")
    for event in events:
        write(f_events, f"\"{event}\": {event}Event.new,", indent=1)
    write(f_events, "};", newlines=2)
    f_events.close()

# dear god i hate this
