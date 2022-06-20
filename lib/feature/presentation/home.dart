import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/feature/controller/homeController.dart';
import 'package:sitaris/utils/container.dart';
import 'package:sitaris/utils/spacing.dart';
import 'package:sitaris/utils/text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController controller;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = Get.put(HomeController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (i) {
              setState(() {
                selectedIndex = i;
              });
            },
            selectedIconTheme: IconThemeData(color: Colors.blue, size: 30),
            selectedItemColor: Colors.blue,
            selectedLabelStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            unselectedIconTheme: IconThemeData(color: Colors.black, size: 25),
            unselectedItemColor: Colors.black,
            unselectedLabelStyle: TextStyle(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.note), label: "Orders"),
              BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "Scan"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people), label: "Account")
            ]),
        body: Container(
            color: controller.theme.backgroundColor,
            child: ListView(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: FxText.bodyMedium("Selamat datang, Tia.",
                        fontWeight: 600, letterSpacing: 0.3)),
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
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: buildCategories()),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: FxText.bodySmall("Pekerjaan wajib diselesaikan",
                      fontWeight: 600, letterSpacing: 0.3),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: _ListData(data: controller.dummyList),
                )
              ],
            )));
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
        width: 120,
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
    return ListView.builder(
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
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: FxText.titleSmall(
                          data[index]['nama'],
                          fontWeight: 600,
                        ),
                      ),
                      FxText.titleSmall(
                        data[index]['tanggal'],
                        fontWeight: 600,
                      ),
                    ],
                  ),
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
            )
          ],
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
