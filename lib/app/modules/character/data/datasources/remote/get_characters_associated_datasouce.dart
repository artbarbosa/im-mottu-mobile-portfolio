import 'dart:convert';

import 'package:http/http.dart';

import '../../../../../core/env/env.dart';
import '../../../../../core/errors/base_error.dart';
import '../../../../../core/helpers/crypto_helpers.dart';
import '../../../../../core/helpers/map_extension.dart';
import '../../../../../core/result_wrapper/result_wrapper.dart';
import '../../../../../core/services/http_client/http_client_service_interface.dart';
import '../../model/character_model.dart';

abstract class IGetCharactersAssociatedDataSource {
  Future<Result> getCharactersAssociated({
    required CharacterModel characterModel,
  });
}

class GetCharactersAssociatedDataSource
    implements IGetCharactersAssociatedDataSource {
  final IHttpClientService http;

  GetCharactersAssociatedDataSource({required this.http});

  @override
  Future<Result> getCharactersAssociated({
    required CharacterModel characterModel,
  }) async {
    try {
      const String ts = "1";
      final privateKey = Env.to?.privateKey ?? "";
      final publicKey = Env.to?.publicKey ?? "";
      final hash = CryptoHelpers.generateMd5(ts + privateKey + publicKey);

      final seriesList = characterModel.series?.items;
      final relatedCharacters = <Map<String, dynamic>>[];

      if (seriesList != null) {
        for (var series in seriesList) {
          final seriesURI =
              series.resourceURI?.replaceAll(Env.to?.baseUrlAPI ?? "", "");
          final charactersUri = Uri.parse(
            '$seriesURI/characters?ts=$ts&apikey=$publicKey&hash=$hash',
          );
          final charactersResult = await http.get(charactersUri);
          final charactersResponse =
              charactersResult.getSuccessData as Response;
          final charactersData =
              jsonDecode(charactersResponse.body) as Map<String, dynamic>;

          if (charactersData.isError) {
            return ResultError(BaseError(charactersData.errorMessage));
          }
          final charactersList = charactersData['data']['results'] as List;
          for (var character in charactersList) {
            if (character['id'] != characterModel.id) {
              relatedCharacters.add(character);
            }
          }
        }
      }

      final uniqueRelatedCharacters =
          {for (var e in relatedCharacters) e['id']: e}.values.toList();

      return ResultSuccess(uniqueRelatedCharacters);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }
}
