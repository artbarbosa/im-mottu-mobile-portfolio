import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/states/base_page_state.dart';
import '../../data/model/params/character_list_paramns.dart';
import '../../data/repositories/get_character_list_repository.dart';

abstract class IGetCharactersListBloc extends Cubit<BaseState> {
  IGetCharactersListBloc() : super(const EmptyState());

  Future<void> getCharactersList({required CharacterListParams params});
}

class GetCharactersListBloc extends IGetCharactersListBloc {
  final IGetCharactersListRepository repository;

  GetCharactersListBloc(this.repository);

  @override
  Future<void> getCharactersList({required CharacterListParams params}) async {
    emit(const LoadingState());
    try {
      final result = await repository.getCharactersList(params: params);
      emit(SuccessState(result.getSuccessData));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
