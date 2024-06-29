import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:mottu_marvel/app/core/services/http_client/http_client_service_interface.dart';

class MockHttpClientService extends Mock implements IHttpClientService {}

class MockResponse extends Mock implements http.Response {}
