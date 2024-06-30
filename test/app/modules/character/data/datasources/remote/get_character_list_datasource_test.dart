import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mottu_marvel/app/core/errors/base_error.dart';
import 'package:mottu_marvel/app/core/result_wrapper/result_wrapper.dart';
import 'package:mottu_marvel/app/modules/character/data/datasources/remote/get_character_list_datasource.dart';
import 'package:mottu_marvel/app/modules/character/data/model/params/character_list_paramns.dart';

import '../../../../../core/mock/core_mock.dart';
import '../../../mock/character_mock.dart';

void main() {
  late IGetCharactersListDataSource dataSource;
  late MockHttpClientService mockHttpClient;
  final params = CharacterListParams();

  setUp(() {
    mockHttpClient = MockHttpClientService();
    dataSource = GetCharactersListDataSource(http: mockHttpClient);
  });

  setUpAll(() => registerFallbackValue(Uri.parse('charactes')));

  test(
    'getCharactersList returns ResultSuccess on successful HTTP request',
    () async {
      final mockResponse = MockResponse();

      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => ResultSuccess(mockResponse),
      );

      when(() => mockResponse.body).thenReturn(jsonEncode(characterListMock));

      final result = await dataSource.getCharactersList(
        params: params,
      );

      expect(result, isA<ResultSuccess>());
      expect((result as ResultSuccess).getSuccessData,
          characterListMock["data"]["results"]);
      verify(() => mockHttpClient.get(any())).called(1);
    },
  );

  test(
    'getCharactersList returns ResultError on failed HTTP request',
    () async {
      when(() => mockHttpClient.get(any())).thenThrow(
        Exception('Failed to fetch getCharactersList details'),
      );

      final result = await dataSource.getCharactersList(
        params: params,
      );

      expect(result, isA<ResultError>());
      expect((result as ResultError).getErrorData, isA<BaseError>());
      verify(() => mockHttpClient.get(any())).called(1);
    },
  );
}
