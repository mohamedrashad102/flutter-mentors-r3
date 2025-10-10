import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_text_field.dart';

class HomeSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const HomeSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      labelText: 'Search products...',
      prefixIcon: const Icon(Icons.search),
      suffixIcon: controller.text.isNotEmpty
          ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                controller.clear();
                onSearch('');
              },
            )
          : null,
      onFieldSubmitted: onSearch,
    );
  }
}
