// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:sitaris/feature/controller/user/homeController.dart';
import 'package:sitaris/feature/presentation/user/profile.dart';
import 'package:sitaris/utils/customBottomNavigation.dart';
import 'package:sitaris/utils/text.dart';
import 'package:sitaris/utils/textField.dart';
import 'package:sitaris/utils/textType.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int _currentIndex = 0;
  late ThemeData theme;
  // late CustomTheme customTheme;
  late HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(HomeController());
    controller.ctx = context;
    theme = controller.theme;
    // customTheme = AppTheme.customTheme;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: (_currentIndex == 3)
          ? AppBar(
              elevation: 0,
              backgroundColor: controller.theme.scaffoldBackgroundColor)
          : AppBar(
              toolbarHeight: 70,
              backgroundColor: Colors.grey.shade100,
              elevation: 0,
              title: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: FxTextField(
                          hintText: "Search",
                          prefixIcon: Icon(
                            FeatherIcons.search,
                            size: 18,
                            color:
                                theme.colorScheme.onBackground.withAlpha(150),
                          ),
                          filled: true,
                          isDense: true,
                          fillColor: Colors.white,
                          hintStyle: FxTextStyle.bodyMedium(),
                          labelStyle: FxTextStyle.bodyMedium(),
                          style: FxTextStyle.bodyMedium(),
                          textCapitalization: TextCapitalization.sentences,
                          labelText: "Search",
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          // cursorColor: customTheme.groceryPrimary,
                          focusedBorderColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: <Widget>[
          /*-------------- Build tab content here -----------------*/
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                controller.getWidgetProduct(),
                (controller.orderMasterModel.value.length > 0)
                    ? Padding(
                        padding:
                            const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
                        child:
                            FxText.titleSmall("Order Anda...", fontWeight: 600),
                      )
                    : Container(),
                controller.getWidgetOrder()
              ],
            ),
          ),
          const Center(
            child: FxText.titleMedium("Item 2", fontWeight: 600),
          ),
          const UserProfile()
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(
        animationDuration: const Duration(milliseconds: 350),
        selectedItemOverlayColor: theme.colorScheme.primary.withOpacity(0.8),
        backgroundColor: theme.colorScheme.background,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          controller.pageController!.jumpToPage(index);
        },
        items: <CustomBottomNavigationBarItem>[
          /*-------------- Build tabs here -----------------*/
          CustomBottomNavigationBarItem(
              title: 'Home',
              icon: const Icon(Icons.home),
              activeColor: theme.colorScheme.background,
              inactiveColor: theme.colorScheme.onBackground.withAlpha(180)),
          CustomBottomNavigationBarItem(
              title: 'Search',
              icon: const Icon(Icons.search),
              activeColor: theme.colorScheme.background,
              inactiveColor: theme.colorScheme.onBackground.withAlpha(180)),
          CustomBottomNavigationBarItem(
              title: 'Profile',
              icon: const Icon(Icons.people),
              activeColor: theme.colorScheme.background,
              inactiveColor: theme.colorScheme.onBackground.withAlpha(180)),
        ],
      ),
    );
  }

  onTapped(value) {
    setState(() {
      _currentIndex = value;
    });
  }
}

class CategoryWidget extends StatelessWidget {
  final IconData iconData;
  final String actionText;
  final bool isSelected;

  const CategoryWidget(
      {Key? key,
      required this.iconData,
      required this.actionText,
      this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 12),
      height: MediaQuery.of(context).size.height * 0.1,
      child: Column(
        children: <Widget>[
          ClipOval(
            child: Material(
              color: const Color(0xFFF1F4F8),
              // isSelected
              //     ? theme.colorScheme.primary
              //     : theme.colorScheme.primary.withAlpha(20),
              child: SizedBox(
                  width: 30,
                  height: 30,
                  child: Icon(iconData, color: const Color(0xFF57636C)
                      // isSelected
                      //     ? theme.colorScheme.onPrimary
                      //     : theme.colorScheme.primary,
                      )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: FxText.labelMedium(actionText,
                fontSize: 10,
                fontWeight: 600,
                letterSpacing: 0,
                textAlign: TextAlign.center),
          )
        ],
      ),
    );
  }
}
