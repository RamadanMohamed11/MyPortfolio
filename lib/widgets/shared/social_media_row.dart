import 'package:flutter/material.dart';

import 'package:my_portfolio/constants/social_media.dart';
import 'package:url_launcher/url_launcher.dart';

/// Renders a row of social-media icon buttons from [socialMediaLinks].
///
/// Desktop passes [enableHoverAnimation] = true plus [scales] and [onScaleChanged]
/// to drive the MouseRegion + AnimatedScale effect.
/// Mobile passes [enableHoverAnimation] = false (default).
class SocialMediaRow extends StatelessWidget {
  final double imageWidth;
  final double imageHeight;
  final bool enableHoverAnimation;

  /// Current scale values for each icon (only used when [enableHoverAnimation] is true).
  final List<double>? scales;

  /// Called with the index and new scale when hover state changes.
  final void Function(int index, double scale)? onScaleChanged;

  const SocialMediaRow({
    super.key,
    required this.imageWidth,
    required this.imageHeight,
    this.enableHoverAnimation = false,
    this.scales,
    this.onScaleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < socialMediaLinks.length; i++)
          Tooltip(
            message: "Open the link",
            child: enableHoverAnimation
                ? AnimatedScale(
                    scale:
                        scales != null && i < scales!.length ? scales![i] : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: MouseRegion(
                      onEnter: (_) => onScaleChanged?.call(i, 1.5),
                      onExit: (_) => onScaleChanged?.call(i, 1.0),
                      child: _buildIconButton(i),
                    ),
                  )
                : _buildIconButton(i),
          ),
      ],
    );
  }

  Widget _buildIconButton(int i) {
    final link = socialMediaLinks[i];
    return IconButton(
      onPressed: () {
        launchUrl(
          link.url,
          mode: LaunchMode.externalApplication,
        );
      },
      icon: Row(
        children: [
          Image.asset(
            link.iconPath,
            width: imageWidth,
            height: imageHeight,
          ),
        ],
      ),
    );
  }
}
