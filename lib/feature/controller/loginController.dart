import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/base/baseController.dart';
import 'package:sitaris/core/network/rest_client.dart';
import 'package:sitaris/feature/controller/themeController.dart';
import 'package:sitaris/feature/model/login.dart';
import 'package:sitaris/route/routes.dart';
import 'package:sitaris/utils/utils.dart';
import 'package:sitaris/utils/validators.dart';

class LoginController extends BaseController {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late OutlineInputBorder outlineInputBorder;
  late ThemeData theme;
  late ThemeController themeController;
  RxBool enable = false.obs;

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
      //Utils.offAndToNamed(name: AppRoutes.HOMESCREEN);
      // Utils.offAndToNamed(name: AppRoutes.USERHOMESCREEN);

      try {
        final result =
            await restClient.request(BASE_URL + "logins", Method.POST, {
          "password": passwordController.value.text,
          "usercellno": emailController.value.text
        });

        if (result != null) {
          var data = BaseResponseLogin.fromJson(result.data);
          // print(data.status);
          if (data.status!) {
            print("sukses");
            switch (data.data!.lvlLog) {
              case "staffadmin":
                Utils.offAndToNamed(name: AppRoutes.HOMESCREEN);
                break;
              case "partner":
                Utils.offAndToNamed(name: AppRoutes.USERHOMESCREEN);
                break;
              default:
                Utils.offAndToNamed(name: AppRoutes.HOMESCREEN);
                break;
            }
          } else {
            Get.showSnackbar(GetBar(
              message: data.message,
              duration: Duration(milliseconds: 3000),
            ));
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
        } else {
          print('gagal');
          // isToLoadMore = false;
        }
      } on Exception catch (e) {
        Get.showSnackbar(GetBar(
          message: "$e",
          duration: Duration(milliseconds: 3000),
        ));
      }
      // Navigator.of(Get.context!, rootNavigator: true).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => RentalServiceFullApp(),
      //   ),
      // );
    } else {
      print('gagal auth');
    }
  }

  void goToForgotPasswordScreen() {
    Utils.offAndToNamed(name: AppRoutes.FORGOTSCREEN);
  }

  void goToRegisterScreen() {
    Utils.offAndToNamed(name: AppRoutes.REGISTERSCREEN);
  }
}
