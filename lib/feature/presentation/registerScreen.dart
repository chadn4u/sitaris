import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/feature/controller/registerController.dart';
import 'package:sitaris/utils/button.dart';
import 'package:sitaris/utils/constants.dart';
import 'package:sitaris/utils/spacing.dart';
import 'package:sitaris/utils/text.dart';
import 'package:sitaris/utils/textType.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final controller = Get.put(RegisterController());
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
              FxText.headlineLarge(
                "Create account",
                fontWeight: 700,
              ),
              FxText.bodyLarge(
                "Sign up to new account",
                fontWeight: 600,
              ),
              FxSpacing.height(40),
              registerForm(),
              FxSpacing.height(20),
              registerBtn(),
              FxSpacing.height(20),
              loginBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget registerForm() {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          nameField(),
          FxSpacing.height(20),
          emailField(),
          FxSpacing.height(20),
          passwordField(),
        ],
      ),
    );
  }

  Widget nameField() {
    return TextFormField(
      style: FxTextStyle.bodyMedium(),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          isDense: true,
          filled: true,
          hintText: "Full Name",
          enabledBorder: controller.outlineInputBorder,
          focusedBorder: controller.outlineInputBorder,
          border: controller.outlineInputBorder,
          prefixIcon: Icon(Icons.person),
          contentPadding: FxSpacing.all(16),
          hintStyle: FxTextStyle.bodyMedium(xMuted: true),
          isCollapsed: true),
      maxLines: 1,
      controller: controller.nameController,
      validator: controller.validateName,
      cursorColor: controller.theme.colorScheme.onBackground,
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
          prefixIcon: Icon(Icons.person),
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
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: InkWell(
              onTap: () {
                controller.toggle();
              },
              child: Icon(controller.enable.value
                  ? Icons.visibility_off
                  : Icons.visibility),
            ),
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

  Widget registerBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FxText.headlineLarge(
          "Create",
          fontWeight: 700,
        ),
        FxSpacing.width(20),
        FxButton(
          onPressed: () {
            controller.register();
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

  Widget loginBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FxText.bodySmall(
          "Already have an account?",
        ),
        FxButton.text(
          onPressed: () {
            controller.goToLoginScreen();
          },
          padding: FxSpacing.y(8),
          child: FxText.bodySmall(
            "Sign In",
            color: controller.theme.colorScheme.primary,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
