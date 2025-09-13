import 'package:flutter/widgets.dart';
import 'api/client.dart';

class AppScope extends InheritedWidget {
  const AppScope({
    super.key,
    required this.api,
    required this.ticketsApi,
    required this.gachaApi,
    required super.child,
  });

  final ApiClient api;
  final ApiClient ticketsApi;
  final ApiClient gachaApi;

  static AppScope of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppScope>()!;

  @override
  bool updateShouldNotify(AppScope old) =>
      api != old.api ||
      ticketsApi != old.ticketsApi ||
      gachaApi != old.gachaApi;
}
