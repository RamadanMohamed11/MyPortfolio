import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/constants/colors.dart';

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
              Text(
                "Years Experinced In Flutter",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 6.sp),
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
                "1+",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 7.sp),
              ),
              Text(
                "Years Experinced In Embedded system",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 6.sp),
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
              Text(
                "Flutter Projects",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 6.sp),
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
              Text(
                "Embedded Projects",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 6.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
