import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:my_portfolio/constants/colors.dart';

/// A centered loading indicator used by both desktop and mobile pages.
class LoadingIndicatorWidget extends StatelessWidget {
  /// Divisor applied to screen width for the indicator width.
  final double widthDivisor;

  /// Divisor applied to screen height for the indicator height.
  final double heightDivisor;

  const LoadingIndicatorWidget({
    super.key,
    this.widthDivisor = 7,
    this.heightDivisor = 2.7,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width / widthDivisor,
          height: MediaQuery.sizeOf(context).height / heightDivisor,
          child: const LoadingIndicator(
            indicatorType: Indicator.triangleSkewSpin,
            colors: [CustomColor.myYellow],
            backgroundColor: CustomColor.scaffoldColor,
            pathBackgroundColor: CustomColor.myYellow,
          ),
        ),
      ),
    );
  }
}
