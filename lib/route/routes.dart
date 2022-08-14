// ignore_for_file: constant_identifier_names

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sitaris/feature/presentation/forgotPassScreen.dart';
import 'package:sitaris/feature/presentation/home.dart';
import 'package:sitaris/feature/presentation/loginScreen.dart';
import 'package:sitaris/feature/presentation/onBoard.dart';
import 'package:sitaris/feature/presentation/registerScreen.dart';
import 'package:sitaris/feature/presentation/user/home.dart';

class AppRoutes {
  static const String LOGINSCREEN = '/loginScreen';
  static const String REGISTERSCREEN = '/registerScreen';
  static const String FORGOTSCREEN = '/forgotScreen';
  static const String ONBOARDSCREEN = '/onBoardSCreen';

  //staff
  static const String HOMESCREEN = '/homeScreen';

  //user
  static const String USERHOMESCREEN = '/userHomeScreen';
}

class RoutingClass {
  // ignore: non_constant_identifier_names
  static List<GetPage<dynamic>> LISTPAGE = [
    GetPage(name: AppRoutes.LOGINSCREEN, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.REGISTERSCREEN, page: () => RegisterScreen()),
    GetPage(name: AppRoutes.FORGOTSCREEN, page: () => ForgotPasswordScreen()),

    GetPage(name: AppRoutes.ONBOARDSCREEN, page: () => const OnBoardScreen()),

    //staff
    GetPage(name: AppRoutes.HOMESCREEN, page: () => const HomeScreen()),

    //User
    GetPage(name: AppRoutes.USERHOMESCREEN, page: () => const UserHomeScreen())
  ];
}
