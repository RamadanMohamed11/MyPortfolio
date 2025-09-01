import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/constants/colors.dart';

class ExpInfoMobile extends StatelessWidget {
  const ExpInfoMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
            width: 5.w,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(7.sp),
              width: (MediaQuery.of(context).size.width - 10) / 2,
              decoration: BoxDecoration(
                  color: CustomColor.profileColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "1+",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    child: Text(
                      "Years Experinced In Flutter",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.5.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(7.sp),
              decoration: BoxDecoration(
                  color: CustomColor.profileColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "10+",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    child: Text(
                      "Flutter Projects",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13.5.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
        ],
      ),
    );
  }
}


/*


        


 */