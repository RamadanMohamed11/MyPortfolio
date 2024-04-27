import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/constants/colors.dart';

class HiMessageDesktop extends StatelessWidget {
  final Function(int) onNavMenuTap;
  const HiMessageDesktop({super.key, required this.onNavMenuTap});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width / 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi,",
                  style: TextStyle(
                      fontSize: 7.sp,
                      color: CustomColor.myYellow,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "I'm Ramadan Mohamed",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 7.2.sp),
                ),
                Text(
                  "A Computer Engineer & A Flutter Developer",
                  style:
                      TextStyle(fontSize: 7.2.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.h),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(60.w, 55.h),
                        backgroundColor: CustomColor.myYellow),
                    onPressed: () {
                      onNavMenuTap(0);
                    },
                    child: Text(
                      "Get In Touch",
                      style: TextStyle(color: Colors.white, fontSize: 6.5.sp),
                    )),
              ],
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width / 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2.4,
            height: 495.h,
            child: Image.asset(
              "assets/images/2.png",
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }
}
