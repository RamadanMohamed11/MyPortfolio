import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/header_list_items.dart';
import 'package:portfolio/widgets/welcome_message.dart';

class HeaderDesktop extends StatefulWidget {
  final Function(int) onNavMenuTap;
  const HeaderDesktop({super.key, required this.onNavMenuTap});

  @override
  State<HeaderDesktop> createState() => _HeaderDesktopState();
}

class _HeaderDesktopState extends State<HeaderDesktop> {
  Color textColor = Colors.red;
  int numberOfText = 3;
  @override
  Widget build(BuildContext context) {
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
        const Spacer(),
        for (int i = 0; i < headerItems.length; i++)
          TextButton(
              onPressed: () {
                widget.onNavMenuTap(i);
                setState(() {
                  numberOfText = i;
                });
              },
              child: Text(
                headerItems[i],
                style: TextStyle(
                    color: i == numberOfText ? textColor : Colors.white,
                    fontSize: i == numberOfText ? 6.5.sp : 5.2.sp,
                    fontWeight:
                        i == numberOfText ? FontWeight.bold : FontWeight.w100),
              )),
      ]),
    );
  }
}
