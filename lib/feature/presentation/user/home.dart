import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:sitaris/feature/controller/user/homeController.dart';
import 'package:sitaris/feature/presentation/user/createOrder.dart';
import 'package:sitaris/feature/presentation/user/profile.dart';
import 'package:sitaris/route/routes.dart';
import 'package:sitaris/utils/container.dart';
import 'package:sitaris/utils/customBottomNavigation.dart';
import 'package:sitaris/utils/spacing.dart';
import 'package:sitaris/utils/text.dart';
import 'package:sitaris/utils/textField.dart';
import 'package:sitaris/utils/textType.dart';
import 'package:sitaris/utils/utils.dart';

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
                      FxSpacing.width(16),
                      //Space.width(16),
                      FxContainer(
                        color: theme.primaryColor.withAlpha(32),
                        child: Icon(
                          FeatherIcons.camera,
                          color: theme.primaryColor,
                          size: 20,
                        ),
                      )
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.8,
                          blurRadius: 1,
                          offset:
                              const Offset(1, 1), // changes position of shadow
                        ),
                      ],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      color: theme.scaffoldBackgroundColor),
                  child: Obx(
                    () => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...controller.listMenu
                              .map((e) => Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        if (e.prodId == "0") {
                                          controller.openBottomSheet();
                                        }
                                        Utils.navigateTo(
                                            name: AppRoutes.USERCREATEORDER,
                                            args: {"data": e});
                                      },
                                      child: CategoryWidget(
                                        iconData:
                                            controller.getIcon(e!.prodId!),
                                        actionText: e.prodNm!,
                                        isSelected: false,
                                      ),
                                    ),
                                  ))
                              .toList()
                          // [...list.map((e) => _card(e)).toList()]
                        ]
                        // <Widget>[

                        // Expanded(
                        //   child: InkWell(
                        //     onTap: () {
                        //       _pageController!.jumpToPage(4);
                        //     },
                        //     child: const _CategoryWidget(
                        //       iconData: FFIcons.k023Division,
                        //       actionText: "Hibah",
                        //       isSelected: false,
                        //     ),
                        //   ),
                        // ),

                        // ],
                        ),
                  ),
                ),
              ),
              // Expanded(
              //   child: Center(
              //     child: noData(),
              //   ),
              // )

              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
                child: FxText.titleSmall("Order Anda...", fontWeight: 600),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) => singleWorker(
                      name: 'Chad',
                      profession: 'Programmer',
                      status: 'Permanent'),
                ),
              )
            ],
          ),
          const Center(
            child: FxText.titleMedium("Item 2", fontWeight: 600),
          ),
          const Center(
            child: FxText.titleMedium("Item 3", fontWeight: 600),
          ),
          const UserProfile()
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(
        animationDuration: const Duration(milliseconds: 350),
        selectedItemOverlayColor: theme.colorScheme.primary.withAlpha(48),
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
              activeColor: theme.colorScheme.primary,
              inactiveColor: theme.colorScheme.onBackground.withAlpha(180)),
          CustomBottomNavigationBarItem(
              title: 'Search',
              icon: const Icon(Icons.search),
              activeColor: theme.colorScheme.primary,
              inactiveColor: theme.colorScheme.onBackground.withAlpha(180)),
          CustomBottomNavigationBarItem(
              title: 'Cart',
              icon: const Icon(FeatherIcons.shoppingCart),
              activeColor: theme.colorScheme.primary,
              inactiveColor: theme.colorScheme.onBackground.withAlpha(180)),
          CustomBottomNavigationBarItem(
              title: 'Profile',
              icon: const Icon(Icons.people),
              activeColor: theme.colorScheme.primary,
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

  Widget noData() {
    return Container(
      margin: FxSpacing.fromLTRB(24, 36, 24, 0),
      padding: FxSpacing.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FxText.bodyLarge("Hello, Chad!",
                  color: theme.colorScheme.onPrimary, fontWeight: 600),
            ],
          ),
          Container(
            margin: FxSpacing.top(8),
            width: MediaQuery.of(context).size.width * 0.6,
            child: FxText.bodyMedium('Saat ini kamu belum melakukan order.',
                color: theme.colorScheme.onPrimary,
                fontWeight: 400,
                muted: true),
          ),
        ],
      ),
    );
  }

  Widget singleWorker(
      {required String name,
      required String profession,
      double? perHour,
      double? rate,
      required String status,
      Color? statusColor}) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: InkWell(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => WorkerInformationScreen()));
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8, 8, 4, 8),
                child: Container(
                  width: 4,
                  height: 90,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      color: controller.theme.primaryColor),

                  // child: ClipRRect(
                  //   borderRadius: BorderRadius.all(Radius.circular(8)),
                  //   child: Image(
                  //     image: AssetImage(image),
                  //     width: 72,
                  //     height: 72,
                  //   ),
                  // ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12, 12, 16, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FxText.titleLarge(
                      name,
                      color: theme.colorScheme.onBackground,
                      fontWeight: 600,
                    ),
                    FxText.bodyMedium(
                      profession,
                      color: theme.colorScheme.onBackground,
                      fontWeight: 600,
                    ),
                    FxText.bodyMedium(
                      "Progress: Pengecekan Berkas",
                      color: theme.colorScheme.onBackground,
                      fontWeight: 600,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
    ThemeData theme = Theme.of(context);
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
