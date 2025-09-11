import 'package:go_router/go_router.dart';
import '../protected/top/index.dart';


final appRouter = GoRouter(
  routes: [
       GoRoute(path: '/', builder: (_, __) => const TopPage(),),
    // GoRoute(path: '/', builder: (_, __) => const ()),
    // GoRoute(path: '/', builder: (_, __) => const ()),
  ],
);

