class Env {
  static const apiBaseUrl = 'flutter-hackathon-production.up.railway.app:3000';
  static const ticketsBase =
      'flutter-hackathon-production.up.railway.app:3000/ticket/';
  static String _withSlash(String s) => s.endsWith('/') ? s : '$s/';
  static String get tickets => _withSlash(
    ticketsBase.isNotEmpty ? ticketsBase : '$apiBaseUrl/api/tickets',
  );
}
