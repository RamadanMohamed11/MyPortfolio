import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/header_list_items.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';
import 'package:my_portfolio/widgets/welcome_message.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:my_portfolio/utils/url_launcher.dart' as url_launcher;

class HeaderDesktop extends StatefulWidget {
  final Function(int) onNavMenuTap;
  final bool isloaded;
  const HeaderDesktop(
      {super.key, required this.onNavMenuTap, required this.isloaded});

  @override
  State<HeaderDesktop> createState() => _HeaderDesktopState();
}

class _HeaderDesktopState extends State<HeaderDesktop> {
  Color textColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PortfolioProvider>();

    if (widget.isloaded) {
      provider.setNavIndex(4);
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(0.5.sp),
      padding: EdgeInsets.all(2.5.sp),
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            CustomColor.mainSectionColor,
            Color.fromARGB(255, 11, 97, 172)
          ]),
          borderRadius: BorderRadius.circular(15)),
      child: Row(children: [
        const WelcomeMessage(
          isDesktop: true,
        ),
        SizedBox(width: 12.w),
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
                  fontSize: 8.sp,
                  fontFamily: 'Caveat'),
            ),
          ),
        ),
        const Spacer(),
        for (int i = 0; i < headerItems.length; i++)
          TextButton(
              onPressed: () {
                widget.onNavMenuTap(i);
                Future.delayed(const Duration(milliseconds: 100), () {
                  provider.setNavIndex(i);
                });
              },
              child: Shimmer.fromColors(
                baseColor: i == provider.navIndex ? textColor : Colors.white,
                highlightColor: Colors.grey.shade400,
                period: const Duration(milliseconds: 1500),
                enabled: i == provider.navIndex,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  style: TextStyle(
                      fontSize: i == provider.navIndex ? 6.5.sp : 5.2.sp,
                      fontWeight: i == provider.navIndex
                          ? FontWeight.bold
                          : FontWeight.w100),
                  child: Text(headerItems[i]),
                ),
              )),
      ]),
    );
  }
}
