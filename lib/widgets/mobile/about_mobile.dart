import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/constants/colors.dart';

class AboutMobile extends StatelessWidget {
  const AboutMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: CustomColor.bgLighter1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "About Me",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: CustomColor.myYellow,
                decoration: TextDecoration.underline,
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontFamily: "Caveat"),
          ),
          SizedBox(height: 15.h),
          Image.asset(
            "assets/images/Elec.png",
            fit: BoxFit.contain,
          ),
          Text(
            "Greetings! I have graduated from the Faculty of Engineering, Assiut University, specializing in Computer and Control. My academic journey has equipped me with proficiency in C, C++, Electronics and Embedded system. Outside the classroom, I have experience in various technologies, including Arduino, Raspberry Pi, and Python, undertaking projects to enhance my practical skills. Currently, I'm engaged as a remote Flutter developer freelancer, balancing my passion for software development with my academic pursuits. I'm driven by a desire to continually expand my expertise and contribute meaningfully to the ever-evolving tech landscape.",
            overflow: TextOverflow.visible,
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: const Color.fromARGB(190, 255, 255, 255),
              fontSize: 13.6.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
