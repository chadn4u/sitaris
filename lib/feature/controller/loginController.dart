import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/feature/controller/themeController.dart';
import 'package:sitaris/route/routes.dart';
import 'package:sitaris/utils/utils.dart';
import 'package:sitaris/utils/validators.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late OutlineInputBorder outlineInputBorder;
  late ThemeData theme;
  late ThemeController themeController;
  RxBool enable = false.obs;
  @override
  void onInit() {
    super.onInit();
    outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
    themeController = Get.find<ThemeController>();
    theme = themeController.getTheme();
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter email";
    } else if (FxStringValidator.isEmail(text)) {
      return "Please enter valid email";
    }
    return null;
  }

  void toggle() {
    enable.value = !enable.value;
    update();
  }

  String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter password";
    } else if (!FxStringValidator.validateStringRange(text, 6, 10)) {
      return "Password must be between 6 to 10";
    }
    return null;
  }

  void login() {
    if (formKey.currentState!.validate()) {
      Utils.offAndToNamed(name: AppRoutes.HOMESCREEN);
      // Navigator.of(Get.context!, rootNavigator: true).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => RentalServiceFullApp(),
      //   ),
      // );
    }
  }

  void goToForgotPasswordScreen() {
    Utils.offAndToNamed(name: AppRoutes.FORGOTSCREEN);
  }

  void goToRegisterScreen() {
    Utils.offAndToNamed(name: AppRoutes.REGISTERSCREEN);
  }
}
