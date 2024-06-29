import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../errors/base_error.dart';
import '../../result_wrapper/result_wrapper.dart';
import 'http_client_service_interface.dart';

class HttpClientService implements IHttpClientService {
  final Client? client;
  final String? baseUrl;

  HttpClientService({
    this.client,
    this.baseUrl,
  });

  void logResponse(Response response, [Object? body]) {
    log("---- [LOG] REQUEST ---- \n");
    log("URL: ${response.request?.url}");
    log("METHOD: ${response.request?.method}");

    log("---- [LOG] BODY ----");
    log("BODY: $body");

    log("---- [LOG] RESPONSE ----");
    log("STATUS CODE: ${response.statusCode}");
    log("RESPONSE: ${jsonEncode(response.body)}");
    log("BODY RESPONSE: ${response.body}");
  }

  @override
  Future<Result> get(
    Uri url, {
    Map<String, String>? headers,
  }) async {
    try {
      final result = await client!.get(
        Uri.parse(
          baseUrl! + url.toString(),
        ),
      );
      if (kDebugMode) {
        logResponse(result);
      }
      return ResultSuccess(result);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }
}
