import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/constants/colors.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({super.key, required this.isDesktop});
  final bool isDesktop;
  @override
  Widget build(BuildContext context) {
    return Text(
      "Welcome !",
      style: TextStyle(
          color: CustomColor.myYellow,
          fontWeight: FontWeight.bold,
          fontSize: isDesktop ? 8.sp : 24.sp,
          fontFamily: "Caveat"),
    );
  }
}
