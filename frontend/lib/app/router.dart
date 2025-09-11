import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../component/ui/navbar/navbar.dart';
import '../protected/top/index.dart';
import '../protected/map/index.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => _RootShell(child: child),
      routes: [
        GoRoute(path: '/', builder: (_, __) => const TopPage()),
        GoRoute(path: '/map', builder: (_, __) => const MapPage()),
      ],
    ),
    GoRoute(path: '/', redirect: (_, __) => '/'),
  ],
);

class _RootShell extends StatelessWidget {
  const _RootShell({super.key, required this.child});
  final Widget child;

  int _indexFromLocation(BuildContext context) {
    final loc = GoRouterState.of(context).uri.toString();
    if (loc.startsWith('/map')) return 0;
    return 1;
  }

  void _onTap(BuildContext context, int i) {
    switch (i) {
      case 0: context.go('/map'); break;
      case 1: context.go('/'); break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _indexFromLocation(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: NavBar(
        currentIndex: currentIndex,
        onTap: (i) => _onTap(context, i),
      ),
    );
  }
}

