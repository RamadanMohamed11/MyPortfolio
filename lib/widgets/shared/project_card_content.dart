import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/social_media.dart';
import 'package:my_portfolio/models/projects_info.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

/// The inner content of a project card, shared between desktop and mobile.
///
/// Desktop and mobile differ mainly in sizing and whether `Expanded` with flex
/// is used. This widget supports both modes via [useFlexLayout].
class ProjectCardContent extends StatelessWidget {
  final Project project;
  final double titleFontSize;
  final double subtitleFontSize;
  final double linkFontSize;
  final double iconSize;

  /// If true, uses `Expanded` with flex values (mobile style).
  /// If false, uses a fixed-height image and plain containers (desktop style).
  final bool useFlexLayout;

  /// Fixed height for the image container (desktop only, ignored when [useFlexLayout] is true).
  final double? imageHeight;

  /// Fixed width for the image container (desktop only).
  final double? imageWidth;

  /// Optional widget to replace the default GitHub icon button (for desktop hover animation).
  final Widget? customGitHubButton;

  const ProjectCardContent({
    super.key,
    required this.project,
    required this.titleFontSize,
    required this.subtitleFontSize,
    required this.linkFontSize,
    required this.iconSize,
    this.useFlexLayout = false,
    this.imageHeight,
    this.imageWidth,
    this.customGitHubButton,
  });

  @override
  Widget build(BuildContext context) {
    final image = ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        project.img,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        frameBuilder: (BuildContext context, Widget child, int? frame,
            bool wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) return child;
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: frame == null
                ? Shimmer.fromColors(
                    baseColor: CustomColor.bgLighter2,
                    highlightColor: Colors.white.withOpacity(0.5),
                    child: Container(color: Colors.white),
                  )
                : child,
          );
        },
      ),
    );

    final titleWidget = Padding(
      padding: EdgeInsets.all(4.0.sp),
      child: Text(
        project.title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: titleFontSize,
        ),
      ),
    );

    final subtitleWidget = Container(
      padding: EdgeInsets.all(4.0.sp),
      child: Text(
        project.subtitle,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white70,
          fontSize: subtitleFontSize,
        ),
      ),
    );

    final linkRow = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xff333646),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Row(
          children: [
            Text(
              "Link",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: linkFontSize,
                color: CustomColor.myYellow,
              ),
            ),
            const Spacer(),
            customGitHubButton ??
                IconButton(
                  onPressed: () {
                    launchUrl(
                      Uri.parse(project.gitHubLink),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  icon: Image.asset(socialMediaLinks[4].iconPath),
                  iconSize: iconSize,
                ),
          ],
        ),
      ),
    );

    if (useFlexLayout) {
      // Mobile layout — uses Expanded with flex
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 11, child: image),
          const Spacer(flex: 1),
          Expanded(flex: 1, child: titleWidget),
          Expanded(flex: 5, child: subtitleWidget),
          Expanded(flex: 1, child: linkRow),
          const Spacer(flex: 1),
        ],
      );
    } else {
      // Desktop layout — fixed height image, free-flowing content
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: imageHeight,
            width: imageWidth,
            child: image,
          ),
          titleWidget,
          Expanded(child: subtitleWidget),
          linkRow,
        ],
      );
    }
  }
}
