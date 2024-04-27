import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/header_list_items.dart';
import 'package:portfolio/constants/skill_items.dart';
import 'package:portfolio/constants/social_media.dart';
import 'package:portfolio/widgets/about_desktop.dart';
import 'package:portfolio/widgets/about_mobile.dart';
import 'package:portfolio/widgets/exp_info_desktop.dart';
import 'package:portfolio/widgets/exp_info_mobile.dart';
import 'package:portfolio/widgets/header_desktop.dart';
import 'package:portfolio/widgets/header_mobile.dart';
import 'package:portfolio/widgets/hi_message_desktop.dart';
import 'package:portfolio/widgets/hi_message_mobile.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void onMenuTap() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final myScrollController = ScrollController();
  final List<GlobalKey> navBarKeys = List.generate(4, (index) => GlobalKey());
  void onNavItemTap(int navIndex) {
    final key = navBarKeys[navIndex];
    Scrollable.ensureVisible(key.currentContext!,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, Constraints) {
      final bool isDesktop = ((Constraints.maxWidth) >= 600);
      return Scaffold(
          key: scaffoldKey,
          backgroundColor: CustomColor.scaffoldColor,
          endDrawer: isDesktop
              ? null
              : Drawer(
                  width: screenSize.width / 2,
                  backgroundColor: CustomColor.scaffoldColor,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListView(
                      children: [
                        for (int i = headerItems.length - 1; i >= 0; i--)
                          ListTile(
                            leading: Icon(
                              headerIcons[i],
                              size: 21.sp,
                            ),
                            title: Text(
                              headerItems[i],
                              style: TextStyle(fontSize: 19.sp),
                            ),
                            onTap: () {
                              scaffoldKey.currentState?.closeEndDrawer();
                              onNavItemTap(i);
                            },
                          )
                      ],
                    ),
                  ),
                ),
          body: CustomScrollView(
            controller: myScrollController,
            slivers: [
              SliverAppBar(
                  pinned: true,
                  surfaceTintColor: CustomColor.scaffoldColor,
                  backgroundColor: CustomColor.scaffoldColor,
                  title: isDesktop
                      ? HeaderDesktop(
                          onNavMenuTap: onNavItemTap,
                          key: navBarKeys[3],
                        )
                      : HeaderMobile(
                          onTap: onMenuTap,
                          key: navBarKeys[3],
                        )),
              SliverList(
                  delegate: SliverChildListDelegate([
                Column(
                  children: [
                    SizedBox(height: 10.h),
                    // Hi Message
                    isDesktop
                        ? HiMessageDesktop(
                            key: navBarKeys[3],
                            onNavMenuTap: onNavItemTap,
                          )
                        : HiMessageMobile(onNavMenuTap: onNavItemTap),

                    isDesktop ? const ExpInfoDesktop() : const ExpInfoMobile(),

                    SizedBox(
                      height: 50.h,
                    ),
                    // My Skills
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 10.w : 2.w),
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      key: navBarKeys[2],
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: CustomColor.bgLighter1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "My Skills",
                            style: TextStyle(
                                fontSize: isDesktop ? 9.5.sp : 16.sp,
                                fontWeight: FontWeight.bold),
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
                                        width: isDesktop ? 115.w : 147.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(45),
                                            color: CustomColor.bgLighter2),
                                        child: Center(
                                          child: ListTile(
                                            isThreeLine: false,
                                            leading: Image.asset(
                                              mySkills[i]["img"],
                                              //fit: BoxFit.cover,
                                              width: isDesktop ? 25.w : 28.5.w,
                                              height: isDesktop ? 40.h : 47.h,
                                            ),
                                            title: Text(
                                              mySkills[i]["title"],
                                              style: TextStyle(
                                                  fontSize: isDesktop
                                                      ? 5.7.sp
                                                      : 13.sp),
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
                    SizedBox(
                      height: 50.h,
                    ),
                    // About Section
                    isDesktop
                        ? AboutDesktop(
                            key: navBarKeys[1],
                          )
                        : AboutMobile(
                            key: navBarKeys[1],
                          ),
                    SizedBox(
                      height: 50.h,
                    ),
                    // Contact and Social Media links
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      key: navBarKeys.first,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Color.fromARGB(255, 173, 49, 49)),
                      child: Column(
                        children: [
                          Text(
                            "Contact and Social Media Links",
                            style: TextStyle(
                                fontSize: isDesktop ? 6.7.sp : 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 35.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < SocialMediaLinks.length; i++)
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        launchUrl(SocialMediaLinks[i]["URL"],
                                            mode:
                                                LaunchMode.externalApplication);
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          SocialMediaLinks[i]["path"],
                                          width: isDesktop ? 25.w : 28.5.w,
                                          height: isDesktop ? 40.h : 47.h,
                                          // fit: BoxFit.contain,
                                        ),
                                      ],
                                    ))
                            ],
                          ),
                          Divider(
                            color: CustomColor.bgLighter2,
                            thickness: 3.h,
                            indent: isDesktop ? 100.w : 25.w,
                            endIndent: isDesktop ? 100.w : 25.w,
                            height: 35.h,
                          ),
                          Text(
                            "elking.medo61111@gmail.com",
                            style: TextStyle(
                                color: const Color.fromARGB(195, 255, 255, 255),
                                fontWeight: FontWeight.w900,
                                fontSize: isDesktop ? 4.5.sp : 13.sp),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ]))
            ],
          ));
    });
  }
}
