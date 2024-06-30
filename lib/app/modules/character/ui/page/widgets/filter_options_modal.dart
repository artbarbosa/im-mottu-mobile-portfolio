import 'package:flutter/material.dart';

import '../../bloc/character_list_filter_bloc.dart';

class FilterOptionsModal extends StatelessWidget {
  final ICharacterListFilterBloc characterListFilterBloc;

  const FilterOptionsModal({super.key, required this.characterListFilterBloc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Order By',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            value: characterListFilterBloc.orderBy,
            items: const [
              DropdownMenuItem(
                value: 'name',
                child: Text('Name (Ascending)'),
              ),
              DropdownMenuItem(
                value: '-name',
                child: Text('Name (Descending)'),
              ),
              DropdownMenuItem(
                value: 'modified',
                child: Text('Modified (Ascending)'),
              ),
              DropdownMenuItem(
                value: '-modified',
                child: Text('Modified (Descending)'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                characterListFilterBloc.updateOrderByFilter(value: value);
                characterListFilterBloc.applyFilters();
                Navigator.pop(context);
              }
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
