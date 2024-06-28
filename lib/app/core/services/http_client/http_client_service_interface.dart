import '../../result_wrapper/result_wrapper.dart';

abstract class IHttpClientService {
  Future<Result> get(
    Uri url, {
    Map<String, String>? headers,
  });
}
