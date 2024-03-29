// ignore_for_file: constant_identifier_names

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sitaris/feature/presentation/qrView.dart';
import 'package:sitaris/feature/presentation/user/detailOrder.dart';
import 'package:sitaris/feature/presentation/forgotPassScreen.dart';
import 'package:sitaris/feature/presentation/home.dart';
import 'package:sitaris/feature/presentation/imageZoom.dart';
import 'package:sitaris/feature/presentation/loginScreen.dart';
import 'package:sitaris/feature/presentation/onBoard.dart';
import 'package:sitaris/feature/presentation/registerScreen.dart';
import 'package:sitaris/feature/presentation/staff/detailTask.dart';
import 'package:sitaris/feature/presentation/user/createOrder.dart';
import 'package:sitaris/feature/presentation/user/detailTaskUser.dart';
import 'package:sitaris/feature/presentation/user/home.dart';

class AppRoutes {
  static const String LOGINSCREEN = '/loginScreen';
  static const String REGISTERSCREEN = '/registerScreen';
  static const String FORGOTSCREEN = '/forgotScreen';
  static const String ONBOARDSCREEN = '/onBoardScreen';
  static const String ZOOMSCREEN = '/zoomScreen';
  static const String DETAILORDERSCREEN = '/detailOrderScreen';
  static const String QRSCREEN = '/qrScreen';

  //staff
  static const String HOMESCREEN = '/homeScreen';
  static const String DETAILTASKSCREEN = '/detailTaskScreen';

  //user
  static const String USERHOMESCREEN = '/userHomeScreen';
  static const String USERCREATEORDER = '/userCreateOrder';
  static const String DETAILTASKUSER = '/detailTaskUser';
}

class RoutingClass {
  // ignore: non_constant_identifier_names
  static List<GetPage<dynamic>> LISTPAGE = [
    GetPage(name: AppRoutes.LOGINSCREEN, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.REGISTERSCREEN, page: () => RegisterScreen()),
    GetPage(name: AppRoutes.FORGOTSCREEN, page: () => ForgotPasswordScreen()),
    GetPage(name: AppRoutes.ZOOMSCREEN, page: () => ImageZoom()),
    GetPage(name: AppRoutes.ONBOARDSCREEN, page: () => const OnBoardScreen()),
    GetPage(name: AppRoutes.DETAILORDERSCREEN, page: () => DetailOrderScreen()),
    GetPage(name: AppRoutes.QRSCREEN, page: () => QRPage()),

    //staff
    GetPage(name: AppRoutes.HOMESCREEN, page: () => const HomeScreen()),
    GetPage(
        name: AppRoutes.DETAILTASKSCREEN, page: () => const DetailTaskPage()),

    //User
    GetPage(name: AppRoutes.USERHOMESCREEN, page: () => const UserHomeScreen()),
    GetPage(
        name: AppRoutes.USERCREATEORDER, page: () => const CreateOrderScreen()),
    GetPage(
        name: AppRoutes.DETAILTASKUSER, page: () => const DetailTaskUserPage())
  ];
}
