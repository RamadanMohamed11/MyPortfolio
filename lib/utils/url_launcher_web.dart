import 'dart:html' as html;

Future<void> launchUrl(String url) async {
  html.window.open(url, '_blank');
}
