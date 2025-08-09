import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/constants/colors.dart';

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
            child: Text(
              "Hi,",
              style: TextStyle(
                  fontSize: 20.5.sp,
                  color: CustomColor.myYellow,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Caveat"),
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
              "A Computer Engineer & A Flutter Developer",
              style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 25.h),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(170.w, 50.h),
                    backgroundColor: CustomColor.myYellow),
                onPressed: () {
                  onNavMenuTap(0);
                },
                child: Text(
                  "Get In Touch",
                  style: TextStyle(color: Colors.white, fontSize: 17.sp),
                )),
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}
