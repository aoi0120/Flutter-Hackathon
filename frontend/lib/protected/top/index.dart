import 'package:flutter/material.dart';
import './_component/gacha/gacha.dart';
import './_component/gachabox/gachabox.dart';
import './_component/gachabar/gachabar.dart';
import './_component/gachabar/gachabar_styles.dart';
import './_component/itemButton/item_button.dart';
import '../../api/service/gacha_service.dart';
import '../../app_scope.dart';
import 'layout.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  bool _initialPlayed = false;
  bool _showCapsule = false;
  bool _isGachaLoading = false;
  String? _gachaResult;
  String? _gachaMessage;

  void _onHandleSpinDone() async {
    if (_isGachaLoading) return;

    setState(() {
      _isGachaLoading = true;
      _showCapsule = true;
    });

    try {
      final gachaService = GachaService(AppScope.of(context).gachaApi);
      final result = await gachaService.playGacha();

      print('ガチャ結果: $result');

      setState(() {
        _gachaResult = result['result']?.toString() ?? '外れ';
        _gachaMessage = result['message'] ?? 'ガチャ完了';
      });
    } catch (e) {
      print('ガチャ実行エラー: $e');
      setState(() {
        _gachaMessage = 'ガチャ実行に失敗しました: $e';
      });
    }
  }

  void _onCapsuleCompleted() {
    setState(() {
      _showCapsule = false;
      _isGachaLoading = false;
    });

    // 結果表示
    if (_gachaMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(_gachaMessage!)));
    }
  }

  String _gachaAnime() {
    if (_gachaResult == "当たり") {
      return "assets/data/gachaOk.json";
    } else {
      return "assets/data/gacha.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TopLayout.bgColor,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Center(
            child: GachaBox(
              onHandleSpinCompleted: _onHandleSpinDone,
              isDisabled: _isGachaLoading,
            ),
          ),
          if (!_initialPlayed)
            Center(
              child: Gacha(
                assetPath: 'assets/data/data.json',
                onCompleted: () => setState(() => _initialPlayed = true),
              ),
            ),
          if (_showCapsule)
            Center(
              child: Gacha(
                assetPath: _gachaAnime(),
                onCompleted: _onCapsuleCompleted,
              ),
            ),
          Positioned(
            bottom: BarStyles.bottomOffset,
            left: 0,
            right: 0,
            child: const GachaBar(),
          ),

          const ItemButton(),
        ],
      ),
    );
  }
}
