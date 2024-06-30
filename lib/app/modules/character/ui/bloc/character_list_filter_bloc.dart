import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/states/base_page_state.dart';
import '../../data/model/params/character_list_params.dart';

abstract class ICharacterListFilterBloc extends Cubit<BaseState> {
  ICharacterListFilterBloc() : super(const EmptyState());

  String? tempNameStartsWith;
  String tempOrderBy = "name";

  String? nameStartsWith;
  String orderBy = "name";

  CharacterListParams createFiltersParams();

  void updateNameStartWithFilter({required String? value});
  void updateOrderByFilter({required String value});

  void applyFilters();
}

class CharacterListFilterBloc extends ICharacterListFilterBloc {
  CharacterListFilterBloc() : super();

  @override
  CharacterListParams createFiltersParams() => CharacterListParams(
        orderBy: orderBy,
        nameStartsWith: nameStartsWith,
      );

  void _emitCurrentState() => emit(
        ChangeState({
          "nameStartsWith": nameStartsWith,
          "orderBy": orderBy,
        }),
      );

  @override
  void updateNameStartWithFilter({required String? value}) =>
      tempNameStartsWith = value;

  @override
  void updateOrderByFilter({required String value}) => tempOrderBy = value;

  @override
  void applyFilters() {
    orderBy = tempOrderBy;
    nameStartsWith = tempNameStartsWith;

    _emitCurrentState();
  }
}
