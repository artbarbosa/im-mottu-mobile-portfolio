import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/states/base_page_state.dart';
import '../../data/model/character_model.dart';
import '../../data/repositories/get_characters_associated_repository.dart';

abstract class IGetCharactersAssociatedBloc extends Cubit<BaseState> {
  IGetCharactersAssociatedBloc() : super(const EmptyState());

  Future<void> getCharactersAssociated({
    required CharacterModel characterModel,
  });
}

class GetCharactersAssociatedBloc extends IGetCharactersAssociatedBloc {
  final IGetCharactersAssociatedRepository repository;

  GetCharactersAssociatedBloc(this.repository);

  @override
  Future<void> getCharactersAssociated({
    required CharacterModel characterModel,
  }) async {
    emit(const LoadingState());
    try {
      final result = await repository.getCharactersAssociated(
        characterModel: characterModel,
      );
      emit(SuccessState(result.getSuccessData));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
