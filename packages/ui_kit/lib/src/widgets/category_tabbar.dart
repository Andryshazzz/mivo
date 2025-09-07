import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class CategoryTabBar extends StatefulWidget {
  final ValueChanged<String> onCategorySelected;
  final String selectedCategory;

  const CategoryTabBar(
      {super.key,
      required this.onCategorySelected,
      required this.selectedCategory});

  @override
  State<CategoryTabBar> createState() => _CategoryTabBarState();
}

class _CategoryTabBarState extends State<CategoryTabBar> {
  final ScrollController _scrollController = ScrollController();
  final List<String> categories = [
    'All task',
    'Home',
    'Work',
    'Еще фильтр',
    'Еще фильтр',
    'Еще фильтр',
  ];
  int selectedIndex = 0;

  void _selectCategory(int index) {
    setState(() => selectedIndex = index);
    widget.onCategorySelected(categories[index]);
  }

  @override
  void didUpdateWidget(covariant CategoryTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedCategory != oldWidget.selectedCategory) {
      final newIndex = categories.indexOf(widget.selectedCategory);
      if (newIndex != -1 && newIndex != selectedIndex) {
        setState(() => selectedIndex = newIndex);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 40,
          child: ListView.separated(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () => _selectCategory(index),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? context.colors.lavenderEcho
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Text(
                      categories[index],
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        color: isSelected
                            ? context.colors.white
                            : context.colors.gray.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          width: 32,
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.transparent,
                    context.colors.background.withValues(alpha: 0.9),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
