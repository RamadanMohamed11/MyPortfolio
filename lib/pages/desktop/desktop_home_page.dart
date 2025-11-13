import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/projects_model_info.dart';
import 'package:my_portfolio/constants/social_media.dart';
import 'package:my_portfolio/widgets/computer/about_desktop.dart';
import 'package:my_portfolio/widgets/computer/desktop_contact_widget.dart';
import 'package:my_portfolio/widgets/computer/desktop_skills_widget.dart';
import 'package:my_portfolio/widgets/computer/exp_info_desktop.dart';
import 'package:my_portfolio/widgets/computer/header_desktop.dart';
import 'package:my_portfolio/widgets/computer/hi_message_desktop.dart';
import 'package:my_portfolio/widgets/scroll_animated_widget.dart';
import 'package:my_portfolio/widgets/hover_card.dart';
import 'package:my_portfolio/pages/desktop/project_detail_page_desktop.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:shimmer/shimmer.dart';

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

  /// The key for the Scaffold widget
  final scaffoldKey = GlobalKey<ScaffoldState>();

  /// The scroll controller for the scrollable area
  final myScrollController = ScrollController();

  /// Controllers for the text fields
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  /// Whether the app is currently loading (sending an email)
  bool isLoading = false;

  /// A list of global keys for the nav bar items. Used to scroll to the item with the given index when the corresponding nav bar item is tapped
  final List<GlobalKey> navBarKeys = List.generate(5, (index) => GlobalKey());

  /// Tap handler for the nav bar items. Scrolls the nav bar item with the given index to be visible on the screen.
  void onNavItemTap(int navIndex) {
    final GlobalKey key = navBarKeys[navIndex];
    Scrollable.ensureVisible(key.currentContext!,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final ScrollController scrollControllerFlutter = ScrollController();
    final ScrollController scrollControllerEmbedded = ScrollController();

    /// Scrolls the content area to the left by 400 pixels.
    /// [isFlutter] specifies whether to scroll the Flutter content area or the embedded content area.
    void scrollLeft({required bool isFlutter}) {
      if (isFlutter) {
        scrollControllerFlutter.animateTo(
          scrollControllerFlutter.offset - 650, // Scroll left by 400 pixels
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        scrollControllerEmbedded.animateTo(
          scrollControllerEmbedded.offset - 650, // Scroll left by 400 pixels
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }

    /// Scrolls the content area to the right by 400 pixels.
    /// [isFlutter] specifies whether to scroll the Flutter content area or the embedded content area.
    void scrollRight({required bool isFlutter}) {
      if (isFlutter) {
        scrollControllerFlutter.animateTo(
          scrollControllerFlutter.offset + 400, // Scroll right by 400 pixels
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        scrollControllerEmbedded.animateTo(
          scrollControllerEmbedded.offset + 400, // Scroll right by 400 pixels
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }

    /// Returns a centered [LoadingIndicator] widget.
    Widget showIndicator() {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width / (7),
            height: MediaQuery.sizeOf(context).height / 2.7,
            child: const LoadingIndicator(
                indicatorType: Indicator.triangleSkewSpin,
                colors: [CustomColor.myYellow],
                backgroundColor: CustomColor.scaffoldColor,
                pathBackgroundColor: CustomColor.myYellow),
          ),
        ),
      );
    }

    Future<void> sendEmail() async {
      if (nameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: CustomColor.scaffoldColor,
            content: Center(
              child: Text(
                'Write your name to send...',
                style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 7.sp),
              ),
            ),
          ),
        );
      } else if (emailController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: CustomColor.scaffoldColor,
            content: Center(
              child: Text(
                'Write your email to send...',
                style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 7.sp),
              ),
            ),
          ),
        );
      } else if (!emailController.text.contains("@gmail.com")) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: CustomColor.scaffoldColor,
            content: Center(
              child: Text(
                'Invalid Email.',
                style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 7.sp),
              ),
            ),
          ),
        );
      } else if (messageController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: CustomColor.scaffoldColor,
            content: Center(
              child: Text(
                'Write a message to send...',
                style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 7.sp),
              ),
            ),
          ),
        );
      } else {
        try {
          setState(() {
            isLoading = true;
          });
          final subject = "Message From Portfolio By ${nameController.text}";
          final body =
              "From: ${emailController.text}\n\n${messageController.text}";
          final mailUri = Uri(
            scheme: 'mailto',
            path: 'ramadan.work010@gmail.com',
            queryParameters: {
              'subject': subject,
              'body': body,
            },
          );
          final launched = await launchUrl(
            mailUri,
            mode: LaunchMode.externalApplication,
          );
          if (!launched) {
            throw 'Could not open the email app';
          }
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: CustomColor.scaffoldColor,
              content: Center(
                child: Text(
                  'Message sent successfully.',
                  style: TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 7.sp),
                ),
              ),
            ),
          );
          nameController.text = "";
          emailController.text = "";
          messageController.text = "";
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text('Failed to send email: $error'),
            ),
          );
        }
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
              isloaded: isLoading,
            ),
          ),
          SliverToBoxAdapter(
            child: VisibilityDetector(
              key: const Key('home-section'),
              onVisibilityChanged: (VisibilityInfo info) async {
                if (info.visibleFraction > 0.5) {
                  await Future.delayed(
                    const Duration(milliseconds: 800),
                    () {},
                  );
                  if (info.visibleFraction > 0.5) {
                    setState(() {
                      numberOfText = 4;
                    });
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
              visible: isLoading,
              child: showIndicator(),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                // My Skills
                VisibilityDetector(
                  key: const Key('skills-section'),
                  onVisibilityChanged: (VisibilityInfo info) async {
                    if (info.visibleFraction > 0.5) {
                      await Future.delayed(
                        const Duration(milliseconds: 500),
                        () {},
                      );
                      if (info.visibleFraction > 0.5) {
                        setState(() {
                          numberOfText = 3;
                        });
                      }
                    }
                  },
                  child: DesktopSkillsWidget(
                      navBarKeys: navBarKeys, screenSize: screenSize),
                ),
                SizedBox(
                  height: 50.h,
                ),
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
                                    numberOfText = 2;
                                    _isFlutterProjectsVisible = true;
                                  });
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
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 280.h,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16),
                                                                child:
                                                                    Image.asset(
                                                                  myProjects[i]
                                                                      .img,
                                                                  width: double
                                                                      .infinity,
                                                                  height: double
                                                                      .infinity,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  frameBuilder: (BuildContext
                                                                          context,
                                                                      Widget
                                                                          child,
                                                                      int?
                                                                          frame,
                                                                      bool
                                                                          wasSynchronouslyLoaded) {
                                                                    if (wasSynchronouslyLoaded) {
                                                                      return child;
                                                                    }
                                                                    return AnimatedSwitcher(
                                                                      duration: const Duration(
                                                                          milliseconds:
                                                                              300),
                                                                      child: frame ==
                                                                              null
                                                                          ? Shimmer
                                                                              .fromColors(
                                                                              baseColor: CustomColor.bgLighter2,
                                                                              highlightColor: Colors.white.withOpacity(0.5),
                                                                              child: Container(
                                                                                color: Colors.white,
                                                                              ),
                                                                            )
                                                                          : child,
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(4.0
                                                                          .sp),
                                                              child: Text(
                                                                myProjects[i]
                                                                    .title,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      5.5.sp,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(4.0
                                                                            .sp),
                                                                child: Text(
                                                                  myProjects[i]
                                                                      .subtitle,
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .white70,
                                                                    fontSize:
                                                                        6.1.sp,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                color: const Color(
                                                                    0xff333646),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            5.w,
                                                                        vertical:
                                                                            2.h),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      "Link",
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                        fontSize:
                                                                            7.sp,
                                                                        color: CustomColor
                                                                            .myYellow,
                                                                      ),
                                                                    ),
                                                                    const Spacer(),
                                                                    MouseRegion(
                                                                      onEnter: (_) =>
                                                                          setState(() =>
                                                                              _githubLinksScale[i] = 1.5),
                                                                      onExit: (_) =>
                                                                          setState(() =>
                                                                              _githubLinksScale[i] = 1.0),
                                                                      child:
                                                                          AnimatedScale(
                                                                        duration:
                                                                            const Duration(milliseconds: 200),
                                                                        scale:
                                                                            _githubLinksScale[i],
                                                                        child:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            launchUrl(
                                                                              Uri.parse(myProjects[i].gitHubLink),
                                                                              mode: LaunchMode.externalApplication,
                                                                            );
                                                                          },
                                                                          icon: Image.asset(socialMediaLinks[4]
                                                                              [
                                                                              "path"]),
                                                                          iconSize:
                                                                              5.5.sp,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
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
                  // SizedBox(height: 50.h),
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 10.w),
                  //   padding: EdgeInsets.symmetric(vertical: 5.h),
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(15),
                  //       color: CustomColor.bgLighter1),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         "My Embedded Projects",
                  //         style: TextStyle(
                  //             fontSize: 8.5.sp, fontWeight: FontWeight.bold),
                  //       ),
                  //       SizedBox(height: 16.h),
                  //       SizedBox(
                  //         width: double.infinity,
                  //         height: 580.h,
                  //         child: SingleChildScrollView(
                  //           controller: scrollControllerEmbedded,
                  //           scrollDirection: Axis.horizontal,
                  //           physics: const BouncingScrollPhysics(),
                  //           child: Row(
                  //             children: List.generate(myProjects.length, (i) {
                  //               return Container(
                  //                 margin: const EdgeInsets.all(15),
                  //                 width: MediaQuery.sizeOf(context).width / 3.5,
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(16),
                  //                   color: CustomColor.bgLighter2,
                  //                 ),
                  //                 child: Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Container(
                  //                       height: 280.h,
                  //                       decoration: BoxDecoration(
                  //                         image: DecorationImage(
                  //                           image: AssetImage(myProjects[i].img),
                  //                           fit: BoxFit.cover,
                  //                         ),
                  //                         borderRadius: BorderRadius.circular(16),
                  //                       ),
                  //                       width:
                  //                           MediaQuery.sizeOf(context).width / 2,
                  //                     ),
                  //                     Padding(
                  //                       padding: EdgeInsets.all(4.0.sp),
                  //                       child: Text(
                  //                         myProjects[i].title,
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontWeight: FontWeight.bold,
                  //                             fontSize: 5.5.sp),
                  //                       ),
                  //                     ),
                  //                     Container(
                  //                       height: 130.h,
                  //                       padding: EdgeInsets.all(4.0.sp),
                  //                       child: Text(
                  //                         myProjects[i].subtitle,
                  //                         style: TextStyle(
                  //                             fontWeight: FontWeight.w500,
                  //                             color: Colors.white70,
                  //                             fontSize: 6.1.sp),
                  //                       ),
                  //                     ),
                  //                     Container(
                  //                       decoration: BoxDecoration(
                  //                           borderRadius:
                  //                               BorderRadius.circular(12),
                  //                           color: const Color(0xff333646)),
                  //                       child: Padding(
                  //                         padding: EdgeInsets.symmetric(
                  //                             horizontal: 5.w, vertical: 2.h),
                  //                         child: Row(
                  //                           children: [
                  //                             Text(
                  //                               "Link",
                  //                               style: TextStyle(
                  //                                   fontWeight: FontWeight.w900,
                  //                                   fontSize: 7.sp,
                  //                                   color: CustomColor.myYellow),
                  //                             ),
                  //                             const Spacer(),
                  //                             IconButton(
                  //                               onPressed: () {
                  //                                 setState(() {
                  //                                   launchUrl(
                  //                                       Uri.parse(myProjects[i]
                  //                                           .gitHubLink),
                  //                                       mode: LaunchMode
                  //                                           .externalApplication);
                  //                                 });
                  //                               },
                  //                               icon: Image.asset(
                  //                                 socialMediaLinks[4]["path"],
                  //                               ),
                  //                               iconSize: 5.5.sp,
                  //                             )
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     )
                  //                   ],
                  //                 ),
                  //               );
                  //             }),
                  //           ),
                  //         ),
                  //       ),
                  //       Positioned(
                  //           child: Row(
                  //         children: [
                  //           Expanded(
                  //             child: IconButton(
                  //               onPressed: () {
                  //                 scrollLeft(isFlutter: false);
                  //               },
                  //               icon: Icon(
                  //                 Icons.chevron_left,
                  //                 color: CustomColor.myYellow,
                  //                 size: 13.sp,
                  //               ),
                  //             ),
                  //           ),
                  //           const Spacer(),
                  //           Expanded(
                  //             child: IconButton(
                  //               onPressed: () {
                  //                 scrollRight(isFlutter: false);
                  //               },
                  //               icon: Icon(
                  //                 Icons.chevron_right,
                  //                 color: CustomColor.myYellow,
                  //                 size: 13.sp,
                  //               ),
                  //             ),
                  //           )
                  //         ],
                  //       ))
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: VisibilityDetector(
              key: const Key("about-section"),
              onVisibilityChanged: (VisibilityInfo info) async {
                if (info.visibleFraction > 0.5) {
                  await Future.delayed(
                    const Duration(milliseconds: 800),
                    () {},
                  );
                  if (info.visibleFraction > 0.5) {
                    setState(() {
                      numberOfText = 1;
                    });
                  }
                }
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  AboutDesktop(
                    key: navBarKeys[1],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                ],
              ),
            ),
            // Contact and Social Media links
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
                    await Future.delayed(
                      const Duration(milliseconds: 800),
                      () {},
                    );
                    if (info.visibleFraction > 0.5) {
                      setState(() {
                        numberOfText = 0;
                      });
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
                            nameController: nameController,
                            emailController: emailController,
                            messageController: messageController,
                            sendEmail: sendEmail,
                          ),
                          SizedBox(height: 35.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < socialMediaLinks.length; i++)
                                Tooltip(
                                  message: "Open the link",
                                  child: AnimatedScale(
                                    scale: _scale[i],
                                    duration: const Duration(milliseconds: 200),
                                    child: MouseRegion(
                                      onEnter: (_) =>
                                          setState(() => _scale[i] = 1.5),
                                      onExit: (_) =>
                                          setState(() => _scale[i] = 1.0),
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              launchUrl(
                                                  socialMediaLinks[i]["URL"],
                                                  mode: LaunchMode
                                                      .externalApplication);
                                            });
                                          },
                                          icon: Row(
                                            children: [
                                              Image.asset(
                                                socialMediaLinks[i]["path"],
                                                width: 25.w,
                                                height: 40.h,
                                                // fit: BoxFit.contain,
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                )
                            ],
                          ),
                          Divider(
                            color: CustomColor.bgLighter2,
                            thickness: 3.h,
                            indent: 100.w,
                            endIndent: 100.w,
                            height: 35.h,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text("Made by Eng Ramadan Mohamed with Flutter",
                              style: TextStyle(
                                  color: Colors.white38,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 4.5.sp)),
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
