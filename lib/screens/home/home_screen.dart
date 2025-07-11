import 'package:auth_test/app/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [TaskRoute(), PlanRoute()],
      bottomNavigationBuilder: (_, tabRouter) {
        return BottomNavigationBar(
          currentIndex: tabRouter.activeIndex,
          onTap: tabRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Поиск'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Избранное',
            ),
          ],
        );
      },
    );
  }
}
