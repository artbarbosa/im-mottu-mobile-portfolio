import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mottu_marvel/app/core/states/base_page_state.dart';
import 'package:mottu_marvel/app/modules/character/ui/bloc/character_list_filter_bloc.dart';

void main() {
  group('CharacterListFilterBloc Tests', () {
    late CharacterListFilterBloc characterListFilterBloc;

    setUp(() {
      characterListFilterBloc = CharacterListFilterBloc();
    });

    tearDown(() {
      characterListFilterBloc.close();
    });

    test('Initial State is EmptyState', () {
      expect(characterListFilterBloc.state, const EmptyState());
    });

    blocTest<CharacterListFilterBloc, BaseState>(
      'updateNameStartWithFilter updates tempNameStartsWith',
      build: () => characterListFilterBloc,
      act: (bloc) => bloc.updateNameStartWithFilter(value: 'Spider'),
      verify: (bloc) {
        expect(bloc.tempNameStartsWith, 'Spider');
      },
    );

    blocTest<CharacterListFilterBloc, BaseState>(
      'updateOrderByFilter updates tempOrderBy',
      build: () => characterListFilterBloc,
      act: (bloc) => bloc.updateOrderByFilter(value: 'modified'),
      verify: (bloc) {
        expect(bloc.tempOrderBy, 'modified');
      },
    );

    blocTest<CharacterListFilterBloc, BaseState>(
      'applyFilters updates orderBy and nameStartsWith and emits ChangeState',
      build: () => characterListFilterBloc,
      act: (bloc) {
        bloc.updateNameStartWithFilter(value: 'Spider');
        bloc.updateOrderByFilter(value: 'modified');
        bloc.applyFilters();
      },
      expect: () => [
        isA<ChangeState>(),
      ],
      verify: (bloc) {
        expect(bloc.orderBy, 'modified');
        expect(bloc.nameStartsWith, 'Spider');
      },
    );

    test('createFiltersParams returns correct CharacterListParams', () {
      characterListFilterBloc.updateNameStartWithFilter(value: 'Hulk');
      characterListFilterBloc.updateOrderByFilter(value: 'name');
      characterListFilterBloc.applyFilters();

      final params = characterListFilterBloc.createFiltersParams();
      expect(params.nameStartsWith, 'Hulk');
      expect(params.orderBy, 'name');
    });
  });
}
