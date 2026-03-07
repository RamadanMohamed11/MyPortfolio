import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/projects_model_info.dart';
import 'package:my_portfolio/constants/social_media.dart';
import 'package:my_portfolio/providers/portfolio_provider.dart';
import 'package:my_portfolio/widgets/computer/about_desktop.dart';
import 'package:my_portfolio/widgets/computer/desktop_contact_widget.dart';
import 'package:my_portfolio/widgets/computer/desktop_skills_widget.dart';
import 'package:my_portfolio/widgets/computer/exp_info_desktop.dart';
import 'package:my_portfolio/widgets/computer/header_desktop.dart';
import 'package:my_portfolio/widgets/computer/hi_message_desktop.dart';
import 'package:my_portfolio/widgets/scroll_animated_widget.dart';
import 'package:my_portfolio/widgets/hover_card.dart';
import 'package:my_portfolio/widgets/shared/loading_indicator_widget.dart';
import 'package:my_portfolio/widgets/shared/project_card_content.dart';
import 'package:my_portfolio/widgets/shared/social_media_row.dart';
import 'package:my_portfolio/widgets/shared/footer_section.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ComputerHomePage extends StatefulWidget {
  const ComputerHomePage({super.key});

  @override
  State<ComputerHomePage> createState() => _ComputerHomePageState();
}

class _ComputerHomePageState extends State<ComputerHomePage> {
  final List<double> _scale = [
    for (int i = 0; i <= socialMediaLinks.length; i++) 1.0
  ];
  final List<double> _githubLinksScale = [
    for (int i = 0; i <= myProjects.length; i++) 1.0
  ];
  bool _isFlutterProjectsVisible = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final myScrollController = ScrollController();
  final List<GlobalKey> navBarKeys = List.generate(5, (index) => GlobalKey());

  void onNavItemTap(int navIndex) {
    final GlobalKey key = navBarKeys[navIndex];
    Scrollable.ensureVisible(key.currentContext!,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PortfolioProvider>();
    var screenSize = MediaQuery.of(context).size;
    final ScrollController scrollControllerFlutter = ScrollController();
    final ScrollController scrollControllerEmbedded = ScrollController();

    void scrollLeft({required bool isFlutter}) {
      if (isFlutter) {
        scrollControllerFlutter.animateTo(
          scrollControllerFlutter.offset - 650,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        scrollControllerEmbedded.animateTo(
          scrollControllerEmbedded.offset - 650,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }

    void scrollRight({required bool isFlutter}) {
      if (isFlutter) {
        scrollControllerFlutter.animateTo(
          scrollControllerFlutter.offset + 400,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        scrollControllerEmbedded.animateTo(
          scrollControllerEmbedded.offset + 400,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: CustomColor.scaffoldColor,
      body: CustomScrollView(
        controller: myScrollController,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            surfaceTintColor: CustomColor.scaffoldColor,
            backgroundColor: CustomColor.scaffoldColor,
            title: HeaderDesktop(
              onNavMenuTap: onNavItemTap,
              isloaded: provider.isLoading,
            ),
          ),
          SliverToBoxAdapter(
            child: VisibilityDetector(
              key: const Key('home-section'),
              onVisibilityChanged: (VisibilityInfo info) async {
                if (info.visibleFraction > 0.5) {
                  await Future.delayed(const Duration(milliseconds: 800));
                  if (info.visibleFraction > 0.5) {
                    provider.setNavIndex(4);
                  }
                }
              },
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  HiMessageDesktop(
                    key: navBarKeys[4],
                    onNavMenuTap: onNavItemTap,
                  ),
                  const ExpInfoDesktop()
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Visibility(
              visible: provider.isLoading,
              child: const LoadingIndicatorWidget(),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 50.h),
                VisibilityDetector(
                  key: const Key('skills-section'),
                  onVisibilityChanged: (VisibilityInfo info) async {
                    if (info.visibleFraction > 0.5) {
                      await Future.delayed(const Duration(milliseconds: 500));
                      if (info.visibleFraction > 0.5) {
                        provider.setNavIndex(3);
                      }
                    }
                  },
                  child: DesktopSkillsWidget(
                      navBarKeys: navBarKeys, screenSize: screenSize),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: ScrollAnimatedWidget(
              visibilityKey: 'projects-desktop-section',
              duration: const Duration(milliseconds: 800),
              slideOffset: 70,
              child: Column(
                key: navBarKeys[2],
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: CustomColor.bgLighter1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "My Flutter Projects",
                          style: TextStyle(
                              fontSize: 8.5.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16.h),
                        Listener(
                          onPointerSignal: (event) {
                            if (event is PointerScrollEvent) {
                              final delta = event.scrollDelta.dy;
                              if (scrollControllerFlutter.hasClients) {
                                final max = scrollControllerFlutter
                                    .position.maxScrollExtent;
                                final target =
                                    (scrollControllerFlutter.offset + delta)
                                        .clamp(0.0, max);
                                scrollControllerFlutter.jumpTo(target);
                              }
                            }
                          },
                          child: SizedBox(
                            width: double.infinity,
                            height: 650.h,
                            child: VisibilityDetector(
                              key: const Key('flutter-project-section'),
                              onVisibilityChanged: (VisibilityInfo info) {
                                if (info.visibleFraction > 0.5 &&
                                    !_isFlutterProjectsVisible) {
                                  setState(() {
                                    _isFlutterProjectsVisible = true;
                                  });
                                  provider.setNavIndex(2);
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
                                          controller: scrollControllerFlutter,
                                          scrollDirection: Axis.horizontal,
                                          physics: const BouncingScrollPhysics(
                                              parent:
                                                  AlwaysScrollableScrollPhysics()),
                                          itemCount: myProjects.length,
                                          itemBuilder: (context, i) {
                                            return AnimationConfiguration
                                                .staggeredList(
                                              position: i,
                                              delay: const Duration(
                                                  milliseconds: 100),
                                              child: SlideAnimation(
                                                duration: const Duration(
                                                    milliseconds: 250),
                                                curve: Curves
                                                    .fastLinearToSlowEaseIn,
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
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: HoverCard(
                                                      hoverScale: 1.03,
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3.5,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          color: CustomColor
                                                              .bgLighter2,
                                                        ),
                                                        child:
                                                            ProjectCardContent(
                                                          project:
                                                              myProjects[i],
                                                          titleFontSize: 5.5.sp,
                                                          subtitleFontSize:
                                                              6.1.sp,
                                                          linkFontSize: 7.sp,
                                                          iconSize: 5.5.sp,
                                                          useFlexLayout: false,
                                                          imageHeight: 280.h,
                                                          imageWidth:
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2,
                                                          customGitHubButton:
                                                              MouseRegion(
                                                            onEnter: (_) =>
                                                                setState(() =>
                                                                    _githubLinksScale[
                                                                            i] =
                                                                        1.5),
                                                            onExit: (_) =>
                                                                setState(() =>
                                                                    _githubLinksScale[
                                                                            i] =
                                                                        1.0),
                                                            child:
                                                                AnimatedScale(
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          200),
                                                              scale:
                                                                  _githubLinksScale[
                                                                      i],
                                                              child: IconButton(
                                                                onPressed: () {
                                                                  launchUrl(
                                                                    Uri.parse(
                                                                        myProjects[i]
                                                                            .gitHubLink),
                                                                    mode: LaunchMode
                                                                        .externalApplication,
                                                                  );
                                                                },
                                                                icon: Image.asset(
                                                                    socialMediaLinks[
                                                                            4]
                                                                        .iconPath),
                                                                iconSize:
                                                                    5.5.sp,
                                                              ),
                                                            ),
                                                          ),
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
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  scrollLeft(isFlutter: true);
                                },
                                icon: Icon(
                                  Icons.chevron_left,
                                  color: CustomColor.myYellow,
                                  size: 13.sp,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              child: IconButton(
                                onPressed: () {
                                  scrollRight(isFlutter: true);
                                },
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: CustomColor.myYellow,
                                  size: 13.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: VisibilityDetector(
              key: const Key("about-section"),
              onVisibilityChanged: (VisibilityInfo info) async {
                if (info.visibleFraction > 0.5) {
                  await Future.delayed(const Duration(milliseconds: 800));
                  if (info.visibleFraction > 0.5) {
                    provider.setNavIndex(1);
                  }
                }
              },
              child: Column(
                children: [
                  SizedBox(height: 50.h),
                  AboutDesktop(key: navBarKeys[1]),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ScrollAnimatedWidget(
              visibilityKey: 'contact-desktop-section',
              duration: const Duration(milliseconds: 900),
              slideOffset: 80,
              child: VisibilityDetector(
                key: const Key("contact-section"),
                onVisibilityChanged: (VisibilityInfo info) async {
                  if (info.visibleFraction > 0.5) {
                    await Future.delayed(const Duration(milliseconds: 800));
                    if (info.visibleFraction > 0.5) {
                      provider.setNavIndex(0);
                    }
                  }
                },
                child: Column(
                  children: [
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
                                fontSize: 6.7.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 35.h),
                          DesktopContactWidget(
                            nameController: provider.nameController,
                            emailController: provider.emailController,
                            messageController: provider.messageController,
                            sendEmail: () =>
                                provider.sendEmail(context, fontSize: 7.sp),
                          ),
                          SizedBox(height: 35.h),
                          SocialMediaRow(
                            imageWidth: 25.w,
                            imageHeight: 40.h,
                            enableHoverAnimation: true,
                            scales: _scale,
                            onScaleChanged: (index, scale) {
                              setState(() => _scale[index] = scale);
                            },
                          ),
                          FooterSection(
                            indent: 100.w,
                            endIndent: 100.w,
                            fontSize: 4.5.sp,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
