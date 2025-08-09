
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/skill_items.dart';

class MobileSkillsWidget extends StatelessWidget {
  const MobileSkillsWidget({
    super.key,
    required this.navBarKeys,
    required this.screenSize,
  });

  final List<GlobalKey<State<StatefulWidget>>> navBarKeys;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            padding: EdgeInsets.symmetric(vertical: 5.h),
            key: navBarKeys[3],
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: CustomColor.bgLighter1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "My Skills",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: screenSize.width,
                      ),
                      child: Wrap(
                        children: [
                          for (int i = 0; i < mySkills.length; i++)
                            Container(
                              margin: const EdgeInsets.all(15),
                              width: 147.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(45),
                                  color: CustomColor.bgLighter2),
                              child: Center(
                                child: ListTile(
                                  isThreeLine: false,
                                  leading: Image.asset(
                                    mySkills[i]["img"],
                                    //fit: BoxFit.cover,
                                    width: 28.5.w,
                                    height: 47.h,
                                  ),
                                  title: Text(
                                    mySkills[i]["title"],
                                    style: TextStyle(fontSize: 13.sp),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
