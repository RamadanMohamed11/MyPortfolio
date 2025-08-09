import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageAnimatedIcon extends StatelessWidget {
  const MessageAnimatedIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Animator(
      duration: const Duration(milliseconds: 1000),
      cycles: 0,
      curve: Curves.easeInOut,
      tween: Tween<double>(begin: 0.0, end: 35.0.h),
      builder: (context, animatorState, child) => Column(
        children: [
          SizedBox(
            height: animatorState.value * 5,
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.pink.withOpacity(.15),
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(Icons.message),
          ),
        ],
      ),
    );
  }
}
