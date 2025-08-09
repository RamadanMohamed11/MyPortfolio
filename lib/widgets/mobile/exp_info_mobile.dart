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
          Expanded(
            child: Container(
              padding: EdgeInsets.all(7.sp),
              width: (MediaQuery.of(context).size.width - 10) / 2,
              decoration: BoxDecoration(
                  color: CustomColor.profileColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "1+",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.sp),
                      ),
                      Text(
                        "Years Experinced In Flutter",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.5.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "1+",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.sp),
                      ),
                      Text(
                        "Years Experinced In Embedded system",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.5.sp),
                      ),
                    ],
                  )
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "10+",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.sp),
                      ),
                      Text(
                        "Flutter Projects",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.5.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 35.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "10+",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.sp),
                      ),
                      Text(
                        "Embedded Projects",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13.5.sp),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/*


        


 */