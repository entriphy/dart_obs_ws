import 'serializable.dart';
import '../opcodes/request_response.dart';

abstract class RequestResponse extends Serializable {
  final RequestResponseStatus status;

  RequestResponse(super.data, this.status);
}

class GenericResponse extends RequestResponse {
  GenericResponse(super.data, super.status);
  GenericResponse.fromResponse(RequestResponse resp)
      : this(resp.data, resp.status);
}
