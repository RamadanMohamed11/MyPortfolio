import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/constants/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.isMobile,
  });

  final void Function()? onPressed;
  final String title;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: isMobile ? Size(170.w, 50.h) : Size(60.w, 55.h),
          backgroundColor: CustomColor.myYellow),
      onPressed: onPressed,
      child: Text(
        title,
        style:
            TextStyle(color: Colors.white, fontSize: isMobile ? 17.sp : 6.5.sp),
      ),
    );
  }
}
