import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/header_list_items.dart';
import 'package:my_portfolio/constants/projects_model_info.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';
import 'package:my_portfolio/widgets/message_animated_icon.dart';
import 'package:my_portfolio/widgets/mobile/about_mobile.dart';
import 'package:my_portfolio/widgets/mobile/account_info.dart';
import 'package:my_portfolio/widgets/mobile/exp_info_mobile.dart';
import 'package:my_portfolio/widgets/mobile/header_mobile.dart';
import 'package:my_portfolio/widgets/mobile/hi_message_mobile.dart';
import 'package:my_portfolio/widgets/mobile/mobile_skills_widget.dart';
import 'package:my_portfolio/widgets/oval_right_border_clipper.dart';
import 'package:my_portfolio/widgets/scroll_animated_widget.dart';
import 'package:my_portfolio/widgets/hover_card.dart';
import 'package:my_portfolio/widgets/shared/loading_indicator_widget.dart';
import 'package:my_portfolio/widgets/shared/project_card_content.dart';
import 'package:my_portfolio/widgets/shared/social_media_row.dart';
import 'package:my_portfolio/widgets/shared/footer_section.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  bool _isFlutterProjectsVisible = false;
  bool _showBackToTop = false;

  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final myScrollController = ScrollController();
  final List<GlobalKey> navBarKeys = List.generate(5, (index) => GlobalKey());

  @override
  void initState() {
    super.initState();
    myScrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    myScrollController.removeListener(_onScroll);
    myScrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final show = myScrollController.offset > 300;
    if (show != _showBackToTop) {
      setState(() => _showBackToTop = show);
    }
  }

  void onMenuTap() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  void onNavItemTap(int navIndex) {
    final key = navBarKeys[navIndex];
    Scrollable.ensureVisible(key.currentContext!,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PortfolioProvider>();
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: CustomColor.scaffoldColor,
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: _showBackToTop ? Offset.zero : const Offset(0, 2),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _showBackToTop ? 1.0 : 0.0,
          child: FloatingActionButton.small(
            backgroundColor: CustomColor.myYellow,
            foregroundColor: Colors.black,
            tooltip: 'Back to top',
            onPressed: () {
              myScrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: const Icon(Icons.keyboard_arrow_up),
          ),
        ),
      ),
      drawer: ClipPath(
        clipper: OvalRightBorderClipper(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: const Color.fromARGB(255, 74, 78, 101), width: 3.w)),
          child: Drawer(
            width: screenSize.width / 1.8,
            backgroundColor: CustomColor.scaffoldColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AccountInfo(),
                for (int i = 0; i < headerItems.length; i++)
                  Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          headerIcons[i],
                          size: 21.sp,
                          color: CustomColor.myYellow,
                        ),
                        title: Text(
                          headerItems[i],
                          style: TextStyle(fontSize: 19.sp),
                        ),
                        onTap: () {
                          scaffoldKey.currentState?.closeDrawer();
                          onNavItemTap(i);
                        },
                      ),
                      Divider(
                        thickness: 1.h,
                        height: 35.h,
                      )
                    ],
                  )
              ],
            ),
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
              title: HeaderMobile(
                onTap: onMenuTap,
              )),
          SliverToBoxAdapter(
            child: Visibility(
                visible: provider.isLoading,
                child: const LoadingIndicatorWidget()),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                HiMessageMobile(key: navBarKeys[0], onNavMenuTap: onNavItemTap),
                const ExpInfoMobile(),
                SizedBox(height: 50.h),
              ],
            ),
          ),
          MobileSkillsWidget(navBarKeys: navBarKeys, screenSize: screenSize),
          SliverToBoxAdapter(
            child: ScrollAnimatedWidget(
              visibilityKey: 'projects-mobile-section',
              duration: const Duration(milliseconds: 800),
              slideOffset: 70,
              child: Column(
                children: [
                  SizedBox(height: 50.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
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
                          "My Flutter Projects",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16.h),
                        SizedBox(
                          width: double.infinity,
                          height: 650.h,
                          child: VisibilityDetector(
                            key: const Key('flutter-project-section'),
                            onVisibilityChanged: (VisibilityInfo info) async {
                              if (info.visibleFraction > 0.5 &&
                                  !_isFlutterProjectsVisible) {
                                await Future.delayed(
                                    const Duration(milliseconds: 500));
                                if (info.visibleFraction > 0.5) {
                                  setState(() {
                                    _isFlutterProjectsVisible = true;
                                  });
                                }
                              } else if (info.visibleFraction <= 0.5 &&
                                  _isFlutterProjectsVisible) {
                                setState(() {
                                  _isFlutterProjectsVisible = false;
                                });
                              }
                            },
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 100),
                              child: _isFlutterProjectsVisible
                                  ? AnimationLimiter(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        physics: const BouncingScrollPhysics(
                                            parent:
                                                AlwaysScrollableScrollPhysics()),
                                        itemCount: myProjects.length,
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          return AnimationConfiguration
                                              .staggeredList(
                                            position: i,
                                            delay: const Duration(
                                                milliseconds: 100),
                                            child: SlideAnimation(
                                              duration: const Duration(
                                                  milliseconds: 250),
                                              curve:
                                                  Curves.fastLinearToSlowEaseIn,
                                              horizontalOffset: 300,
                                              verticalOffset: 30.0,
                                              child: FlipAnimation(
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                curve: Curves
                                                    .fastLinearToSlowEaseIn,
                                                flipAxis: FlipAxis.x,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: HoverCard(
                                                    hoverScale: 1.03,
                                                    semanticLabel:
                                                        '${myProjects[i].title} project card',
                                                    onActivate: () {
                                                      context.go(
                                                          '/projects/${myProjects[i].slug}');
                                                    },
                                                    child: Container(
                                                      width: 210.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          color: CustomColor
                                                              .bgLighter2),
                                                      child: ProjectCardContent(
                                                        project: myProjects[i],
                                                        titleFontSize: 15.5.sp,
                                                        subtitleFontSize:
                                                            13.5.sp,
                                                        linkFontSize: 18.sp,
                                                        iconSize: 10.5.sp,
                                                        useFlexLayout: true,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 50.h),
                AboutMobile(key: navBarKeys[3]),
                SizedBox(height: 50.h),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: ScrollAnimatedWidget(
              visibilityKey: 'contact-mobile-section',
              duration: const Duration(milliseconds: 900),
              slideOffset: 80,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    key: navBarKeys[4],
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
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 35.h),
                        Container(
                          decoration: const BoxDecoration(),
                          child: IntrinsicWidth(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width /
                                          2.4,
                                      child: TextField(
                                        controller: provider.nameController,
                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(
                                              Icons.account_circle_rounded),
                                          filled: true,
                                          labelText: 'Name',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16))),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width /
                                          2.4,
                                      child: TextField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: provider.emailController,
                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(
                                              Icons.alternate_email_outlined),
                                          filled: true,
                                          labelText: 'Email',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16))),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                TextField(
                                  maxLines: 9,
                                  controller: provider.messageController,
                                  decoration: const InputDecoration(
                                    suffixIcon: MessageAnimatedIcon(),
                                    filled: true,
                                    hintText: 'Message',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                ProgressButton.icon(
                                    radius: 16,
                                    textStyle: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                    maxWidth: MediaQuery.sizeOf(context).width *
                                            2 /
                                            2.4 +
                                        7.w,
                                    minWidth: MediaQuery.sizeOf(context).width *
                                            2 /
                                            2.4 +
                                        7.w,
                                    height: 50.h,
                                    iconedButtons: {
                                      ButtonState.idle: const IconedButton(
                                          text: 'Send The Message',
                                          icon: Icon(Icons.send,
                                              color: Colors.white),
                                          color: Color(0xff36323F)),
                                      ButtonState.loading: IconedButton(
                                          text: 'Loading',
                                          color: const Color(0xff36323F)
                                              .withOpacity(0.6)),
                                      ButtonState.fail: IconedButton(
                                          text: 'Message is canceled',
                                          icon: const Icon(Icons.cancel,
                                              color: Colors.white),
                                          color: Colors.red.shade300),
                                      ButtonState.success: IconedButton(
                                          text: 'Message sent successfully',
                                          icon: const Icon(
                                            Icons.check_circle,
                                            color: Colors.greenAccent,
                                          ),
                                          color: Colors.green.shade400)
                                    },
                                    onPressed: () async {
                                      stateTextWithIcon = ButtonState.loading;
                                      setState(() {});

                                      switch (await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SimpleDialog(
                                              title: Text(
                                                "Do you want to send the message?",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.sp,
                                                ),
                                              ),
                                              children: [
                                                SimpleDialogOption(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, "Yes");
                                                  },
                                                  child: Text(
                                                    "Yes",
                                                    style: TextStyle(
                                                      color: Colors.greenAccent,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                ),
                                                SimpleDialogOption(
                                                  onPressed: () async {
                                                    Navigator.pop(
                                                        context, "No");
                                                    await Future.delayed(
                                                      const Duration(
                                                          seconds: 1),
                                                      () {
                                                        setState(
                                                          () {
                                                            stateTextWithIcon =
                                                                ButtonState
                                                                    .fail;
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Text(
                                                    "No",
                                                    style: TextStyle(
                                                        color: Colors.redAccent,
                                                        fontSize: 16.sp),
                                                  ),
                                                )
                                              ],
                                            );
                                          })) {
                                        case "Yes":
                                          provider.sendEmail(context,
                                              fontSize: 15.sp);
                                          stateTextWithIcon =
                                              ButtonState.success;
                                          await Future.delayed(
                                            const Duration(seconds: 2),
                                            () {},
                                          );
                                          setState(
                                            () {
                                              stateTextWithIcon =
                                                  ButtonState.idle;
                                            },
                                          );
                                          break;
                                        case "No":
                                          await Future.delayed(
                                            const Duration(milliseconds: 100),
                                            () {},
                                          );
                                          setState(
                                            () {
                                              stateTextWithIcon =
                                                  ButtonState.fail;
                                            },
                                          );
                                          await Future.delayed(
                                            const Duration(seconds: 1),
                                            () {
                                              setState(
                                                () {
                                                  stateTextWithIcon =
                                                      ButtonState.idle;
                                                },
                                              );
                                            },
                                          );
                                          stateTextWithIcon = ButtonState.idle;
                                          setState(() {});
                                          break;
                                      }
                                    },
                                    state: stateTextWithIcon),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 35.h),
                        SocialMediaRow(
                          imageWidth: 34.5.w,
                          imageHeight: 48.h,
                        ),
                        FooterSection(
                          indent: 25.w,
                          endIndent: 25.w,
                          fontSize: 13.sp,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
