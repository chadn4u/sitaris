import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationService extends GetxService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {Map<String, dynamic>? args}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: args);
  }

  void goBack() {
    // print(navigatorKey.currentState);
    return navigatorKey.currentState!.pop();
  }
}
