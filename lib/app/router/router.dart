import 'package:auth_test/app/dependencies/dependencies.dart';
import 'package:auth_test/app/router/routes.dart';
import 'package:db/db/db.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../repos/task_repo.dart';
import '../../screens/auth/auth_screen.dart';
import '../../screens/create_task/create_task_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/plan/plan_screen.dart';
import '../../screens/task/controller/task_bloc.dart';
import '../../screens/task/task_screen.dart';

final GlobalKey<NavigatorState> _rootKey = GlobalKey<NavigatorState>();

class Observer extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    final focus = FocusManager.instance.primaryFocus;
    focus?.unfocus();
  }
}

final class AppRouter {
  AppRouter._();

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootKey,
    observers: [Observer()],
    debugLogDiagnostics: kDebugMode,
    initialLocation: Routes.auth.path,
    routes: [
      GoRoute(
        path: Routes.auth.path,
        name: Routes.auth.name,
        builder: (_, __) => const AuthScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder:
            (_, __, navigationShell) =>
                HomeScreen(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.tasks.path,
                name: Routes.tasks.name,
                builder:
                    (context, state) => BlocProvider(
                      create:
                          (context) =>
                              TaskBloc(repo: getIt<TodoRepository>())
                                ..add(LoadTodos()),
                      child: const TaskScreen(),
                    ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.plan.path,
                name: Routes.plan.name,
                builder: (_, __) => const PlanScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: Routes.create.path,
        name: Routes.create.name,
        builder:
            (context, state) => BlocProvider(
              create: (context) => TaskBloc(repo: getIt<TodoRepository>()),
              child: const CreateTaskScreen(),
            ),
      ),
    ],
  );
}

class HomeScreenWrapper extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomeScreenWrapper({required this.navigationShell, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: const BottomAppBar(),
    );
  }
}
