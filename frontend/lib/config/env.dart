class Env {
  static const apiBaseUrl =
      'https://flutter-hackathon-production.up.railway.app';
  static const ticketsBase =
      'https://flutter-hackathon-production.up.railway.app/api/user/';
  static String _withSlash(String s) => s.endsWith('/') ? s : '$s/';
  static String get tickets =>
      _withSlash(ticketsBase.isNotEmpty ? ticketsBase : '$apiBaseUrl/api/user');
}
