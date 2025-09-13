import 'package:url_launcher/url_launcher.dart';

Future<void> openMap({
  required double lat,
  required double lng,
  String? label,
}) async {
  final comGoogleMaps = Uri.parse('comgooglemaps://?q=$lat,$lng');
  final encodedLabel = (label == null || label.isEmpty) ? '' : '(${Uri.encodeComponent(label)})';
  final geo = Uri.parse('geo:$lat,$lng?q=$lat,$lng$encodedLabel');
  final web = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');

  if (await canLaunchUrl(comGoogleMaps)) { await launchUrl(comGoogleMaps); return; }
  if (await canLaunchUrl(geo)) { await launchUrl(geo); return; }
  await launchUrl(web, mode: LaunchMode.externalApplication);
}

