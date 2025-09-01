import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/constants/colors.dart';

class ExpInfoDesktop extends StatelessWidget {
  const ExpInfoDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170.h,
      decoration: const BoxDecoration(color: CustomColor.profileColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1+",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.sp),
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    "Years Experinced In Flutter",
                    textStyle:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 6.sp),
                    speed: const Duration(milliseconds: 150),
                    cursor: "|",
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ],
          ),
          VerticalDivider(
            color: CustomColor.bgLighter2,
            thickness: 0.6.w,
            indent: 30.h,
            endIndent: 30.h,
            width: 0.6.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "10+",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.sp),
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    "Flutter Projects",
                    textStyle:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 6.sp),
                    speed: const Duration(milliseconds: 150),
                    cursor: "|",
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
