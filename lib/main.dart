import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/pages/home_page.dart';

void main() {
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (_, child) {
      return MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: "Ramadan Mohamed Portfolio",
        home: const HomePage(),
      );
    });
  }
}
