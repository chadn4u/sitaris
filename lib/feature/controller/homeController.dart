import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/feature/controller/themeController.dart';

class HomeController extends GetxController {
  late ThemeData theme;
  late ThemeController themeController;

  late List<Map<String, dynamic>> dummy;
  late List<Map<String, dynamic>> dummyList;

  ScrollController scrollController = ScrollController();
  late TabController tabController;
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    themeController = Get.find<ThemeController>();

    theme = themeController.getTheme();

    dummy = [
      {
        "title": "Terima Berkas",
        "color": Colors.blue.shade100,
        "icon": Icons.book
      },
      {"title": "Covernote", "color": Colors.red.shade100, "icon": Icons.note},
      {
        "title": "Pengeluaran",
        "color": Colors.green.shade100,
        "icon": Icons.exit_to_app
      },
    ];

    dummyList = [
      {
        "initial": "C",
        "nama": "Chad",
        "tanggal": "20 Jan 2022",
        "title": "Bank BRI KC Juanda",
        "subtitle": "No. Order: #12345",
      },
      {
        "initial": "C",
        "nama": "Chad",
        "tanggal": "20 Jan 2022",
        "title": "Bank BRI KC Juanda",
        "subtitle": "No. Order: #12345",
      },
      {
        "initial": "C",
        "nama": "Chad",
        "tanggal": "20 Jan 2022",
        "title": "Bank BRI KC Juanda",
        "subtitle": "No. Order: #12345",
      },
      {
        "initial": "C",
        "nama": "Chad",
        "tanggal": "20 Jan 2022",
        "title": "Bank BRI KC Juanda",
        "subtitle": "No. Order: #12345",
      },
      {
        "initial": "C",
        "nama": "Chad",
        "tanggal": "20 Jan 2022",
        "title": "Bank BRI KC Juanda",
        "subtitle": "No. Order: #12345",
      },
      {
        "initial": "C",
        "nama": "Chad",
        "tanggal": "20 Jan 2022",
        "title": "Bank BRI KC Juanda",
        "subtitle": "No. Order: #12345",
      },
      {
        "initial": "C",
        "nama": "Chad",
        "tanggal": "20 Jan 2022",
        "title": "Bank BRI KC Juanda",
        "subtitle": "No. Order: #12345",
      },
      {
        "initial": "C",
        "nama": "Chad",
        "tanggal": "20 Jan 2022",
        "title": "Bank BRI KC Juanda",
        "subtitle": "No. Order: #12345",
      },
      {
        "initial": "C",
        "nama": "Chad",
        "tanggal": "20 Jan 2022",
        "title": "Bank BRI KC Juanda",
        "subtitle": "No. Order: #12345",
      },
      {
        "initial": "C",
        "nama": "Chad",
        "tanggal": "20 Jan 2022",
        "title": "Bank BRI KC Juanda",
        "subtitle": "No. Order: #12345",
      },
      {
        "initial": "C",
        "nama": "Chad",
        "tanggal": "20 Jan 2022",
        "title": "Bank BRI KC Juanda",
        "subtitle": "No. Order: #12345",
      },
      {
        "initial": "C",
        "nama": "Chad",
        "tanggal": "20 Jan 2022",
        "title": "Bank BRI KC Juanda",
        "subtitle": "No. Order: #12345",
      },
      {
        "initial": "C",
        "nama": "Chad",
        "tanggal": "20 Jan 2022",
        "title": "Bank BRI KC Juanda",
        "subtitle": "No. Order: #12345",
      },
      {
        "initial": "C",
        "nama": "Chad",
        "tanggal": "20 Jan 2022",
        "title": "Bank BRI KC Juanda",
        "subtitle": "No. Order: #12345",
      },
      {
        "initial": "C",
        "nama": "Chad",
        "tanggal": "20 Jan 2022",
        "title": "Bank BRI KC Juanda",
        "subtitle": "No. Order: #12345",
      },
      {
        "initial": "C",
        "nama": "Chad",
        "tanggal": "20 Jan 2022",
        "title": "Bank BRI KC Juanda",
        "subtitle": "No. Order: #12345",
      },
    ];
  }
}
