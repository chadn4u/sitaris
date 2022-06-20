import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/feature/controller/themeController.dart';
import 'package:sitaris/route/routes.dart';
import 'package:sitaris/utils/utils.dart';
import 'package:sitaris/utils/validators.dart';

class RegisterController extends GetxController {
  late ThemeData theme;
  late OutlineInputBorder outlineInputBorder;
  late ThemeController themeController;
  RxBool enable = false.obs;
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    themeController = Get.put(ThemeController());
    theme = themeController.getTheme();
    outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  String? validateName(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter  name";
    }
    return null;
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter email";
    } else if (!FxStringValidator.isEmail(text)) {
      return "Please enter valid email";
    }
    return null;
  }

  String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter password";
    } else if (!FxStringValidator.validateStringRange(text, 6, 10)) {
      return "Password must be between 6 to 10";
    }
    return null;
  }

  void toggle() {
    enable.value = !enable.value;
    update();
  }

  void goToLoginScreen() {
    Utils.offAndToNamed(name: AppRoutes.LOGINSCREEN);
  }

  void register() {
    if (formKey.currentState!.validate()) {
      // Navigator.of(context, rootNavigator: true).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => RentalServiceFullApp(),
      //   ),
      // );
    }
  }
}
