// lib/core/routing/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/analytics_screen.dart';
import '../../presentation/screens/history_detail_screen.dart';
import '../../presentation/screens/history_screen.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/parameters_screen.dart';
import '../../presentation/screens/result/result_screen.dart';

/// The application's route paths.
abstract class AppRoutes {
  static const home = '/';
  static const parameters = '/parameters';
  static const result = '/result';
  static const analytics = '/analytics';
  static const history = '/history';
  static const historyDetail = '/history/:id';
}

/// Creates and returns the [GoRouter] instance for the app.
/// Uses [StatefulShellRoute.indexedStack] to keep the BottomNavigationBar
/// visible on all main tab screens.
GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return _AppShell(navigationShell: navigationShell);
        },
        branches: [
          // ── Home tab ────────────────────────────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          // ── Parameters tab ──────────────────────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.parameters,
                name: 'parameters',
                builder: (context, state) => const ParametersScreen(),
              ),
            ],
          ),

          // ── Result tab ──────────────────────────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.result,
                name: 'result',
                builder: (context, state) => const ResultScreen(),
              ),
            ],
          ),

          // ── Analytics tab ───────────────────────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.analytics,
                name: 'analytics',
                builder: (context, state) => const AnalyticsScreen(),
              ),
            ],
          ),

          // ── History tab (with nested detail) ────────────────────
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.history,
                name: 'history',
                builder: (context, state) => const HistoryScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    name: 'historyDetail',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return HistoryDetailScreen(decisionId: id);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

/// The root scaffold that wraps every screen with a persistent
/// BottomNavigationBar provided by [StatefulShellRoute].
class _AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const _AppShell({required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tune_outlined),
            activeIcon: Icon(Icons.tune),
            label: 'Parametreler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: 'Sonuc',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Analiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: 'Gecmis',
          ),
        ],
      ),
    );
  }
}
