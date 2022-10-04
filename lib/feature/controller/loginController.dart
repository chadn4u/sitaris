// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/base/baseController.dart';
import 'package:sitaris/core/network/apiRepo.dart';
import 'package:sitaris/feature/controller/themeController.dart';
import 'package:sitaris/feature/model/login/login.dart';
import 'package:sitaris/route/routes.dart';
import 'package:sitaris/utils/utils.dart';

class LoginController extends BaseController {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late OutlineInputBorder outlineInputBorder;
  late ThemeData theme;
  late ThemeController themeController;
  RxBool enable = false.obs;
  ApiRepository _apiRepository = ApiRepository();

  final baseLoginData = <BaseResponseLogin>[].obs;
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
    // if (text == null || text.isEmpty) {
    //   return "Please enter email";
    // } else if (FxStringValidator.isEmail(text)) {
    //   return "Please enter valid email";
    // }
    return null;
  }

  void toggle() {
    enable.value = !enable.value;
    update();
  }

  String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter password";
    }
    //  else if (!FxStringValidator.validateStringRange(text, 6, 10)) {
    //   return "Password must be between 6 to 10";
    // }
    return null;
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      try {
        BaseResponseLogin result = await _apiRepository.postLogin(data: {
          "password": passwordController.value.text,
          "username": emailController.value.text
        });

        // print(data.status);
        if (result.status!) {
          LoginModel? data = result.data;
          addSession(data!);
          debugPrint("sukses");
          switch (data.roleId) {
            case "1": // ADMIN
              Utils.offAndToNamed(name: AppRoutes.HOMESCREEN);
              Get.delete<LoginController>();
              break;
            case "3": // Client
              Utils.offAndToNamed(name: AppRoutes.USERHOMESCREEN);
              Get.delete<LoginController>();
              break;
            default: //3 Staff
              Utils.offAndToNamed(name: AppRoutes.HOMESCREEN);
              Get.delete<LoginController>();
              break;
          }
        } else {
          Utils.showSnackBar(text: result.message!);
        }

        // listPosts.addAll(data.postList);
        // tempPosts.addAll(data.postList);
        //   if (data != null) {
        //     listPosts.addAll(data);
        //     isToLoadMore = true;
        //     change(donors, status: RxStatus.success());
        //   } else {
        //     isToLoadMore = false;
        //   }
        // }

      } catch (e) {
        Utils.showSnackBar(text: "$e");
      }
    } else {
      debugPrint('gagal auth');
    }
  }

  void goToForgotPasswordScreen() {
    Utils.offAndToNamed(name: AppRoutes.FORGOTSCREEN);
  }

  void goToRegisterScreen() {
    Utils.offAndToNamed(name: AppRoutes.REGISTERSCREEN);
  }

  void addSession(LoginModel data) {
    sessionController.setActiveFg(data.activeFg);
    sessionController.setDeptId(data.deptId);
    sessionController.setDeptName(data.deptName);
    sessionController.setEmail(data.email);
    sessionController.setId(data.id);
    sessionController.setName(data.name);
    sessionController.setPhone(data.phone);
    sessionController.setRoleId(data.roleId);
    sessionController.setRoleName(data.roleName);
    sessionController.setBankId(data.bankId);
    sessionController.setBankNm(data.bankNm);
  }
}
