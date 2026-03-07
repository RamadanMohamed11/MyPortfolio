/// A social media link with an icon image asset and target URL.
class SocialMediaLink {
  final String iconPath;
  final String _url;

  /// Returns the URL as a parsed [Uri].
  Uri get url => Uri.parse(_url);

  const SocialMediaLink({required this.iconPath, required String url})
      : _url = url;
}
