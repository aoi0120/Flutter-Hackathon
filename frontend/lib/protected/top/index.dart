import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'layout.dart';
import '../../component/ui/navbar/navbar.dart';
import '../../component/ui/ellipses/ellipses.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});
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
