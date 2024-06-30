import 'dart:convert';

import 'package:http/http.dart';

import '../../../../../core/env/env.dart';
import '../../../../../core/errors/base_error.dart';
import '../../../../../core/helpers/crypto_helpers.dart';
import '../../../../../core/helpers/map_extension.dart';
import '../../../../../core/result_wrapper/result_wrapper.dart';
import '../../../../../core/services/http_client/http_client_service_interface.dart';
import '../../model/params/character_list_paramns.dart';

abstract class IGetCharactersListDataSource {
  Future<Result> getCharactersList({
    required CharacterListParams params,
  });
}

class GetCharactersListDataSource implements IGetCharactersListDataSource {
  final IHttpClientService http;

  GetCharactersListDataSource({required this.http});

  @override
  Future<Result> getCharactersList({
    required CharacterListParams params,
  }) async {
    try {
      final String ts = DateTime.now().millisecondsSinceEpoch.toString();
      final privateKey = Env.to?.privateKey ?? "";
      final publicKey = Env.to?.publicKey ?? "";
      final hash = CryptoHelpers.generateMd5(ts + privateKey + publicKey);

      final uri = Uri.parse(
        'characters?ts=$ts&apikey=$publicKey&hash=$hash&${params.toQueryString()}',
      );

      final result = await http.get(uri);
      final response = result.getSuccessData as Response;
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data.isError
          ? ResultError(BaseError(data.errorMessage))
          : ResultSuccess(data['data']["results"]);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }
}
