import 'package:my_portfolio/utils/url_launcher_stub.dart'
    if (dart.library.html) 'package:my_portfolio/utils/url_launcher_web.dart';

Future<void> launch(String url) => launchUrl(url);
