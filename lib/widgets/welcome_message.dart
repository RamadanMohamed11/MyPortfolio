import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({super.key, required this.isDesktop});
  final bool isDesktop;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: CustomColor.myYellow,
      highlightColor: Colors.white,
      period: const Duration(milliseconds: 1500),
      child: Hero(
        tag: 'welcome',
        child: Text(
          "Welcome !",
          style: TextStyle(
              color: CustomColor.myYellow,
              fontWeight: FontWeight.bold,
              fontSize: isDesktop ? 8.sp : 24.sp,
              fontFamily: "Caveat"),
        ),
      ),
    );
  }
}
