import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/constants/colors.dart';

class CustomElevatedButton extends StatefulWidget {
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
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: widget.isMobile ? Size(170.w, 50.h) : Size(60.w, 55.h),
              backgroundColor: _isHovered
                  ? Color.lerp(CustomColor.myYellow, Colors.white, 0.1)
                  : CustomColor.myYellow,
              elevation: _isHovered ? 8 : 2,
              shadowColor: CustomColor.myYellow.withOpacity(0.5)),
          onPressed: widget.onPressed,
          child: Text(
            widget.title,
            style: TextStyle(
                color: Colors.white,
                fontSize: widget.isMobile ? 17.sp : 6.5.sp),
          ),
        ),
      ),
    );
  }
}
