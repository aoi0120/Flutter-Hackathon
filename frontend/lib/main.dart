// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/router.dart';
import 'auth.dart';
import 'config/env.dart';
import 'api/client.dart';
import 'app_scope.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await initAuth();

  final api = ApiClient(baseUrl: Env.apiBaseUrl);
  final ticketsApi = ApiClient(baseUrl: Env.tickets);

  runApp(
    AppScope(api: api, ticketsApi: ticketsApi, child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}

