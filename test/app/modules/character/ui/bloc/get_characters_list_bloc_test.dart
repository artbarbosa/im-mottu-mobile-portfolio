import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mottu_marvel/app/core/errors/base_error.dart';
import 'package:mottu_marvel/app/core/result_wrapper/result_wrapper.dart';
import 'package:mottu_marvel/app/core/states/base_page_state.dart';
import 'package:mottu_marvel/app/modules/character/data/model/character_model.dart';
import 'package:mottu_marvel/app/modules/character/data/model/params/character_list_params.dart';
import 'package:mottu_marvel/app/modules/character/data/repositories/get_character_list_repository.dart';
import 'package:mottu_marvel/app/modules/character/ui/bloc/get_characters_list_bloc.dart';

class MockGetCharactersListRepository extends Mock
    implements IGetCharactersListRepository {}

void main() {
  group('GetCharactersListBloc Tests', () {
    late IGetCharactersListRepository mockRepository;
    late GetCharactersListBloc getCharactersListBloc;
    final params = CharacterListParams(nameStartsWith: 'Iron', orderBy: 'name');

    setUpAll(() {
      registerFallbackValue(params);
    });

    setUp(() {
      mockRepository = MockGetCharactersListRepository();
      getCharactersListBloc = GetCharactersListBloc(mockRepository);
    });

    tearDown(() {
      getCharactersListBloc.close();
    });

    test('initial state is EmptyState', () {
      expect(getCharactersListBloc.state, const EmptyState());
    });

    blocTest<GetCharactersListBloc, BaseState>(
      'emits [SuccessState] when getCharactersList is successful',
      build: () {
        when(() =>
                mockRepository.getCharactersList(params: any(named: 'params')))
            .thenAnswer(
          (_) async => ResultSuccess(
            [
              CharacterModel(id: 1, name: 'Iron Man'),
              CharacterModel(id: 2, name: 'Iron Fist')
            ],
          ),
        );
        return getCharactersListBloc;
      },
      act: (bloc) => bloc.getCharactersList(params: params),
      expect: () => [
        isA<SuccessState>(),
      ],
    );

    blocTest<GetCharactersListBloc, BaseState>(
      'emits [ErrorState] when getCharactersList fails',
      build: () {
        when(() =>
                mockRepository.getCharactersList(params: any(named: 'params')))
            .thenAnswer(
                (_) async => ResultError(BaseError('Failed to load data')));
        return getCharactersListBloc;
      },
      act: (bloc) => bloc.getCharactersList(params: params),
      expect: () => [
        isA<ErrorState>(),
      ],
    );

    blocTest<GetCharactersListBloc, BaseState>(
      'emits [SuccessState, SuccessState] when loading more characters is successful',
      build: () {
        when(() =>
                mockRepository.getCharactersList(params: any(named: 'params')))
            .thenAnswer((_) async => ResultSuccess([
                  CharacterModel(id: 3, name: 'Thor'),
                ]));
        return getCharactersListBloc;
      },
      act: (bloc) async {
        await bloc.getCharactersList(params: params);
        await bloc.getCharactersList(params: params, isLoadMore: true);
      },
      expect: () => [
        isA<SuccessState>(),
        isA<SuccessState>(),
      ],
    );

    blocTest<GetCharactersListBloc, BaseState>(
      'does not emit new states when already fetching',
      build: () {
        when(() =>
                mockRepository.getCharactersList(params: any(named: 'params')))
            .thenAnswer((_) async => Future.delayed(
                  const Duration(milliseconds: 100),
                  () => ResultSuccess([
                    CharacterModel(id: 1, name: 'Iron Man'),
                  ]),
                ));
        return getCharactersListBloc;
      },
      act: (bloc) async {
        bloc.getCharactersList(params: params);
        bloc.getCharactersList(params: params);
      },
      expect: () => [],
    );
  });
}
