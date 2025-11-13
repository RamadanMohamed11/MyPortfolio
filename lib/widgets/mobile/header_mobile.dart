import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/widgets/welcome_message.dart';
import 'package:my_portfolio/utils/url_launcher.dart' as url_launcher;
import 'package:shimmer/shimmer.dart';

class HeaderMobile extends StatelessWidget {
  final Function onTap;
  const HeaderMobile({super.key, required this.onTap});

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const WelcomeMessage(
            isDesktop: false,
          ),
          SizedBox(width: 10.w),
          InkWell(
            onTap: () {
              url_launcher.launch(
                  'http://ramadan-mohamed-electrical-portfolio.netlify.app');
            },
            child: Shimmer.fromColors(
              baseColor: CustomColor.myYellow,
              highlightColor: Colors.white,
              period: const Duration(milliseconds: 1500),
              child: Text(
                'Embedded System Portfolio',
                style: TextStyle(
                    color: CustomColor.myYellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                    fontFamily: 'Caveat'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
