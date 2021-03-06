import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sitaris/feature/controller/loginController.dart';
import 'package:sitaris/utils/button.dart';
import 'package:sitaris/utils/constants.dart';
import 'package:sitaris/utils/spacing.dart';

import '../../utils/text.dart';
import '../../utils/textType.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.find<LoginController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding:
          FxSpacing.fromLTRB(20, FxSpacing.safeAreaTop(context) + 20, 20, 20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FxText.displayLarge(
              "Hello",
              fontWeight: 700,
            ),
            FxText.bodyLarge(
              "Sign in to your account",
              fontWeight: 600,
            ),
            FxSpacing.height(40),
            loginForm(),
            FxSpacing.height(12),
            forgotPassword(),
            FxSpacing.height(20),
            loginButton(),
            FxSpacing.height(20),
            registerBtn(),
          ],
        ),
      ),
    ));
  }

  Widget loginForm() {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          emailField(),
          FxSpacing.height(20),
          passwordField(),
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

  Widget passwordField() {
    return Obx(
      () => TextFormField(
        style: FxTextStyle.bodyMedium(),
        keyboardType: TextInputType.text,
        obscureText: controller.enable.value ? false : true,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            isDense: true,
            filled: true,
            hintText: "Password",
            enabledBorder: controller.outlineInputBorder,
            focusedBorder: controller.outlineInputBorder,
            border: controller.outlineInputBorder,
            prefixIcon: Icon(Icons.lock),
            suffixIcon: InkWell(
                onTap: () {
                  controller.toggle();
                },
                child: Icon(controller.enable.value
                    ? Icons.visibility_off
                    : Icons.visibility)),
            contentPadding: FxSpacing.all(16),
            hintStyle: FxTextStyle.bodyMedium(xMuted: true),
            isCollapsed: true),
        maxLines: 1,
        controller: controller.passwordController,
        validator: controller.validatePassword,
        cursorColor: controller.theme.colorScheme.onBackground,
      ),
    );
  }

  Widget loginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FxText.headlineLarge(
          "Sign In",
          fontWeight: 700,
        ),
        FxSpacing.width(20),
        FxButton(
          onPressed: () {
            controller.login();
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

  Widget forgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: FxButton.text(
        onPressed: () {
          controller.goToForgotPasswordScreen();
        },
        elevation: 0,
        padding: FxSpacing.y(4),
        borderRadiusAll: Constant.buttonRadius.small,
        child: FxText.bodySmall(
          "Forgot your Password?",
          color: controller.theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget registerBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FxText.bodySmall(
          "Don't have an account?",
        ),
        FxButton.text(
          onPressed: () {
            controller.goToRegisterScreen();
          },
          padding: FxSpacing.y(8),
          child: FxText.bodySmall(
            "Create",
            color: controller.theme.colorScheme.primary,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
