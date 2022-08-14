// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/feature/controller/themeController.dart';
import 'package:sitaris/route/routes.dart';
import 'package:sitaris/utils/utils.dart';
import 'package:sitaris/utils/validators.dart';

class ForgotPasswordController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();

  late OutlineInputBorder outlineInputBorder;
  late ThemeData theme;
  late ThemeController themeController;
  @override
  void onInit() {
    super.onInit();
    themeController = Get.find<ThemeController>();
    theme = themeController.getTheme();
    outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter email";
    } else if (FxStringValidator.isEmail(text)) {
      return "Please enter valid email";
    }
    return null;
  }

  void goToRegisterScreen() {
    Utils.offAndToNamed(name: AppRoutes.REGISTERSCREEN);
  }

  void forgotPassword() {
    // if (formKey.currentState!.validate()) {
    //   Navigator.of(context, rootNavigator: true).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => ResetPasswordScreen(),
    //     ),
    //   );
    // }
  }
}
