import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio/widgets/message_animated_icon.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class DesktopContactWidget extends StatefulWidget {
  const DesktopContactWidget({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.messageController,
    required this.sendEmail,
  });
  final Function sendEmail;

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;

  @override
  State<DesktopContactWidget> createState() => _DesktopContactWidgetState();
}

class _DesktopContactWidgetState extends State<DesktopContactWidget> {
  ButtonState stateOnlyText = ButtonState.idle;

  ButtonState stateTextWithIcon = ButtonState.idle;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  width: MediaQuery.sizeOf(context).width / 2.4,
                  child: TextField(
                    controller: widget.nameController,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.account_circle_rounded),
                      filled: true,
                      labelText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2.4,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: widget.emailController,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.alternate_email_outlined),
                      filled: true,
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
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
              controller: widget.messageController,
              decoration: const InputDecoration(
                suffixIcon: MessageAnimatedIcon(),
                filled: true,
                hintText: 'Message',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            ProgressButton.icon(
                radius: 16,
                textStyle:
                    TextStyle(fontSize: 5.7.sp, fontWeight: FontWeight.bold),
                maxWidth: MediaQuery.sizeOf(context).width * 2 / 2.4 + 7.w,
                minWidth: MediaQuery.sizeOf(context).width * 2 / 2.4 + 7.w,
                height: 50.h,
                iconedButtons: {
                  ButtonState.idle: const IconedButton(
                      text: 'Send The Message',
                      icon: Icon(Icons.send, color: Colors.white),
                      color: Color(0xff36323F)),
                  ButtonState.loading: IconedButton(
                      text: 'Loading',
                      color: const Color(0xff36323F).withOpacity(0.6)),
                  ButtonState.fail: IconedButton(
                      text: 'Message is canceled',
                      icon: const Icon(Icons.cancel, color: Colors.white),
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
                              fontSize: 6.1.sp,
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
                                  fontSize: 5.5.sp,
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
                                        stateTextWithIcon = ButtonState.fail;
                                      },
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "No",
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 5.5.sp),
                              ),
                            )
                          ],
                        );
                      })) {
                    case "Yes":
                      widget.sendEmail();
                      stateTextWithIcon = ButtonState.success;
                      await Future.delayed(
                        const Duration(seconds: 2),
                        () {},
                      );
                      setState(
                        () {
                          stateTextWithIcon = ButtonState.idle;
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
                          stateTextWithIcon = ButtonState.fail;
                        },
                      );
                      await Future.delayed(
                        const Duration(seconds: 1),
                        () {
                          setState(
                            () {
                              stateTextWithIcon = ButtonState.idle;
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
          ],
        ),
      ),
    );
  }
}
