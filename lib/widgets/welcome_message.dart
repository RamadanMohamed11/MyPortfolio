import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/constants/colors.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({super.key, this.isDesktop});
  final isDesktop;
  @override
  Widget build(BuildContext context) {
    return Text(
      "Welcome !",
      style: TextStyle(
          color: CustomColor.myYellow,
          fontWeight: FontWeight.bold,
          fontSize: isDesktop ? 6.sp : 22.sp),
    );
  }
}
