
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
        decoration: const BoxDecoration(color: Color(0xff333646)),
        accountName: Text(
          "Ramadan Mohamed",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: Colors.white),
        ),
        accountEmail: Text(
          "ramadan.work010@gmail.com",
          style: TextStyle(color: Colors.white60, fontSize: 11.5.sp),
        ),
        currentAccountPicture: ClipRRect(
          borderRadius: BorderRadius.circular(500),
          child: Image.asset(
            "assets/images/IMG_20211227_100504_auto_x2.jpg",
            fit: BoxFit.contain,
          ),
        ));
  }
}
