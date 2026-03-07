import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/router/app_router.dart';
import 'package:shimmer/shimmer.dart';

/// Unified splash page that plays the original OpenContainer + welcome
/// animation, then navigates to [AppRoutes.home] via GoRouter.
///
/// This replaces the old `main.dart` splash + `DesktopSecondScreen` /
/// `MobileSecondScreen` two-step flow with a single route at `/`.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _showWelcome = false;
  bool _bgExpanded = false;

  @override
  void initState() {
    super.initState();

    // Phase 1 (0 ms): OpenContainer shows the logo image.
    // Phase 2 (2.25 s): OpenContainer expands to the welcome screen.
    // Phase 3 (2.25 + 1.5 s = 3.75 s): Welcome background expands.
    // Phase 4 (2.25 + 3.5 s = 5.75 s → trimmed to 4 s total): Navigate to /home.
    Timer(const Duration(milliseconds: 2250), () {
      if (mounted) setState(() => _showWelcome = true);
    });

    Timer(const Duration(milliseconds: 2750), () {
      if (mounted) setState(() => _bgExpanded = true);
    });

    Timer(const Duration(milliseconds: 4000), () {
      if (mounted) context.go(AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: CustomColor.scaffoldColor,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 700),
        child: _showWelcome
            ? _WelcomeScreen(
                key: const ValueKey('welcome'),
                bgExpanded: _bgExpanded,
                isDesktop: isDesktop,
              )
            : Center(
                key: const ValueKey('logo'),
                child: Container(
                  decoration:
                      const BoxDecoration(color: CustomColor.bgLighter2),
                  width: isDesktop
                      ? MediaQuery.of(context).size.width / 2.4
                      : MediaQuery.of(context).size.width - 30.w,
                  height: isDesktop ? 495.h : 425.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/images/2.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

/// The "Welcome To My Portfolio" screen that fades in after the logo.
class _WelcomeScreen extends StatelessWidget {
  final bool bgExpanded;
  final bool isDesktop;

  const _WelcomeScreen({
    super.key,
    required this.bgExpanded,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final fontSize = isDesktop ? 20.sp : 27.sp;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 2000),
            curve: Curves.fastLinearToSlowEaseIn,
            width: bgExpanded ? width : 0,
            height: height,
            color: Colors.black,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Shimmer.fromColors(
                  baseColor: CustomColor.myYellow,
                  highlightColor: Colors.white,
                  period: const Duration(milliseconds: 1000),
                  child: Text(
                    "Welcome ",
                    style: TextStyle(
                      color: CustomColor.myYellow,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                      fontFamily: "Caveat",
                    ),
                  ),
                ),
                Text(
                  'To My Portfolio',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    fontFamily: "Caveat",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
