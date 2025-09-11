import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'layout.dart';
import '../../component/ui/navbar/navbar.dart';
import '../../component/ui/ellipses/ellipses.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});
  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  int _indexFromLocation(BuildContext context) {
    final loc = GoRouterState.of(context).uri.toString();
    if (loc.startsWith('/')) return 1;
    if (loc.startsWith('/')) return 2;
    return 0;
  }

  void _onBottomTap(int i) {
    switch (i) {
      case 0:
        context.go('/');
        break;
      //TODO: ルーティングの設定
      case 1:
        // context.go('/');
        break;
      case 2:
        // context.go('/');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _indexFromLocation(context);

    // flutterのデフォルト
    return Scaffold(
      backgroundColor: TopLayout.bgColor,
      body: const SizedBox.shrink(),
      ellipsesButton: EllipsesButton(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            _onBottomTap(index);
          });
        },
      ),
      bottomNavigationBar: AppNavBar(
        currentIndex: currentIndex,
        onTap: _onBottomTap,
      ),
    );
  }
}
