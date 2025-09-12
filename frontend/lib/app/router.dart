import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../auth.dart';

import '../component/ui/navbar/navbar.dart';
import '../protected/top/index.dart';
import '../protected/map/index.dart';
import '../protected/settings/index.dart';
import '../login/general_login.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  refreshListenable: auth,
  redirect: (context, state) {
    final isLoggedIn = auth.value;
    final goingLogin = state.matchedLocation.contains('/login');
    if (!isLoggedIn && !goingLogin) return '/login';
    if (isLoggedIn && goingLogin) return '/';
    return null;
  },
  routes: [
    GoRoute(path: '/login', builder: (_, __) => const GeneralLogin()),
    ShellRoute(
      builder: (context, state, child) => _RootShell(child: child),
      routes: [
        GoRoute(path: '/', builder: (_, __) => const TopPage()),
        GoRoute(path: '/map', builder: (_, __) => const MapPage()),
        GoRoute(path: '/settings', builder: (_, __) => const SettingPage()),
      ],
    ),
  ],
);

class _RootShell extends StatelessWidget {
  const _RootShell({required this.child});
  final Widget child;

  int _indexFromLocation(BuildContext context) {
    final loc = GoRouterState.of(context).uri.toString();
    if (loc.startsWith('/map')) return 0;
    if (loc.startsWith('/settings')) return 2;
    return 1;
  }

  void _onTap(BuildContext context, int i) {
    switch (i) {
      case 0:
        context.go('/map');
        break;
      case 1:
        context.go('/');
        break;
      case 2:
        context.go('/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _indexFromLocation(context);
    final loc = GoRouterState.of(context).uri.toString();
    final isTop = loc == '/';
    return Scaffold(
      body: isTop ? child : SafeArea(child: child),
      bottomNavigationBar: NavBar(
        currentIndex: currentIndex,
        onTap: (i) => _onTap(context, i),
      ),
    );
  }
}
