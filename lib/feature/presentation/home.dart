import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/feature/controller/homeController.dart';
import 'package:sitaris/feature/presentation/account.dart';
import 'package:sitaris/feature/presentation/orders.dart';
import 'package:sitaris/feature/presentation/scan.dart';
import 'package:sitaris/utils/container.dart';
import 'package:sitaris/utils/fxCard.dart';
import 'package:sitaris/utils/scrollBehavior.dart';
import 'package:sitaris/utils/spacing.dart';
import 'package:sitaris/utils/text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late HomeController controller;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(
          () => BottomAppBar(
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
                                        Icons.list_alt,
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
                                    Icons.list_alt_outlined,
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
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.tabController,
          children: <Widget>[
            _HomeScreen(),
            const OrderScreen(),
            const ScanScreen(),
            AccountScreen(),
          ],
        ));
  }
}

class _HomeScreen extends StatelessWidget {
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: FxText.bodyMedium("Selamat datang, Tia.",
                        fontWeight: 600, letterSpacing: 0.3)),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        print('test');
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
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: buildCategories()),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 20),
              child: FxText.bodySmall("Pekerjaan wajib diselesaikan",
                  fontWeight: 600, letterSpacing: 0.3),
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: _ListData(data: controller.dummyList),
              ),
            )
          ],
        ));
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
              fontSize: 10,
              textAlign: TextAlign.center,
              color: controller.theme.colorScheme.onBackground,
            )
          ],
        ),
      ),
    );
  }
}

class _ListData extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const _ListData({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return ScrollConfiguration(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: controller.theme.colorScheme.primary,
                  child: FxText(
                    data[index]["initial"],
                    color: controller.theme.colorScheme.onPrimary,
                  ),
                ),
                FxSpacing.width(20),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            FxText.titleSmall(
                              data[index]["title"],
                              fontWeight: 600,
                            ),
                            FxText.bodyMedium(
                              data[index]['subtitle'],
                              fontWeight: 600,
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      FxText.titleSmall(
                        data[index]['tanggal'],
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
