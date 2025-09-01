import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/skill_items.dart';

class DesktopSkillsWidget extends StatefulWidget {
  const DesktopSkillsWidget({
    super.key,
    required this.navBarKeys,
    required this.screenSize,
  });

  final List<GlobalKey<State<StatefulWidget>>> navBarKeys;
  final Size screenSize;

  @override
  State<DesktopSkillsWidget> createState() => _DesktopSkillsWidgetState();
}

class _DesktopSkillsWidgetState extends State<DesktopSkillsWidget> {
  final List<double> _scale = List.generate(12, (_) => 1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(vertical: 5.h),
      key: widget.navBarKeys[3],
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: CustomColor.bgLighter1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "My Skills",
            style: TextStyle(fontSize: 9.5.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: widget.screenSize.width,
                ),
                child: Wrap(
                  children: [
                    for (int i = 0; i < mySkills.length; i++)
                      AnimatedScale(
                        duration: const Duration(milliseconds: 200),
                        scale: _scale[i],
                        child: MouseRegion(
                          onEnter: (_) => setState(() => _scale[i] = 1.1),
                          onExit: (_) => setState(() => _scale[i] = 1.0),
                          child: Container(
                            margin: const EdgeInsets.all(15),
                            width: 115.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(45),
                                color: CustomColor.bgLighter2),
                            child: Center(
                              child: ListTile(
                                isThreeLine: false,
                                leading: Image.asset(
                                  mySkills[i]["img"],
                                  //fit: BoxFit.cover,
                                  width: 25.w,
                                  height: 40.h,
                                ),
                                title: FittedBox(
                                  alignment: Alignment.centerLeft,
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    mySkills[i]["title"],
                                    style: TextStyle(fontSize: 5.7.sp),
                                  ),
                                ),
                              ),
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
    );
  }
}
