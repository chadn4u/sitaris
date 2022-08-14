// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:sitaris/feature/controller/accountController.dart';
import 'package:sitaris/utils/scrollBehavior.dart';
import 'package:sitaris/utils/spacing.dart';
import 'package:sitaris/utils/text.dart';
import 'package:sitaris/utils/textType.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);
  late AccountController accountController;
  @override
  Widget build(BuildContext context) {
    accountController = Get.put(AccountController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: accountController.theme.scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: const FxText.titleMedium("Account Setting", fontWeight: 600),
        ),
        body: Obx(
          () => ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView(
              padding: FxSpacing.nTop(20),
              children: <Widget>[
                const FxText.bodyLarge("Personal information",
                    fontWeight: 600, letterSpacing: 0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: TextFormField(
                        style: FxTextStyle.titleSmall(
                            letterSpacing: 0,
                            color: accountController
                                .theme.colorScheme.onBackground,
                            fontWeight: 500),
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: FxTextStyle.titleSmall(
                              letterSpacing: 0,
                              color: accountController
                                  .theme.colorScheme.onBackground,
                              fontWeight: 500),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: const Color(0xfff0f0f0),
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            size: 22,
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      child: TextFormField(
                        style: FxTextStyle.titleSmall(
                            letterSpacing: 0,
                            color: accountController
                                .theme.colorScheme.onBackground,
                            fontWeight: 500),
                        decoration: InputDecoration(
                          hintText: "Number",
                          hintStyle: FxTextStyle.titleSmall(
                              letterSpacing: 0,
                              color: accountController
                                  .theme.colorScheme.onBackground,
                              fontWeight: 500),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: const Color(0xfff0f0f0),
                          prefixIcon: const Icon(
                            Icons.phone_outlined,
                            size: 22,
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 24, bottom: 0),
                  child: const FxText.bodyLarge("Company information",
                      fontWeight: 600, letterSpacing: 0),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: TextFormField(
                        style: FxTextStyle.titleSmall(
                            letterSpacing: 0,
                            color: accountController
                                .theme.colorScheme.onBackground,
                            fontWeight: 500),
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: FxTextStyle.titleSmall(
                              letterSpacing: 0,
                              color: accountController
                                  .theme.colorScheme.onBackground,
                              fontWeight: 500),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: const Color(0xfff0f0f0),
                          prefixIcon: const Icon(
                            Icons.domain_outlined,
                            size: 22,
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      child: TextFormField(
                        style: FxTextStyle.titleSmall(
                            letterSpacing: 0,
                            color: accountController
                                .theme.colorScheme.onBackground,
                            fontWeight: 500),
                        decoration: InputDecoration(
                          hintText: "Job Title",
                          hintStyle: FxTextStyle.titleSmall(
                              letterSpacing: 0,
                              color: accountController
                                  .theme.colorScheme.onBackground,
                              fontWeight: 500),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: const Color(0xfff0f0f0),
                          prefixIcon: const Icon(
                            Icons.cases_outlined,
                            size: 22,
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      child: TextFormField(
                        style: FxTextStyle.titleSmall(
                            letterSpacing: 0,
                            color: accountController
                                .theme.colorScheme.onBackground,
                            fontWeight: 500),
                        decoration: InputDecoration(
                          hintText: "Website",
                          hintStyle: FxTextStyle.titleSmall(
                              letterSpacing: 0,
                              color: accountController
                                  .theme.colorScheme.onBackground,
                              fontWeight: 500),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: const Color(0xfff0f0f0),
                          prefixIcon: const Icon(
                            Icons.web_outlined,
                            size: 22,
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: const FxText.bodyLarge("Change Password",
                      fontWeight: 600, letterSpacing: 0),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: TextFormField(
                    style: FxTextStyle.titleSmall(
                        letterSpacing: 0,
                        color: accountController.theme.colorScheme.onBackground,
                        fontWeight: 500),
                    decoration: InputDecoration(
                      hintText: "Old Password",
                      hintStyle: FxTextStyle.titleSmall(
                          letterSpacing: 0,
                          color:
                              accountController.theme.colorScheme.onBackground,
                          fontWeight: 500),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: const Color(0xfff0f0f0),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(accountController.passwordVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined),
                        onPressed: () {
                          accountController.passwordVisible.value =
                              !accountController.passwordVisible.value;
                        },
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.all(0),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    obscureText: accountController.passwordVisible.value,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: TextFormField(
                    style: FxTextStyle.titleSmall(
                        letterSpacing: 0,
                        color: accountController.theme.colorScheme.onBackground,
                        fontWeight: 500),
                    decoration: InputDecoration(
                      hintText: " Password",
                      hintStyle: FxTextStyle.titleSmall(
                          letterSpacing: 0,
                          color:
                              accountController.theme.colorScheme.onBackground,
                          fontWeight: 500),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: const Color(0xfff0f0f0),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(accountController.passwordVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined),
                        onPressed: () {
                          accountController.passwordVisible.value =
                              !accountController.passwordVisible.value;
                        },
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.all(0),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    obscureText: accountController.passwordVisible.value,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            boxShadow: [
                              BoxShadow(
                                color: accountController
                                    .theme.colorScheme.primary
                                    .withAlpha(28),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    FxSpacing.xy(16, 0))),
                            child: FxText.bodyMedium("SAVE",
                                fontWeight: 600,
                                color: accountController
                                    .theme.colorScheme.onPrimary),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            boxShadow: [
                              BoxShadow(
                                color: accountController
                                    .theme.colorScheme.primary
                                    .withAlpha(28),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              accountController.logout();
                            },
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    FxSpacing.xy(16, 0))),
                            child: FxText.bodyMedium("Logout",
                                fontWeight: 600,
                                color: accountController
                                    .theme.colorScheme.onPrimary),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
