// ignore_for_file: avoid_unnecessary_containers, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:sitaris/feature/controller/homeController.dart';
import 'package:sitaris/feature/presentation/account.dart';
import 'package:sitaris/feature/presentation/orders.dart';
import 'package:sitaris/feature/presentation/staff/scan.dart';
import 'package:sitaris/route/routes.dart';
import 'package:sitaris/utils/container.dart';
import 'package:sitaris/utils/enum.dart';
import 'package:sitaris/utils/fxCard.dart';
import 'package:sitaris/utils/scrollBehavior.dart';
import 'package:sitaris/utils/spacing.dart';
import 'package:sitaris/utils/text.dart';
import 'package:sitaris/utils/textField.dart';
import 'package:sitaris/utils/textType.dart';
import 'package:sitaris/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late HomeController controller;

  //
  @override
  void initState() {
    super.initState();
    controller = Get.put(HomeController());
    controller.tabController = TabController(
        length: 4, vsync: this, initialIndex: controller.selectedIndex.value);
    controller.tabController.addListener(() {
      controller.selectedIndex.value = controller.tabController.index;
    });
    controller.tabController.animation!.addListener(() {
      final aniValue = controller.tabController.animation!.value;
      if (aniValue - controller.selectedIndex.value > 0.5) {
        controller.selectedIndex.value = controller.selectedIndex.value + 1;
      } else if (aniValue - controller.selectedIndex.value < -0.5) {
        controller.selectedIndex.value = controller.selectedIndex.value - 1;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.scrollController.dispose();
    controller.tabController.dispose();
    Get.delete<HomeController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: (controller.selectedIndex.value == 1)
              ? AppBar(
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
                                color: controller.theme.colorScheme.onBackground
                                    .withAlpha(150),
                              ),
                              filled: true,
                              isDense: true,
                              fillColor: Colors.white,
                              hintStyle: FxTextStyle.bodyMedium(),
                              labelStyle: FxTextStyle.bodyMedium(),
                              style: FxTextStyle.bodyMedium(),
                              textCapitalization: TextCapitalization.sentences,
                              labelText: "Search",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              // cursorColor: customTheme.groceryPrimary,
                              focusedBorderColor: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : null,
          floatingActionButton: (controller.selectedIndex.value == 0 &&
                  controller.sessionController.roleId == '1')
              ? FloatingActionButton(
                  onPressed: () {
                    if (controller.state.value == LoadingProductState.INITIAL ||
                        controller.state.value == LoadingProductState.ERROR ||
                        controller.state.value == LoadingProductState.LOADED)
                      controller.showBottomSheet();
                  },
                  backgroundColor: Colors.blue,
                  child: (controller.state.value == LoadingProductState.LOADING)
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        )
                      : Icon(Icons.add),
                )
              : Container(),
          bottomNavigationBar: BottomAppBar(
              elevation: 0,
              shape: const CircularNotchedRectangle(),
              child: FxCard(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: TabBar(
                      controller: controller.tabController,
                      indicator: const BoxDecoration(),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: controller.theme.colorScheme.primary,
                      tabs: <Widget>[
                        Container(
                          child: (controller.selectedIndex.value == 0)
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.home,
                                      color:
                                          controller.theme.colorScheme.primary,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      decoration: BoxDecoration(
                                          color: controller.theme.primaryColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(2.5))),
                                      height: 5,
                                      width: 5,
                                    )
                                  ],
                                )
                              : Icon(
                                  Icons.home_outlined,
                                  color:
                                      controller.theme.colorScheme.onBackground,
                                ),
                        ),
                        Container(
                            child: (controller.selectedIndex.value == 1)
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(
                                        Icons.search,
                                        color: controller
                                            .theme.colorScheme.primary,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        decoration: BoxDecoration(
                                            color:
                                                controller.theme.primaryColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(2.5))),
                                        height: 5,
                                        width: 5,
                                      )
                                    ],
                                  )
                                : Icon(
                                    Icons.search_outlined,
                                    color: controller
                                        .theme.colorScheme.onBackground,
                                  )),
                        Container(
                            child: (controller.selectedIndex.value == 2)
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(
                                        Icons.qr_code,
                                        color: controller
                                            .theme.colorScheme.primary,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        decoration: BoxDecoration(
                                            color:
                                                controller.theme.primaryColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(2.5))),
                                        height: 5,
                                        width: 5,
                                      )
                                    ],
                                  )
                                : Icon(
                                    Icons.qr_code_outlined,
                                    color: controller
                                        .theme.colorScheme.onBackground,
                                  )),
                        Container(
                            child: (controller.selectedIndex.value == 3)
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(
                                        Icons.people,
                                        color: controller
                                            .theme.colorScheme.primary,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        decoration: BoxDecoration(
                                            color:
                                                controller.theme.primaryColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(2.5))),
                                        height: 5,
                                        width: 5,
                                      )
                                    ],
                                  )
                                : Icon(
                                    Icons.people_outline,
                                    color: controller
                                        .theme.colorScheme.onBackground,
                                  )),
                      ]))),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.tabController,
            children: <Widget>[
              _HomeScreen(),
              const OrderScreen(),
              const ScanScreen(),
              AccountScreen(),
            ],
          )),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
          padding: FxSpacing.only(top: FxSpacing.safeAreaTop(context) + 20),
          color: controller.theme.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: FxText.bodyMedium(
                          "Selamat datang, ${controller.sessionController.name!.value.toUpperCase()}.",
                          fontWeight: 600,
                          letterSpacing: 0.3)),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {
                          debugPrint('test');
                        },
                        child: const Icon(
                          Icons.notifications,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                child: GridView.count(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    crossAxisCount: 2,
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    mainAxisSpacing: 20,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    children: const <Widget>[
                      _SingleSubject(
                        completed: "Pekerjaan Tertunda",
                        subject: '10',
                        backgroundColor: Colors.blue,
                      ),
                      _SingleSubject(
                        completed: "Covernote Tertunda",
                        subject: '5',
                        backgroundColor: Colors.red,
                      ),
                    ]),
              ),
              // Container(
              //   padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              //   child: FxText.bodySmall("SUBMISSIONS",
              //       fontWeight: 600, letterSpacing: 0.3),
              // ),
              (controller.sessionController.roleId! == '2')
                  ? Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: buildCategories()),
                    )
                  : Container(),
              Container(
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 20),
                child: FxText.bodySmall(
                    (controller.sessionController.roleId! == '2')
                        ? "Pekerjaan wajib diselesaikan"
                        : "Order List",
                    fontWeight: 600,
                    letterSpacing: 0.3),
              ),
              Expanded(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: controller
                        .getListData() //_ListData(data: controller.dummyList),
                    ),
              )
            ],
          )),
    );
  }

  List<Widget> buildCategories() {
    final controller = Get.find<HomeController>();
    List<Widget> list = [];
    list.add(FxSpacing.width(24));
    for (int i = 0; i < controller.dummy.length; i++) {
      list.add(getSingleCategory(controller.dummy[i]));
      list.add(FxSpacing.width(16));
    }
    return list;
  }

  Widget getSingleCategory(Map<String, dynamic> category) {
    String heroTag = category["title"].hashCode.toString();

    return Hero(
      tag: heroTag,
      child: FxContainer(
        width: MediaQuery.of(Get.context!).size.width * 0.25,
        height: MediaQuery.of(Get.context!).size.height * 0.12,
        onTap: () {
          // Navigator.push(
          //     Get.context!,
          //     PageRouteBuilder(
          //         transitionDuration: Duration(milliseconds: 500),
          //         pageBuilder: (_, __, ___) =>
          //             GroceryCategoryScreen(context, category, heroTag)));
        },
        padding: FxSpacing.all(16),
        color: category["color"],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              category["icon"],
              size: 28,
            ),
            // Image.asset(
            //   category.image,
            //   width: 28,
            //   height: 28,
            // ),
            FxSpacing.height(4),
            FxText.labelSmall(
              category["title"],
              fontSize: 9,
              textAlign: TextAlign.center,
              color: controller.theme.colorScheme.onBackground,
            )
          ],
        ),
      ),
    );
  }
}

class ListData extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const ListData({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Obx(
      () => ScrollConfiguration(
        behavior: MyBehavior(),
        child: Scrollbar(
          controller: controller.scrollController,
          thickness: 8.0,
          thumbVisibility: true,
          interactive: true,
          child: ListView.builder(
            controller: controller.scrollController,
            padding: FxSpacing.all(0),
            itemCount: data.length,
            itemBuilder: (context, index) => Padding(
              padding: FxSpacing.xy(16, 12),
              child: InkWell(
                onTap: () {
                  debugPrint(data[index].toString());
                  if (controller.sessionController.roleId == "1") {
                    Utils.navigateTo(name: AppRoutes.DETAILORDERSCREEN, args: {
                      "orderDt": data[index]["dateForFormat"],
                      "orderNo": data[index]["orderNo"],
                      "orderId": data[index]["orderId"]
                    });
                  } else {
                    Utils.navigateTo(name: AppRoutes.DETAILTASKSCREEN, args: {
                      "order": data[index]["order"],
                      "product": data[index]["product"],
                      "tasktitle": data[index]["taskNm"]
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                        backgroundColor: Colors.grey.withBlue(10),
                        child: Center(
                          child: Image.asset(
                            data[index]["initial"],
                            height: 20,
                            width: 20,
                          ),
                        )),
                    FxSpacing.width(20),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FxText.titleSmall(
                                  data[index]["title"],
                                  fontWeight: 800,
                                ),
                                FxText.bodyMedium(
                                  data[index]['subtitle'],
                                  fontWeight: 600,
                                ),
                                FxText.titleSmall(
                                  "Debitur: ${data[index]["nama"]}",
                                  fontWeight: 600,
                                ),
                                FxText.titleSmall(
                                  "Status: ${data[index]["status"]}",
                                  fontWeight: 600,
                                ),
                              ],
                            ),
                          ),
                          FxText.titleSmall(
                            Utils.dateFormat(data[index]['dateForFormat']),
                            fontWeight: 600,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SingleSubject extends StatelessWidget {
  final Color backgroundColor;
  final String subject;
  final String completed;

  const _SingleSubject(
      {Key? key,
      required this.backgroundColor,
      required this.subject,
      required this.completed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FxContainer.none(
      borderRadiusAll: 4,
      color: backgroundColor,
      height: 125,
      child: Container(
        padding: const EdgeInsets.only(bottom: 20, left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Text(
            //   subject,
            //   style: const TextStyle(fontSize: 45, color: Colors.white),
            // ),
            FxText.titleLarge(
              subject,
              fontWeight: 600,
              color: Colors.white,
              fontSize: 45,
            ),
            FxText.bodySmall(completed,
                fontWeight: 500, color: Colors.white, letterSpacing: 0),
          ],
        ),
      ),
    );
  }
}
