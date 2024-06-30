import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mottu_marvel/app/core/result_wrapper/result_wrapper.dart';
import 'package:mottu_marvel/app/core/states/base_page_state.dart';
import 'package:mottu_marvel/app/modules/character/data/model/character_model.dart';
import 'package:mottu_marvel/app/modules/character/data/repositories/get_characters_associated_repository.dart';
import 'package:mottu_marvel/app/modules/character/ui/bloc/get_characters_associated_bloc.dart';

import '../../mock/character_mock.dart';

void main() {
  group('GetCharactersAssociatedBloc Tests', () {
    late IGetCharactersAssociatedRepository mockRepository;
    late GetCharactersAssociatedBloc getCharactersAssociatedBloc;
    final characterModel = CharacterModel();

    setUp(() {
      mockRepository = MockGetCharactersAssociatedRepository();
      getCharactersAssociatedBloc = GetCharactersAssociatedBloc(
        mockRepository,
      );
    });

    tearDown(() {
      getCharactersAssociatedBloc.close();
    });

    test('initial state is EmptyState', () {
      expect(getCharactersAssociatedBloc.state, const EmptyState());
    });

    blocTest<GetCharactersAssociatedBloc, BaseState>(
      'emits [LoadingState, SuccessState] when getCharactersList is successful',
      build: () {
        when(() => mockRepository.getCharactersAssociated(
                characterModel: characterModel))
            .thenAnswer((_) async => ResultSuccess([]));
        return getCharactersAssociatedBloc;
      },
      act: (bloc) =>
          bloc.getCharactersAssociated(characterModel: characterModel),
      expect: () => [const LoadingState(), isA<SuccessState>()],
    );

    blocTest<GetCharactersAssociatedBloc, BaseState>(
      'emits [LoadingState, ErrorState] when getCharactersList fails',
      build: () {
        when(() => mockRepository.getCharactersAssociated(
                characterModel: characterModel))
            .thenThrow(Exception('Failed to load data'));
        return getCharactersAssociatedBloc;
      },
      act: (bloc) =>
          bloc.getCharactersAssociated(characterModel: characterModel),
      expect: () => [const LoadingState(), isA<ErrorState>()],
    );
  });
}
