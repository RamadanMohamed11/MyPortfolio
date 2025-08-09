import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/pages/desktop/desktop_second_screen.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/pages/mobile/mobile_second_screen.dart';

void main() {
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatefulWidget {
  const MyPortfolio({super.key});

  @override
  State<MyPortfolio> createState() => _MyPortfolioState();
}

class _MyPortfolioState extends State<MyPortfolio> {
  bool _hasTransitioned = false; // Flag to track if transition occurred

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (_, child) {
      return MaterialApp(
          theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          title: "Ramadan Mohamed Portfolio",
          home: Scaffold(
            backgroundColor: CustomColor.scaffoldColor,
            body: LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return Center(
                  child: OpenContainer(
                    closedBuilder: (_, openContainer) {
                      if (!_hasTransitioned) {
                        _hasTransitioned = true; // Set the flag to true
                        Future.delayed(
                            const Duration(milliseconds: 2250), openContainer);
                      }

                      return Container(
                        decoration:
                            const BoxDecoration(color: CustomColor.bgLighter2),
                        width: MediaQuery.of(context).size.width / 2.4,
                        height: 495.h,
                        child: Image.asset(
                          "assets/images/2.png",
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                    closedElevation: 20,
                    closedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    transitionDuration: const Duration(milliseconds: 700),
                    openBuilder: (_, closeContainer) {
                      return const DesktopSecondScreen();
                    },
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Center(
                    child: OpenContainer(
                      closedBuilder: (_, openContainer) {
                        if (!_hasTransitioned) {
                          _hasTransitioned = true; // Set the flag to true
                          Future.delayed(const Duration(milliseconds: 2250),
                              openContainer);
                        }

                        return Container(
                          decoration: const BoxDecoration(
                              color: CustomColor.bgLighter2),
                          width: double.infinity,
                          height: 425.h,
                          child: Image.asset(
                            "assets/images/2.png",
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                      closedElevation: 20,
                      closedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      transitionDuration: const Duration(milliseconds: 700),
                      openBuilder: (_, closeContainer) {
                        return const MobileSecondScreen();
                      },
                    ),
                  ),
                );
              }
            }),
          ));
    });
  }
}
