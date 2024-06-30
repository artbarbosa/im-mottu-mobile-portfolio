import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mottu_marvel/app/core/errors/base_error.dart';
import 'package:mottu_marvel/app/core/result_wrapper/result_wrapper.dart';
import 'package:mottu_marvel/app/modules/character/data/datasources/remote/get_characters_associated_datasouce.dart';
import 'package:mottu_marvel/app/modules/character/data/model/character_model.dart';
import 'package:mottu_marvel/app/modules/character/data/model/comics_model.dart';
import 'package:mottu_marvel/app/modules/character/data/model/items_model.dart';

import '../../../../../core/mock/core_mock.dart';
import '../../../mock/character_mock.dart';

void main() {
  late IGetCharactersAssociatedDataSource dataSource;
  late MockHttpClientService mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClientService();
    dataSource = GetCharactersAssociatedDataSource(http: mockHttpClient);
  });

  setUpAll(() => registerFallbackValue(Uri.parse('charactes')));

  test(
    'getCharactersAssociated returns ResultSuccess on successful HTTP request',
    () async {
      final mockResponse = MockResponse();
      final characterModel = CharacterModel(
        series: ComicsModel(items: [ItemsModel()]),
      );

      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => ResultSuccess(mockResponse),
      );

      when(() => mockResponse.body).thenReturn(jsonEncode(characterListMock));

      final result = await dataSource.getCharactersAssociated(
        characterModel: characterModel,
      );

      expect(result, isA<ResultSuccess>());
      expect((result as ResultSuccess).getSuccessData,
          characterListMock["data"]["results"]);
      verify(() => mockHttpClient.get(any())).called(1);
    },
  );
  test(
    'getCharactersAssociated returns ResultError on failed HTTP request',
    () async {
      final characterModel = CharacterModel(
        series: ComicsModel(items: [ItemsModel()]),
      );

      when(() => mockHttpClient.get(any())).thenThrow(
        Exception('Failed to fetch character details'),
      );

      final result = await dataSource.getCharactersAssociated(
        characterModel: characterModel,
      );

      expect(result, isA<ResultError>());
      expect((result as ResultError).getErrorData, isA<BaseError>());
      verify(() => mockHttpClient.get(any())).called(1);
    },
  );
}
