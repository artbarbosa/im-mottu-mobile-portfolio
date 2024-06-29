import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mottu_marvel/app/core/result_wrapper/result_wrapper.dart';
import 'package:mottu_marvel/app/core/states/base_page_state.dart';
import 'package:mottu_marvel/app/modules/character/data/repositories/get_character_list_repository.dart';
import 'package:mottu_marvel/app/modules/character/ui/bloc/get_characters_list_bloc.dart';

import '../../mock/character_mock.dart';

void main() {
  group('GetCharactersListBloc Tests', () {
    late IGetCharactersListRepository mockRepository;
    late GetCharactersListBloc getCharactersListBloc;

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
      'emits [LoadingState, SuccessState] when getCharactersList is successful',
      build: () {
        when(() => mockRepository.getCharactersList())
            .thenAnswer((_) async => ResultSuccess([]));
        return getCharactersListBloc;
      },
      act: (bloc) => bloc.getCharactersList(),
      expect: () => [const LoadingState(), isA<SuccessState>()],
    );

    blocTest<GetCharactersListBloc, BaseState>(
      'emits [LoadingState, ErrorState] when getCharactersList fails',
      build: () {
        when(() => mockRepository.getCharactersList())
            .thenThrow(Exception('Failed to load data'));
        return getCharactersListBloc;
      },
      act: (bloc) => bloc.getCharactersList(),
      expect: () => [const LoadingState(), isA<ErrorState>()],
    );
  });
}
