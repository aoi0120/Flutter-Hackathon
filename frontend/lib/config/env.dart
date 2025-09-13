class Env {
  static const apiBaseUrl = 'http://127.0.0.1:8080';
  static const ticketsBase = '';   
  static String _withSlash(String s) => s.endsWith('/') ? s : '$s/';
  static String get tickets => _withSlash(ticketsBase.isNotEmpty ? ticketsBase : '$apiBaseUrl/api/tickets');
}

