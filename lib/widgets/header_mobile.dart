import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/widgets/welcome_message.dart';

class HeaderMobile extends StatelessWidget {
  final onTap;
  const HeaderMobile({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.sp),
      padding: EdgeInsets.all(5.sp),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(colors: [
            CustomColor.scaffoldColor,
            Color.fromARGB(255, 61, 64, 85)
          ])),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WelcomeMessage(
            isDesktop: false,
          ),
        ],
      ),
    );
  }
}
