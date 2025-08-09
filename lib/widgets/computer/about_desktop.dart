import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/constants/colors.dart';

class AboutDesktop extends StatelessWidget {
  const AboutDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 3.w, bottom: 5.h),
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: CustomColor.bgLighter1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About Me",
                  style: TextStyle(
                      color: CustomColor.myYellow,
                      decoration: TextDecoration.underline,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontFamily: "Caveat"),
                ),
                SizedBox(height: 5.h),
                Text(
                  textAlign: TextAlign.justify,
                  "Greetings!",
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    color: CustomColor.myYellow,
                    fontSize: 6.2.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                // Text(
                //   textAlign: TextAlign.justify,
                //   "I'm a third-year student at Assiut University's Faculty of Engineering, specializing in Computer and Control. My academic journey has equipped me with proficiency in C, C++, Electronics and Embedded system. Outside the classroom, I have experience in various technologies, including Arduino, Raspberry Pi, and Python, undertaking projects to enhance my practical skills. Currently, I'm engaged as a remote Flutter developer freelancer, balancing my passion for software development with my academic pursuits. I'm driven by a desire to continually expand my expertise and contribute meaningfully to the ever-evolving tech landscape.",
                //   overflow: TextOverflow.visible,
                //   style: TextStyle(
                //     color: const Color.fromARGB(185, 255, 255, 255),
                //     fontSize: 6.2.sp,
                //     fontWeight: FontWeight.w300,
                //   ),
                // ),

                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      "I have graduated from the Faculty of Engineering, Assiut University, specializing in Computer and Control. My academic journey has equipped me with proficiency in C, C++, Electronics and Embedded system. Outside the classroom, I have experience in various technologies, including Arduino, Raspberry Pi, and Python, undertaking projects to enhance my practical skills. Currently, I'm engaged as a remote Flutter developer freelancer, balancing my passion for software development with my academic pursuits. I'm driven by a desire to continually expand my expertise and contribute meaningfully to the ever-evolving tech landscape.",
                      textStyle: TextStyle(
                        color: const Color.fromARGB(185, 255, 255, 255),
                        fontSize: 6.2.sp,
                        fontWeight: FontWeight.w300,
                      ),
                      speed: const Duration(milliseconds: 50),
                      cursor: "|",
                    ),
                  ],
                  isRepeatingAnimation: false,
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ),
          Expanded(
            child: Image.asset(
              "assets/images/Elec.png",
              fit: BoxFit.fitHeight,
              width: 45.w,
            ),
          )
        ],
      ),
    );
  }
}
