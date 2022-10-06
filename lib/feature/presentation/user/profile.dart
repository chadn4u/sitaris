// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:sitaris/feature/controller/user/homeController.dart';
import 'package:sitaris/utils/spacing.dart';
import 'package:sitaris/utils/text.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late HomeController controller;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    controller = Get.find<HomeController>();
    theme = controller.theme;
    // customTheme = AppTheme.customTheme;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: ListView(
            padding: const EdgeInsets.all(24),
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        shape: BoxShape.circle,
                        // image: DecorationImage(
                        //     image:
                        //         AssetImage("./assets/images/profile/avatar_3.jpg"),
                        //     fit: BoxFit.fill),
                      ),
                      child: const Icon(Icons.person),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: FxText.titleMedium(
                          controller.sessionController.name!.value
                              .toUpperCase(),
                          fontWeight: 600,
                          letterSpacing: 0),
                    ),
                  ],
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(top: 24),
              //   padding: EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 16),
              //   decoration: BoxDecoration(
              //       color: Colors.purple,
              //       borderRadius: BorderRadius.all(Radius.circular(4))),
              //   child: InkWell(
              //     onTap: () {
              //       // Navigator.push(
              //       //     context,
              //       //     MaterialPageRoute(
              //       //         builder: (context) => HandymanSubscriptionScreen()));
              //     },
              //     child: Row(
              //       children: <Widget>[
              //         Icon(FeatherIcons.info, color: Colors.black, size: 18),
              //         Container(
              //           margin: EdgeInsets.only(left: 16),
              //           child: FxText.bodyMedium("Premium member",
              //               color: Colors.amber,
              //               fontWeight: 600,
              //               letterSpacing: 0.2),
              //         ),
              //         Expanded(
              //           child: Container(
              //             alignment: Alignment.centerRight,
              //             child: FxText.bodySmall("Upgrade",
              //                 color: Colors.black,
              //                 fontWeight: 600,
              //                 letterSpacing: 0.2),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: Column(
                  children: <Widget>[
                    singleOption(
                        iconData: Icons.person, option: "Edit Profile"),
                    const Divider(),
                    singleOption(
                        iconData: FeatherIcons.mail,
                        option: "Notification",
                        navigation: Container()),
                    const Divider(),
                    singleOption(
                        iconData: FeatherIcons.helpCircle,
                        option: "Help \& Support",
                        navigation: Container()),
                    const Divider(),
                    singleOption(
                        iconData: FeatherIcons.userPlus,
                        option: "About Us",
                        navigation: Container()),
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(FxSpacing.xy(16, 0))),
                        onPressed: () {
                          controller.logout();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Icon(
                              FeatherIcons.logOut,
                              color: Colors.white,
                              size: 18,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 16),
                              child: const FxText.bodySmall("LOGOUT",
                                  letterSpacing: 0.3,
                                  fontWeight: 600,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget singleOption(
      {IconData? iconData, required String option, Widget? navigation}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: InkWell(
        onTap: () {
          if (navigation != null) {
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => navigation));
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              iconData,
              size: 22,
              color: Colors.black,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                child: FxText.bodyLarge(option, fontWeight: 600),
              ),
            ),
            const Icon(FeatherIcons.arrowRight, size: 22, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
