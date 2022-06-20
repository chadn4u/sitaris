import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sitaris/feature/controller/forgotPassController.dart';
import 'package:sitaris/utils/constants.dart';
import 'package:sitaris/utils/spacing.dart';
import 'package:sitaris/utils/text.dart';
import 'package:sitaris/utils/textType.dart';

import '../../utils/button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  late ForgotPasswordController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(ForgotPasswordController());
    return Scaffold(
      body: Padding(
        padding:
            FxSpacing.fromLTRB(20, FxSpacing.safeAreaTop(context) + 20, 20, 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FxText.headlineLarge(
                "Forgot Password?",
                fontWeight: 700,
              ),
              FxText.bodyLarge(
                "Enter email to proceed further",
                fontWeight: 600,
              ),
              FxSpacing.height(40),
              forgotPasswordForm(),
              FxSpacing.height(20),
              submitButton(),
              FxSpacing.height(10),
              registerBtn()
            ],
          ),
        ),
      ),
    );
  }

  Widget forgotPasswordForm() {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          emailField(),
        ],
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      style: FxTextStyle.bodyMedium(),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          isDense: true,
          filled: true,
          hintText: "Email Address",
          enabledBorder: controller.outlineInputBorder,
          focusedBorder: controller.outlineInputBorder,
          border: controller.outlineInputBorder,
          prefixIcon: const Icon(Icons.person),
          contentPadding: FxSpacing.all(16),
          hintStyle: FxTextStyle.bodyMedium(xMuted: true),
          isCollapsed: true),
      maxLines: 1,
      controller: controller.emailController,
      validator: controller.validateEmail,
      cursorColor: controller.theme.colorScheme.onBackground,
    );
  }

  Widget submitButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FxText.headlineLarge(
          "Submit",
          fontWeight: 700,
        ),
        FxSpacing.width(20),
        FxButton.small(
          onPressed: () {
            controller.forgotPassword();
          },
          elevation: 0,
          borderRadiusAll: Constant.buttonRadius.xs,
          child: Icon(
            Icons.keyboard_arrow_right,
            color: controller.theme.colorScheme.onPrimary,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget registerBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FxText.bodySmall(
          "Not a Member?",
        ),
        FxSpacing.width(8),
        FxButton.text(
            onPressed: () {
              controller.goToRegisterScreen();
            },
            padding: FxSpacing.y(8),
            child: FxText.bodySmall(
              "Register",
              color: controller.theme.colorScheme.primary,
              decoration: TextDecoration.underline,
            ))
      ],
    );
  }
}
