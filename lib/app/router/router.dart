import 'package:auth_test/app/dependencies/dependencies.dart';
import 'package:auth_test/app/router/routes.dart';
import 'package:auth_test/repos/user_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../repos/task_repo.dart';
import '../../screens/any/any_screen.dart';
import '../../screens/auth/auth_screen.dart';
import '../../screens/auth/controller/user_bloc.dart';
import '../../screens/auth/controller/user_event.dart';
import '../../screens/create_task/create_task_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/plan/plan_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/settings/settings_screen.dart';
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
    redirect: (context, state) {
      final isAuthorized = getIt<UserRepository>().isAuth;
      final isOnAuthPage = state.fullPath == Routes.auth.path;

      if (!isAuthorized && !isOnAuthPage) {
        return Routes.auth.path;
      }

      if (isAuthorized && isOnAuthPage) {
        final userName = getIt<UserRepository>().currentName;
        context.read<UserBloc>().add(GetUserNameEvent());
        return Routes.tasks.path;
      }

      return null;
    },
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
                              TaskBloc(todoRepository: getIt<TodoRepository>())
                                ..add(LoadTasksEvent()),
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
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profile.path,
                name: Routes.profile.name,
                builder: (_, __) => const ProfileScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.any.path,
                name: Routes.any.name,
                builder: (_, __) => const AnyScreen(),
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
              create: (context) => getIt<TaskBloc>(),
              child: const CreateTaskScreen(),
            ),
      ),
      GoRoute(
        path: Routes.settings.path,
        name: Routes.settings.name,
        builder: (_, __) => const SettingsScreen(),
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
