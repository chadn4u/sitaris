// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:sitaris/feature/controller/user/createOrderController.dart';
import 'package:sitaris/feature/model/product/product.dart';
import 'package:sitaris/utils/container.dart';
import 'package:sitaris/utils/fxCard.dart';
import 'package:sitaris/utils/spacing.dart';
import 'package:sitaris/utils/text.dart';

import '../../controller/user/homeController.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({Key? key}) : super(key: key);

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  late HomeController controller;
  late CreateOrderController createOrderController;

  late ProductModel? data;

  @override
  void initState() {
    super.initState();
    controller = Get.find<HomeController>();
    createOrderController = Get.put(CreateOrderController());
    data = Get.arguments["data"];
    createOrderController.fileType.addAll(data!.files);
    createOrderController.dataProduct = data!;
    // customTheme = AppTheme.customTheme;
  }

  @override
  void dispose() {
    super.dispose();
    createOrderController.dispose();
    Get.delete<CreateOrderController>();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: createOrderController.onWillPop,
      child: Scaffold(
          backgroundColor: createOrderController.theme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Color(0xFFD3AB2B),
            elevation: 0,
            title: FxText.bodyLarge(data!.prodNm!,
                color: Colors.white, fontWeight: 600),
            centerTitle: true,
          ),
          body: PageView(
            controller: createOrderController.pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Obx(() => SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: FxSpacing.fromLTRB(10, 0, 0, 5),
                            child: const FxText.bodyLarge("Informasi Kontak",
                                fontWeight: 700,
                                muted: true,
                                color: Colors.black),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                createOrderController.contactInfoWidget(
                                    label: "Nama", type: "TextBox"),
                                createOrderController.contactInfoWidget(
                                    label: "Provinsi",
                                    type: "DropDown",
                                    valueDropDown:
                                        createOrderController.valueProv.value,
                                    item: createOrderController.selectedProvince
                                        .map((e) => DropdownMenuItem<String>(
                                            value: e!.provinceCode,
                                            child: FxText.bodySmall(
                                                e.provinceName!,
                                                fontWeight: 700,
                                                muted: true,
                                                color: Colors.black)))
                                        .toList(),
                                    onChangeDropDown: (value) {
                                      createOrderController.valueProv.value =
                                          value!;

                                      createOrderController.getCity(value);
                                      createOrderController
                                          .resetOther("Province");
                                    }),
                                createOrderController.contactInfoWidget(
                                    label: "Kota",
                                    type: "DropDown",
                                    valueDropDown:
                                        createOrderController.valueCity.value,
                                    item: createOrderController.selectedCity
                                        .map((e) => DropdownMenuItem<String>(
                                            value: e!.cityCode,
                                            child: FxText.bodySmall(e.city!,
                                                fontWeight: 700,
                                                muted: true,
                                                color: Colors.black)))
                                        .toList(),
                                    onChangeDropDown: (value) {
                                      createOrderController.valueCity.value =
                                          value!;

                                      createOrderController.getKecamatan(value);
                                      createOrderController.resetOther("City");
                                    }),
                                createOrderController.contactInfoWidget(
                                    label: "Kecamatan",
                                    type: "DropDown",
                                    valueDropDown:
                                        createOrderController.valueKec.value,
                                    item: createOrderController.selectedKec
                                        .map((e) => DropdownMenuItem<String>(
                                            value: e!.kecamatanCode,
                                            child: FxText.bodySmall(
                                                e.kecamatan!,
                                                fontWeight: 700,
                                                muted: true,
                                                color: Colors.black)))
                                        .toList(),
                                    onChangeDropDown: (value) {
                                      createOrderController.valueKec.value =
                                          value!;

                                      createOrderController.getKelurahan(value);
                                    }),
                                createOrderController.contactInfoWidget(
                                    label: "Kelurahan",
                                    type: "DropDown",
                                    valueDropDown:
                                        createOrderController.valueKel.value,
                                    item: createOrderController.selectedKel
                                        .map((e) => DropdownMenuItem<String>(
                                            value: e!.kelurahanCode,
                                            child: FxText.bodySmall(
                                                e.kelurahan!,
                                                fontWeight: 700,
                                                muted: true,
                                                color: Colors.black)))
                                        .toList(),
                                    onChangeDropDown: (value) {
                                      createOrderController.valueKel.value =
                                          value!;
                                    }),
                                createOrderController.contactInfoWidget(
                                    type: "TextArea", label: "Alamat"),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 24),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              padding:
                                                  MaterialStateProperty.all(
                                                      FxSpacing.xy(16, 0))),
                                          onPressed: () {
                                            createOrderController.validate();
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              const Icon(
                                                FeatherIcons.logOut,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 16),
                                                child: const FxText.bodySmall(
                                                    "Next",
                                                    letterSpacing: 0.3,
                                                    fontWeight: 600,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )

                          // singleTask(
                          //     subject: "Mathematics",
                          //     task: "Example 2",
                          //     statusText: "Not submit",
                          //     status: 1,
                          //     submissionDate: "22/07/20"),
                        ],
                      ),
                    ),
                  )),
              Obx(
                () => ListView(
                  padding: FxSpacing.zero,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: FxSpacing.fromLTRB(10, 0, 0, 12),
                            child: const FxText.bodyLarge("Upload Berkas",
                                fontWeight: 700,
                                muted: true,
                                color: Colors.black),
                          ),
                          Column(
                            children: [
                              ...createOrderController.fileType
                                  .map((es) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: FxSpacing.fromLTRB(
                                                  10, 0, 0, 0),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              child: FxText.bodySmall(
                                                  es!.label!,
                                                  fontWeight: 700,
                                                  muted: true,
                                                  color: Colors.black),
                                            ),
                                            Expanded(
                                              child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.25,
                                                  color:
                                                      const Color(0xfff0f0f0),
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: GridView.count(
                                                    shrinkWrap: true,
                                                    crossAxisCount: 3,
                                                    childAspectRatio: 80 / 90,
                                                    mainAxisSpacing: 2.0,
                                                    crossAxisSpacing: 10.0,
                                                    children: [
                                                      ...es.data!
                                                          .map(
                                                            (element) =>
                                                                Container(
                                                              child: Stack(
                                                                children: [
                                                                  Image.memory(
                                                                    base64Decode(
                                                                        element[
                                                                            "value"]),
                                                                    height: 120,
                                                                    width: 120,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topRight,
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        createOrderController
                                                                            .fileType
                                                                            .firstWhere((elements) =>
                                                                                elements!.label ==
                                                                                es.label)!
                                                                            .data!
                                                                            .removeWhere((elemento) => elemento["id"] == element["id"]);
                                                                      },
                                                                      child: Icon(
                                                                          Icons
                                                                              .close),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                      (es.limit! >
                                                              es.data!.length)
                                                          ? InkWell(
                                                              onTap: (() => createOrderController
                                                                  .openBottomSheet(
                                                                      label: es
                                                                          .label!)),
                                                              child: FxCard
                                                                  .bordered(
                                                                height: 60,
                                                                width: 60,
                                                                child: Icon(
                                                                    Icons.add),
                                                              ),
                                                            )
                                                          : Container(),
                                                    ],
                                                  )),
                                            )
                                          ],
                                        ),
                                      ))
                                  .toList(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 24),
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              padding:
                                                  MaterialStateProperty.all(
                                                      FxSpacing.xy(16, 0))),
                                          onPressed: () {
                                            // createOrderController.process
                                            //     .value = ProcessEnum.finish;
                                            if (createOrderController
                                                    .process.value ==
                                                ProcessEnum.finish) {
                                              createOrderController
                                                  .submitOrder();
                                            }
                                          },
                                          child: (createOrderController
                                                      .process.value ==
                                                  ProcessEnum.loading)
                                              ? Transform.scale(
                                                  scale: 0.5,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    const Icon(
                                                      FeatherIcons.logOut,
                                                      color: Colors.white,
                                                      size: 18,
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 16),
                                                      child: const FxText
                                                              .bodySmall("Next",
                                                          letterSpacing: 0.3,
                                                          fontWeight: 600,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                )),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )

                          // singleTask(
                          //     subject: "Mathematics",
                          //     task: "Example 2",
                          //     statusText: "Not submit",
                          //     status: 1,
                          //     submissionDate: "22/07/20"),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget singleTask(
      {String? subject,
      String? task,
      String? submissionDate,
      String? statusText,
      int status = 0}) {
    IconData iconData;
    Color iconBG, iconColor, statusColor;
    switch (status) {
      case 0:
        iconBG = Colors.red;
        iconColor = Colors.white;
        iconData = FeatherIcons.plus;
        statusColor = Colors.red;
        break;
      case 1:
        iconBG = createOrderController.theme.colorScheme.primary;
        iconColor = createOrderController.theme.colorScheme.onPrimary;
        iconData = FeatherIcons.check;
        statusColor = createOrderController.theme.colorScheme.primary;
        break;

      default:
        iconBG = Colors.red;
        iconColor = Colors.white;
        iconData = FeatherIcons.plus;
        statusColor = Colors.red;
        break;
    }

    return FxContainer.bordered(
      paddingAll: 16,
      margin: FxSpacing.fromLTRB(24, 8, 24, 8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      borderRadiusAll: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: FxSpacing.all(6),
            decoration: BoxDecoration(color: iconBG, shape: BoxShape.circle),
            child: Icon(
              iconData,
              color: iconColor,
              size: 20,
            ),
          ),
          Expanded(
            child: Container(
              margin: FxSpacing.left(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FxText.bodyLarge(subject!,
                      color:
                          createOrderController.theme.colorScheme.onBackground,
                      fontWeight: 600),
                  Container(
                    margin: FxSpacing.top(2),
                    child: FxText.bodySmall(
                      task!,
                      color: createOrderController
                          .theme.colorScheme.onBackground
                          .withAlpha(160),
                      fontWeight: 600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              FxText.bodySmall(submissionDate!,
                  fontSize: 12,
                  letterSpacing: 0.2,
                  color: createOrderController.theme.colorScheme.onBackground,
                  muted: true,
                  fontWeight: 600),
              Container(
                margin: FxSpacing.top(2),
                child: FxText.bodyMedium(statusText!,
                    color: statusColor,
                    letterSpacing: 0,
                    fontWeight: status == 3 ? 600 : 500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
