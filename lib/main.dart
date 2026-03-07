import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';
import 'package:my_portfolio/router/app_router.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PortfolioProvider(),
      child: const MyPortfolio(),
    ),
  );
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (_, child) {
      return MaterialApp.router(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: "Ramadan Mohamed Portfolio",
        routerConfig: appRouter,
      );
    });
  }
}
