import 'package:flutter/material.dart';

class SearchComponents extends StatelessWidget {
  const SearchComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      textInputAction: TextInputAction.done,
      hintText: 'ค้นหา',
      leading: const Icon(Icons.search),
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}
