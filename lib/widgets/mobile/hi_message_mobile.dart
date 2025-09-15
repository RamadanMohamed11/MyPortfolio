import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/utils/url_launcher.dart' as url_launcher;
import 'package:my_portfolio/widgets/custom_elevated_button.dart';
import 'package:shimmer/shimmer.dart';

class HiMessageMobile extends StatelessWidget {
  const HiMessageMobile({super.key, required this.onNavMenuTap});
  final Function(int) onNavMenuTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 550.h,
            child: Image.asset(
              "assets/images/2.png",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 25.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Shimmer.fromColors(
              baseColor: CustomColor.myYellow,
              highlightColor: Colors.white,
              child: Text(
                "Hi,",
                style: TextStyle(
                    fontSize: 20.5.sp,
                    color: CustomColor.myYellow,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Caveat"),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Text(
              "I'm Ramadan Mohamed",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.sp),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Text(
              "Flutter Developer & Embedded Systems Engineer",
              style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 25.h),
          Center(
            child: CustomElevatedButton(
                onPressed: getInTouchOnPressed,
                title: "Get In Touch",
                isMobile: true),
          ),
          SizedBox(height: 15.h),
          Center(
            child: CustomElevatedButton(
                onPressed: downloadMyCvOnPressed,
                title: "Download My CV",
                isMobile: true),
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }

  void getInTouchOnPressed() {
    onNavMenuTap(0);
  }

  void downloadMyCvOnPressed() {
    url_launcher.launch('assets/Ramadan_Mohamed_CV.pdf');
  }
}
