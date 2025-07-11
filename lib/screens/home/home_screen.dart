import 'package:auth_test/app/router/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        final currentIndex = tabRouter.activeIndex;
        return BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: tabRouter.setActiveIndex,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                context.icons.tasks,
                colorFilter: ColorFilter.mode(
                  currentIndex == 0
                      ? context.colors.lavenderEcho
                      : context.colors.gray.withOpacity(0.6),
                  BlendMode.srcIn,
                ),
                height: 22,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                context.icons.plan,
                colorFilter: ColorFilter.mode(
                  currentIndex == 1
                      ? context.colors.lavenderEcho
                      : context.colors.gray.withOpacity(0.6),
                  BlendMode.srcIn,
                ),
                height: 22,
              ),
              label: '',
            ),
          ],
        );
      },
    );
  }
}
