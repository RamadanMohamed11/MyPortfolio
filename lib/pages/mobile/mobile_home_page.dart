import 'package:email_sender/email_sender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/header_list_items.dart';
import 'package:my_portfolio/constants/projects_model_info.dart';
import 'package:my_portfolio/constants/social_media.dart';
import 'package:my_portfolio/widgets/message_animated_icon.dart';
import 'package:my_portfolio/widgets/mobile/about_mobile.dart';
import 'package:my_portfolio/widgets/mobile/account_info.dart';
import 'package:my_portfolio/widgets/mobile/exp_info_mobile.dart';
import 'package:my_portfolio/widgets/mobile/header_mobile.dart';
import 'package:my_portfolio/widgets/mobile/hi_message_mobile.dart';
import 'package:my_portfolio/widgets/mobile/mobile_skills_widget.dart';
import 'package:my_portfolio/widgets/oval_right_border_clipper.dart';
import 'package:my_portfolio/widgets/scroll_animated_widget.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:shimmer/shimmer.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  bool _isFlutterProjectsVisible = false;

  ButtonState stateOnlyText = ButtonState.idle;
  ButtonState stateTextWithIcon = ButtonState.idle;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final myScrollController = ScrollController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  bool isLoading = false;
  final List<GlobalKey> navBarKeys = List.generate(5, (index) => GlobalKey());
  void onMenuTap() {
    scaffoldKey.currentState?.openEndDrawer();
  }

  void onNavItemTap(int navIndex) {
    final key = navBarKeys[navIndex];
    Scrollable.ensureVisible(key.currentContext!,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

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
                  fontSize: 15.sp),
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
                  fontSize: 15.sp),
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
                  fontSize: 15.sp),
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
                  fontSize: 15.sp),
            ),
          ),
        ),
      );
    } else {
      try {
        setState(() {
          isLoading = true;
        });
        EmailSender emailsender = EmailSender();
        await emailsender.sendMessage(
            "ramadan.work010@gmail.com",
            emailController.text,
            "Message From Portfolio By ${nameController.text}",
            messageController.text);
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
                    fontSize: 15.sp),
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

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: CustomColor.scaffoldColor,
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
                for (int i = headerItems.length - 1; i >= 0; i--)
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
                // key: navBarKeys[4],
              )),
          SliverToBoxAdapter(
            child: Visibility(visible: isLoading, child: showIndicator()),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                // Hi Message
                HiMessageMobile(key: navBarKeys[4], onNavMenuTap: onNavItemTap),

                const ExpInfoMobile(),

                SizedBox(
                  height: 50.h,
                ),
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
                  SizedBox(
                    height: 50.h,
                  ),
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
                                const Duration(milliseconds: 500),
                                () {},
                              );
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
                                          delay:
                                              const Duration(milliseconds: 100),
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
                                              curve:
                                                  Curves.fastLinearToSlowEaseIn,
                                              flipAxis: FlipAxis.x,
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.all(15),
                                                width: 210.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    color:
                                                        CustomColor.bgLighter2),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 11,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        child: Image.asset(
                                                          myProjects[i].img,
                                                          width: double.infinity,
                                                          height: double.infinity,
                                                          fit: BoxFit.cover,
                                                          frameBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  Widget child,
                                                                  int? frame,
                                                                  bool
                                                                      wasSynchronouslyLoaded) {
                                                            if (wasSynchronouslyLoaded) {
                                                              return child;
                                                            }
                                                            return AnimatedSwitcher(
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300),
                                                              child: frame ==
                                                                      null
                                                                  ? Shimmer
                                                                      .fromColors(
                                                                      baseColor:
                                                                          CustomColor
                                                                              .bgLighter2,
                                                                      highlightColor: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.5),
                                                                      child:
                                                                          Container(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    )
                                                                  : child,
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    const Spacer(
                                                      flex: 1,
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            4.0.sp),
                                                        child: Text(
                                                          myProjects[i].title,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  15.5.sp),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 5,
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                            4.0.sp),
                                                        child: Text(
                                                          myProjects[i]
                                                              .subtitle,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Colors
                                                                  .white70,
                                                              fontSize:
                                                                  13.5.sp),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            color: const Color(
                                                                0xff333646)),
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
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900,
                                                                    fontSize:
                                                                        18.sp,
                                                                    color: CustomColor
                                                                        .myYellow),
                                                              ),
                                                              const Spacer(),
                                                              IconButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    launchUrl(
                                                                        Uri.parse(myProjects[i]
                                                                            .gitHubLink),
                                                                        mode: LaunchMode
                                                                            .externalApplication);
                                                                  });
                                                                },
                                                                icon:
                                                                    Image.asset(
                                                                  socialMediaLinks[
                                                                          4]
                                                                      ["path"],
                                                                ),
                                                                iconSize:
                                                                    10.5.sp,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const Spacer(
                                                      flex: 1,
                                                    ),
                                                  ],
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
          // SliverToBoxAdapter(
          //   child: Column(
          //     children: [
          //       SizedBox(
          //         height: 50.h,
          //       ),
          //       Container(
          //         margin: EdgeInsets.symmetric(horizontal: 2.w),
          //         padding: EdgeInsets.symmetric(vertical: 5.h),
          //         width: double.infinity,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(15),
          //             color: CustomColor.bgLighter1),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Text(
          //               "My Embedded Projects",
          //               style: TextStyle(
          //                   fontSize: 16.sp, fontWeight: FontWeight.bold),
          //             ),
          //             SizedBox(height: 16.h),
          //             SizedBox(
          //               width: double.infinity,
          //               height: 580.h,
          //               child: ListView.builder(
          //                 physics: const BouncingScrollPhysics(),
          //                 itemCount: myProjects.length,
          //                 scrollDirection: Axis.horizontal,
          //                 itemBuilder: (BuildContext context, int i) {
          //                   return Container(
          //                     margin: const EdgeInsets.all(15),
          //                     width: 147.w,
          //                     // height: 500.h,
          //                     decoration: BoxDecoration(
          //                         borderRadius: BorderRadius.circular(16),
          //                         color: CustomColor.bgLighter2),
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Container(
          //                           height: 280.h,
          //                           decoration: BoxDecoration(
          //                               image: DecorationImage(
          //                                 image: AssetImage(
          //                                   myProjects[i].img,
          //                                 ),
          //                                 fit: BoxFit.cover,
          //                               ),
          //                               borderRadius:
          //                                   BorderRadius.circular(16)),
          //                           width: MediaQuery.sizeOf(context).width / 2,
          //                         ),
          //                         Padding(
          //                           padding: EdgeInsets.all(4.0.sp),
          //                           child: Text(
          //                             myProjects[i].title,
          //                             style: TextStyle(
          //                                 color: Colors.white,
          //                                 fontWeight: FontWeight.bold,
          //                                 fontSize: 14.sp),
          //                           ),
          //                         ),
          //                         Container(
          //                           height: 80.h,
          //                           padding: EdgeInsets.all(4.0.sp),
          //                           child: Text(
          //                             myProjects[i].subtitle,
          //                             style: TextStyle(
          //                                 fontWeight: FontWeight.w700,
          //                                 color: Colors.white70,
          //                                 fontSize: 11.5.sp),
          //                           ),
          //                         ),
          //                         Container(
          //                           decoration: BoxDecoration(
          //                               borderRadius: BorderRadius.circular(12),
          //                               color: const Color(0xff333646)),
          //                           child: Padding(
          //                             padding: EdgeInsets.symmetric(
          //                                 horizontal: 5.w, vertical: 2.h),
          //                             child: Row(
          //                               children: [
          //                                 Text(
          //                                   "Link",
          //                                   style: TextStyle(
          //                                       fontWeight: FontWeight.w900,
          //                                       fontSize: 14.sp,
          //                                       color: CustomColor.myYellow),
          //                                 ),
          //                                 const Spacer(),
          //                                 IconButton(
          //                                   onPressed: () {
          //                                     setState(() {
          //                                       launchUrl(
          //                                           Uri.parse(myProjects[i]
          //                                               .gitHubLink),
          //                                           mode: LaunchMode
          //                                               .externalApplication);
          //                                     });
          //                                   },
          //                                   icon: Image.asset(
          //                                     socialMediaLinks[4]["path"],
          //                                   ),
          //                                   iconSize: 5.5.sp,
          //                                 )
          //                               ],
          //                             ),
          //                           ),
          //                         )
          //                       ],
          //                     ),
          //                   );
          //                 },
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ), // About Section
                AboutMobile(
                  key: navBarKeys[1],
                ),

                SizedBox(
                  height: 50.h,
                ),
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
                                    width:
                                        MediaQuery.sizeOf(context).width / 2.4,
                                    child: TextField(
                                      controller: nameController,
                                      decoration: const InputDecoration(
                                        suffixIcon:
                                            Icon(Icons.account_circle_rounded),
                                        filled: true,
                                        labelText: 'Name',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16))),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width / 2.4,
                                    child: TextField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: emailController,
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
                              SizedBox(
                                height: 10.h,
                              ),
                              TextField(
                                maxLines: 9,
                                controller: messageController,
                                decoration: const InputDecoration(
                                  suffixIcon: MessageAnimatedIcon(),
                                  filled: true,
                                  hintText: 'Message',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(16))),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),

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
                                    // switch (stateTextWithIcon) {
                                    //   case ButtonState.idle:
                                    //     stateTextWithIcon = ButtonState.loading;
                                    //     Future.delayed(
                                    //       const Duration(seconds: 1),
                                    //       () {
                                    //         setState(
                                    //           () {
                                    //             stateTextWithIcon = Random.secure().nextBool()
                                    //                 ? ButtonState.success
                                    //                 : ButtonState.fail;
                                    //           },
                                    //         );
                                    //       },
                                    //     );

                                    //     break;
                                    //   case ButtonState.loading:
                                    //     break;
                                    //   case ButtonState.success:
                                    //     stateTextWithIcon = ButtonState.idle;
                                    //     break;
                                    //   case ButtonState.fail:
                                    //     stateTextWithIcon = ButtonState.idle;
                                    //     break;
                                    // }
                                    // setState(
                                    //   () {
                                    //     stateTextWithIcon = stateTextWithIcon;
                                    //   },
                                    // );

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
                                                  Navigator.pop(context, "Yes");
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
                                                  Navigator.pop(context, "No");
                                                  await Future.delayed(
                                                    const Duration(seconds: 1),
                                                    () {
                                                      setState(
                                                        () {
                                                          stateTextWithIcon =
                                                              ButtonState.fail;
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
                                        sendEmail();
                                        stateTextWithIcon = ButtonState.success;
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

                                        // ScaffoldMessenger.of(context).showSnackBar(
                                        //   SnackBar(
                                        //     backgroundColor: CustomColor.scaffoldColor,
                                        //     content: Center(
                                        //       child: Text(
                                        //         'Message is canceled.',
                                        //         style: TextStyle(
                                        //             color: Colors.redAccent,
                                        //             fontWeight: FontWeight.bold,
                                        //             fontSize: 7.sp),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // );
                                        stateTextWithIcon = ButtonState.idle;
                                        setState(() {});
                                        break;
                                    }
                                  },
                                  state: stateTextWithIcon),

                              // ElevatedButton.icon(
                              //   style: ElevatedButton.styleFrom(
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius:
                              //               BorderRadius.circular(16)),
                              //       minimumSize: Size(
                              //           MediaQuery.sizeOf(context).width *
                              //                   2 /
                              //                   2.4 +
                              //               7.w,
                              //           50.h)),
                              //   onPressed: () async {
                              //     switch (await showDialog(
                              //         context: context,
                              //         builder: (BuildContext context) {
                              //           return SimpleDialog(
                              //             title: Text(
                              //               "Do you want to send the message?",
                              //               style: TextStyle(
                              //                 fontWeight: FontWeight.bold,
                              //                 fontSize: 14.sp,
                              //               ),
                              //             ),
                              //             children: [
                              //               SimpleDialogOption(
                              //                 onPressed: () {
                              //                   Navigator.pop(context, "Yes");
                              //                 },
                              //                 child: Text(
                              //                   "Yes",
                              //                   style: TextStyle(
                              //                     color: Colors.greenAccent,
                              //                     fontSize: 12.sp,
                              //                   ),
                              //                 ),
                              //               ),
                              //               SimpleDialogOption(
                              //                 onPressed: () {
                              //                   Navigator.pop(context, "No");
                              //                 },
                              //                 child: Text(
                              //                   "No",
                              //                   style: TextStyle(
                              //                       color: Colors.redAccent,
                              //                       fontSize: 12.sp),
                              //                 ),
                              //               )
                              //             ],
                              //           );
                              //         })) {
                              //       case "Yes":
                              //         sendEmail();
                              //         break;
                              //       case "No":
                              //         ScaffoldMessenger.of(context)
                              //             .showSnackBar(
                              //           SnackBar(
                              //             backgroundColor:
                              //                 CustomColor.scaffoldColor,
                              //             content: Center(
                              //               child: Text(
                              //                 'Message is canceled.',
                              //                 style: TextStyle(
                              //                     color: Colors.redAccent,
                              //                     fontWeight: FontWeight.bold,
                              //                     fontSize: 17.sp),
                              //               ),
                              //             ),
                              //           ),
                              //         );
                              //         break;
                              //     }
                              //   },
                              //   icon: const Icon(Icons.send), // Icon of sending
                              //   label: Text(
                              //     'Send The Message',
                              //     style: TextStyle(
                              //         fontSize: 15.sp,
                              //         fontWeight: FontWeight.bold),
                              //   ), // Text of the button
                              // )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 35.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < socialMediaLinks.length; i++)
                            Tooltip(
                              message: "Open the link",
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      launchUrl(socialMediaLinks[i]["URL"],
                                          mode: LaunchMode.externalApplication);
                                    });
                                  },
                                  icon: Row(
                                    children: [
                                      Image.asset(
                                        socialMediaLinks[i]["path"],
                                        width: 34.5.w,
                                        height: 48.h,
                                        // fit: BoxFit.contain,
                                      ),
                                    ],
                                  )),
                            )
                        ],
                      ),
                      Divider(
                        color: CustomColor.bgLighter2,
                        thickness: 3.h,
                        indent: 25.w,
                        endIndent: 25.w,
                        height: 35.h,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     const Icon(Icons.mail_outline),
                      //     SelectableText("  elking.medo61111@gmail.com",
                      //         style: TextStyle(
                      //             color: const Color.fromARGB(
                      //                 195, 255, 255, 255),
                      //             fontWeight: FontWeight.w900,
                      //             fontSize: isDesktop ? 4.5.sp : 13.sp)),
                      //   ],
                      // ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text("Made by Eng Ramadan Mohamed with Flutter",
                          style: TextStyle(
                              color: Colors.white38,
                              fontWeight: FontWeight.w900,
                              fontSize: 13.sp)),
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
