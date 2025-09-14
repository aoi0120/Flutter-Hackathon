import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';

String _fmt(double n) => n.toStringAsFixed(6);

Future<void> openMap({
  required double lat,
  required double lng,
  String? label,
}) async {
  final la = _fmt(lat);
  final ln = _fmt(lng);
  final hasLabel = label != null && label.trim().isNotEmpty;
  final encLabel = hasLabel ? Uri.encodeComponent(label!.trim()) : null;

  final gmParams = {
    'q': hasLabel ? '$encLabel@$la,$ln' : '$la,$ln',
    'zoom': '16',
  };
  final comGoogleMaps = Uri(
    scheme: 'comgooglemaps',
    host: '',
    queryParameters: gmParams,
  );

  final geoQuery =
      hasLabel ? '$la,$ln($encLabel)' : '$la,$ln';
  final geo = Uri.parse('geo:0,0?q=$geoQuery');

 maps:
  final appleMaps = Uri(
    scheme: 'maps',
    host: '',
    queryParameters: hasLabel
        ? {'q': label!.trim(), 'll': '$la,$ln'}
        : {'ll': '$la,$ln'},
  );

  final web = Uri.https('www.google.com', '/maps/search/', {
    'api': '1',
    'query': '$la,$ln',
  });

  if (await canLaunchUrl(comGoogleMaps)) {
    await launchUrl(comGoogleMaps, mode: LaunchMode.externalApplication);
    return;
  }

  if (Platform.isAndroid) {
    if (await canLaunchUrl(geo)) {
      await launchUrl(geo, mode: LaunchMode.externalApplication);
      return;
    }
  } else if (Platform.isIOS) {
    if (await canLaunchUrl(appleMaps)) {
      await launchUrl(appleMaps, mode: LaunchMode.externalApplication);
      return;
    }
  }

  await launchUrl(web, mode: LaunchMode.externalApplication);
}

