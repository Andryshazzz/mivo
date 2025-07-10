import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class CategoryTabBar extends StatefulWidget {
  const CategoryTabBar({super.key});

  @override
  State<CategoryTabBar> createState() => _CategoryTabBarState();
}

class _CategoryTabBarState extends State<CategoryTabBar> {
  final ScrollController _scrollController = ScrollController();
  final List<String> categories = [
    'All task',
    'Home',
    'Education',
    'Buy',
    'Work'
  ];
  int selectedIndex = 0;

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
                onTap: () {
                  setState(() => selectedIndex = index);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? context.colors.lavenderEcho
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    categories[index],
                    style: context.theme.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? context.colors.white
                          : context.colors.gray.withOpacity(0.6),
                      fontWeight: FontWeight.w600,
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
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.transparent,
                    context.colors.noirViolet.withOpacity(0.9),
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
