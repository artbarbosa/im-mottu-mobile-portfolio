import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/states/base_page_state.dart';
import '../../data/model/character_model.dart';
import '../../data/model/params/character_list_params.dart';
import '../../data/repositories/get_character_list_repository.dart';

abstract class IGetCharactersListBloc extends Cubit<BaseState> {
  IGetCharactersListBloc() : super(const EmptyState());
  final int limit = 50;
  int offset = 0;

  bool get isFetching;

  Future<void> getCharactersList({
    required CharacterListParams params,
    bool isLoadMore = false,
  });
}

class GetCharactersListBloc extends IGetCharactersListBloc {
  final IGetCharactersListRepository repository;
  bool _isFetching = false;

  @override
  bool get isFetching => _isFetching;

  GetCharactersListBloc(this.repository);

  @override
  Future<void> getCharactersList({
    required CharacterListParams params,
    bool isLoadMore = false,
  }) async {
    if (_isFetching) return;
    _isFetching = true;
    try {
      if (!isLoadMore) offset = 0;

      final result = await repository.getCharactersList(
        params: params.copyWith(
          offset: offset,
          limit: limit,
        ),
      );

      final newCharacters = result.getSuccessData;
      offset += limit;

      if (isLoadMore) {
        final currentState = state;
        if (currentState is SuccessState) {
          final existingCharacters = currentState.data as List<CharacterModel>;

          for (var character in newCharacters) {
            if (!existingCharacters.any(
                (existingCharacter) => existingCharacter.id == character.id)) {
              existingCharacters.add(character);
            }
          }

          if (existingCharacters.isNotEmpty) {
            emit(SuccessState(existingCharacters));
          }
          return;
        }
      } else {
        if (newCharacters.isNotEmpty) {
          emit(SuccessState(newCharacters));
        }
        return;
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
      return;
    } finally {
      _isFetching = false;
    }
  }
}
