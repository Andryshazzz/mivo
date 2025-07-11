import 'package:auth_test/screens/plan/plan_screen.dart';
import 'package:auth_test/screens/task/task_screen.dart';
import 'package:auth_test/screens/auth/auth_screen.dart';
import 'package:auth_test/screens/create_task/create_task_screen.dart';
import 'package:auth_test/screens/any/any_screen.dart';
import 'package:auth_test/screens/home/home_screen.dart';
import 'package:auto_route/auto_route.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: AuthRoute.page, initial: true),
    AutoRoute(
      page: HomeRoute.page,
      children: [
        AutoRoute(page: TaskRoute.page),
        AutoRoute(page: PlanRoute.page),
        AutoRoute(page: CreateTaskRoute.page),
        AutoRoute(page: AnyRoute.page),
      ],
    ),
  ];
}

// для зависимостей в будущем
//https://youtu.be/nn9gmFcEFM0?si=4qyO3PoZSiybT0Bs
// final _tabsNavigator = AutoRoute(
//     page: TabsWrapperRoute.pagem children: [_mainNavigator, ...]);

// final _mainNavigator = AutoRoute(page:
//   , children: [
//     AutoRoute(page: TaskRoute.page),
//   ],
// );
//
// final _lanNavigator = AutoRoute(
//     page: page, children: [AutoRoute(page: PlanRoute.page),]);
