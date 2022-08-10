import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:sitaris/utils/container.dart';
import 'package:sitaris/utils/spacing.dart';
import 'package:sitaris/utils/text.dart';

import '../../controller/user/homeController.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({Key? key}) : super(key: key);

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
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
    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          title: FxText.bodyLarge("Upload Berkas",
              color: Colors.black, fontWeight: 600),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: ListView(
          padding: FxSpacing.zero,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: FxSpacing.fromLTRB(24, 0, 0, 0),
                  child: FxText.bodySmall("DUE",
                      fontWeight: 700, muted: true, color: Colors.black),
                ),
                Container(
                  margin: FxSpacing.top(8),
                  child: singleTask(
                    subject: "Biology",
                    statusText: "Over due",
                    submissionDate: "31/07/20",
                    status: 0,
                    task: "Lesson 1",
                  ),
                ),
                singleTask(
                    subject: "Mathematics",
                    task: "Example 2",
                    statusText: "Not submit",
                    status: 1,
                    submissionDate: "22/07/20"),
                singleTask(
                    subject: "History",
                    task: "Example 2",
                    statusText: "Not submit",
                    status: 1,
                    submissionDate: "20/07/20"),
              ],
            )
          ],
        ));
  }

  Widget singleTask(
      {String? subject,
      String? task,
      String? submissionDate,
      String? statusText,
      int status = 0}) {
    IconData iconData;
    Color iconBG, iconColor, statusColor;
    switch (status) {
      case 0:
        iconBG = Colors.red;
        iconColor = Colors.white;
        iconData = FeatherIcons.plus;
        statusColor = Colors.red;
        break;
      case 1:
        iconBG = theme.colorScheme.primary;
        iconColor = theme.colorScheme.onPrimary;
        iconData = FeatherIcons.check;
        statusColor = theme.colorScheme.primary;
        break;

      default:
        iconBG = Colors.red;
        iconColor = Colors.white;
        iconData = FeatherIcons.plus;
        statusColor = Colors.red;
        break;
    }

    return FxContainer.bordered(
      paddingAll: 16,
      margin: FxSpacing.fromLTRB(24, 8, 24, 8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      borderRadiusAll: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: FxSpacing.all(6),
            decoration: BoxDecoration(color: iconBG, shape: BoxShape.circle),
            child: Icon(
              iconData,
              color: iconColor,
              size: 20,
            ),
          ),
          Expanded(
            child: Container(
              margin: FxSpacing.left(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FxText.bodyLarge(subject!,
                      color: theme.colorScheme.onBackground, fontWeight: 600),
                  Container(
                    margin: FxSpacing.top(2),
                    child: FxText.bodySmall(
                      task!,
                      color: theme.colorScheme.onBackground.withAlpha(160),
                      fontWeight: 600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              FxText.bodySmall(submissionDate!,
                  fontSize: 12,
                  letterSpacing: 0.2,
                  color: theme.colorScheme.onBackground,
                  muted: true,
                  fontWeight: 600),
              Container(
                margin: FxSpacing.top(2),
                child: FxText.bodyMedium(statusText!,
                    color: statusColor,
                    letterSpacing: 0,
                    fontWeight: status == 3 ? 600 : 500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
