import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/states/base_page_state.dart';
import '../../data/model/params/character_list_paramns.dart';

abstract class ICharacterListFilterBloc extends Cubit<BaseState> {
  ICharacterListFilterBloc() : super(const EmptyState());

  String? tempName;
  String? tempOrderBy;

  String? name;
  String? orderBy;

  CharacterListParams createFiltersParams();

  void updateNameFilter({required String value});
  void updateOrderByFilter({required String value});

  void resetFilters();
  void applyFilters();
  void setFilters();
}

class CharacterListFilterBloc extends ICharacterListFilterBloc {
  CharacterListFilterBloc() : super();

  @override
  CharacterListParams createFiltersParams() {
    return CharacterListParams(
      orderBy: orderBy,
      name: name,
    );
  }

  void _emitCurrentState() {
    emit(ChangeState({
      "orderBy": orderBy,
      "name": name,
    }));
  }

  @override
  void updateNameFilter({required String value}) {
    if (tempName == value) {
      tempName = null;
    } else {
      tempName = value;
    }
    _emitCurrentState();
  }

  @override
  void updateOrderByFilter({required String value}) {
    if (tempOrderBy == value) {
      tempOrderBy = null;
    } else {
      tempOrderBy = value;
    }
    _emitCurrentState();
  }

  @override
  void resetFilters() {
    tempOrderBy = null;
    tempName = null;

    _emitCurrentState();
  }

  @override
  void applyFilters() {
    orderBy = tempOrderBy;
    name = tempName;

    emit(SuccessState({
      "name": name,
      "orderBy": orderBy,
    }));
  }

  @override
  void setFilters() {
    tempName = name;
    tempOrderBy = orderBy;
  }
}
