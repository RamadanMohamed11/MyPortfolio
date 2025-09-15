import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/pages/desktop/desktop_home_page.dart';
import 'package:my_portfolio/test.dart';
import 'package:shimmer/shimmer.dart';

class DesktopSecondScreen extends StatefulWidget {
  const DesktopSecondScreen({super.key});
  @override
  _DesktopSecondScreenState createState() => _DesktopSecondScreenState();
}

class _DesktopSecondScreenState extends State<DesktopSecondScreen> {
  bool _a = false;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        _a = !_a;
      });
    });
    Timer(const Duration(milliseconds: 4000), () {
      Navigator.of(context).pushAndRemoveUntil(
        SlideTransitionAnimation(const ComputerHomePage()),
        (Route<dynamic> route) => false, // This removes all the previous routes
      );
    });
  }

  @override
  void dispose() {
// TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 2000),
            curve: Curves.fastLinearToSlowEaseIn,
            width: _a ? width : 0,
            height: height,
            color: Colors.black,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Shimmer.fromColors(
                  baseColor: CustomColor.myYellow,
                  highlightColor: Colors.white,
                  period: const Duration(milliseconds: 1000),
                  child: Hero(
                    tag: 'welcome',
                    child: Text(
                      "Welcome ",
                      style: TextStyle(
                          color: CustomColor.myYellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          fontFamily: "Caveat"),
                    ),
                  ),
                ),
                Text(
                  'To My Portfolio',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      fontFamily: "Caveat"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
