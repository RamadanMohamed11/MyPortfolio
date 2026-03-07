import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/constants/colors.dart';

/// The footer divider + "Made by…" text shared between desktop and mobile.
class FooterSection extends StatelessWidget {
  final double indent;
  final double endIndent;
  final double fontSize;

  const FooterSection({
    super.key,
    required this.indent,
    required this.endIndent,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: CustomColor.bgLighter2,
          thickness: 3.h,
          indent: indent,
          endIndent: endIndent,
          height: 35.h,
        ),
        SizedBox(height: 15.h),
        Text(
          "Made by Eng Ramadan Mohamed with Flutter",
          style: TextStyle(
            color: Colors.white38,
            fontWeight: FontWeight.w900,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
