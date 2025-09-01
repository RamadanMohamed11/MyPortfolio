import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/utils/url_launcher.dart' as url_launcher;
import 'package:my_portfolio/widgets/custom_elevated_button.dart';

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
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText("Hi,",
                        textStyle: TextStyle(
                            fontSize: 8.sp,
                            color: CustomColor.myYellow,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Caveat"),
                        cursor: "|",
                        speed: const Duration(milliseconds: 250)),
                  ],
                  isRepeatingAnimation: false,
                ),
                // Text(
                //   "Hi,",
                //   style: TextStyle(
                //       fontSize: 8.sp,
                //       color: CustomColor.myYellow,
                //       fontWeight: FontWeight.bold,
                //       fontFamily: "Caveat"),
                // ),

                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText("I'm Ramadan Mohamed",
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 7.2.sp,
                        ),
                        cursor: "|",
                        speed: const Duration(milliseconds: 200)),
                  ],
                  isRepeatingAnimation: false,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                          "Flutter Developer & Embedded Systems Engineer",
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 7.2.sp,
                          ),
                          cursor: "|",
                          speed: const Duration(milliseconds: 100)),
                    ],
                    isRepeatingAnimation: false,
                  ),
                ),
                // Text(
                //   "I'm Ramadan Mohamed",
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold,
                //     fontSize: 7.2.sp,
                //   ),
                // ),
                // Text(
                //   "A Computer Engineer & A Flutter Developer",
                //   style: TextStyle(
                //     fontSize: 7.2.sp,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    CustomElevatedButton(
                        onPressed: getInTouchOnPressed,
                        title: "Get In Touch",
                        isMobile: false),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //       minimumSize: Size(60.w, 55.h),
                    //       backgroundColor: CustomColor.myYellow),
                    //   onPressed: getInTouchOnPressed,
                    //   child: AnimatedTextKit(
                    //     animatedTexts: [
                    //       TypewriterAnimatedText("Get In Touch",
                    //           textStyle: TextStyle(
                    //               color: Colors.white, fontSize: 6.5.sp),
                    //           cursor: "|",
                    //           speed: const Duration(milliseconds: 250)),
                    //     ],
                    //     isRepeatingAnimation: false,
                    //   ),
                    // ),
                    const Spacer(),
                    CustomElevatedButton(
                      title: "Download My CV",
                      onPressed: downloadMyCvOnPressed,
                      isMobile: false,
                    ),
                  ],
                )
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

  void getInTouchOnPressed() {
    onNavMenuTap(0);
  }

  void downloadMyCvOnPressed() {
    url_launcher.launch('assets/Ramadan_Mohamed_CV.pdf');
  }
}
