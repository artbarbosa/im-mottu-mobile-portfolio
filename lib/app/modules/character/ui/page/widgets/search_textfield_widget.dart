import 'package:flutter/material.dart';

import '../../bloc/character_list_filter_bloc.dart';

class SearchTextFieldWidget extends StatelessWidget {
  final ICharacterListFilterBloc characterListFilterBloc;

  const SearchTextFieldWidget({
    super.key,
    required this.characterListFilterBloc,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        if (value.isEmpty && characterListFilterBloc.nameStartsWith != null) {
          characterListFilterBloc.updateNameStartWithFilter(value: null);
          characterListFilterBloc.applyFilters();
        }
      },
      onSubmitted: (value) {
        characterListFilterBloc.updateNameStartWithFilter(value: value);
        characterListFilterBloc.applyFilters();
      },
      decoration: InputDecoration(
        hintText: "Search characters",
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
    );
  }
}
