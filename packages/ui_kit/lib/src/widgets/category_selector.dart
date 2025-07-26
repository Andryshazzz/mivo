import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../ui_kit.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final List<String> _defaultCategories = ['home', 'work'];
  final List<String> _customCategories = [];
  final Set<String> _selected = {};

  void _toggleCategory(String category) {
    setState(() {
      if (_selected.contains(category)) {
        _selected.remove(category);
      } else {
        _selected.add(category);
      }
    });
  }

  void _showAddCategoryDialog() {
    final controller = TextEditingController();

    showGeneralDialog(
      context: context,
      barrierLabel: "Add Category",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, _, __) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
          child: Center(
            child: AlertDialog(
              backgroundColor: context.colors.noirViolet,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text('Add Category'),
              content: TextField(
                controller: controller,
                maxLength: 16,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: const InputDecoration(
                  hintText: 'Enter category name',
                  counterText: '',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    final text = controller.text.trim();
                    if (text.isNotEmpty &&
                        !_customCategories.contains(text) &&
                        _defaultCategories.length + _customCategories.length <
                            6) {
                      setState(() {
                        _customCategories.add(text);
                      });
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = [..._defaultCategories, ..._customCategories];
    final canAdd = categories.length < 6;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        ...categories.map((category) {
          final isSelected = _selected.contains(category);
          return IntrinsicWidth(
            child: RoundSelectedButton(
              borderColor: isSelected
                  ? context.colors.lavenderEcho
                  : context.colors.lavenderEcho.withOpacity(0.2),
              onTap: () => _toggleCategory(category),
              label: category,
            ),
          );
        }),
        if (canAdd)
          IntrinsicWidth(
            child: RoundButton(
              icon: context.icons.plus,
              onTap: _showAddCategoryDialog,
            ),
          ),
      ],
    );
  }
}
