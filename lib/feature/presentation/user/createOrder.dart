// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sitaris/feature/controller/user/createOrderController.dart';
import 'package:sitaris/feature/model/city/city.dart';
import 'package:sitaris/feature/model/kecamatan/kecamatan.dart';
import 'package:sitaris/feature/model/kelurahan/kelurahan.dart';
import 'package:sitaris/feature/model/konsumen/konsumen.dart';
import 'package:sitaris/feature/model/product/product.dart';
import 'package:sitaris/feature/model/province/province.dart';
import 'package:sitaris/utils/button.dart';
import 'package:sitaris/utils/container.dart';
import 'package:sitaris/utils/fxCard.dart';
import 'package:sitaris/utils/spacing.dart';
import 'package:sitaris/utils/text.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({Key? key}) : super(key: key);

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  // late HomeController controller;
  late CreateOrderController createOrderController;

  List<ProductModel?> data = [];

  @override
  void initState() {
    super.initState();
    // controller = Get.find<HomeController>();
    createOrderController = Get.put(CreateOrderController());
    data = Get.arguments["data"];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      data.forEach((element) {
        createOrderController.fileTypeBase.addAll(element!.files);
      });

      createOrderController.fileTypeBase.forEach((element) {
        int val;
        if (createOrderController.fileType.length < 1) {
          createOrderController.fileType.add(element);
        } else {
          val = createOrderController.fileType
              .where((p0) => p0!.label == element!.label)
              .length;
          if (val < 1) {
            createOrderController.fileType.add(element);
          }
        }
      });

      createOrderController.dataProduct.value = data;
    });

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
      child: Obx(
        () => Scaffold(
            backgroundColor:
                createOrderController.theme.scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Color(0xFFD3AB2B),
              elevation: 0,
              title: FxText.bodyLarge(
                  (data.length > 1) ? "Create Order" : data[0]!.prodNm!,
                  color: Colors.white,
                  fontWeight: 600),
              centerTitle: true,
              leading: (createOrderController.activePage.value == 2)
                  ? Container()
                  : null,
            ),
            body: PageView(
              controller: createOrderController.pageController,
              onPageChanged: (i) {
                createOrderController.activePage.value = i;
              },
              physics: NeverScrollableScrollPhysics(),
              children: [
                SingleChildScrollView(
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
                              (createOrderController.sessionController.roleId ==
                                      "1")
                                  ? createOrderController.contactInfoWidget(
                                      label: "Kategori Konsumen",
                                      type: "DropDown",
                                      dropDownType: "Konsumen",
                                      valueDropDown: createOrderController
                                          .valueKonsumen.value,
                                      item: createOrderController
                                          .selectedKonsumen,
                                      onChangeDropDown: (value) {
                                        value as KonsumenModel;
                                        createOrderController.valueKonsumen
                                            .value = value.bankId!;
                                      })
                                  : Container(),
                              createOrderController.contactInfoWidget(
                                  label: "Nama", type: "TextBox"),
                              createOrderController.contactInfoWidget(
                                  label: "Provinsi",
                                  type: "DropDown",
                                  dropDownType: "Province",
                                  valueDropDown:
                                      createOrderController.valueProv.value,
                                  item: createOrderController.selectedProvince,
                                  onChangeDropDown: (value) {
                                    value as ProvinceModel;
                                    createOrderController.valueProv.value =
                                        value.provinceCode!;

                                    createOrderController
                                        .getCity(value.provinceCode!);
                                    createOrderController
                                        .resetOther("Province");
                                  }),
                              createOrderController.contactInfoWidget(
                                  label: "Kota",
                                  type: "DropDown",
                                  dropDownType: "City",
                                  valueDropDown:
                                      createOrderController.valueCity.value,
                                  item: createOrderController.selectedCity,
                                  onChangeDropDown: (value) {
                                    value as CityModel;
                                    createOrderController.valueCity.value =
                                        value.cityCode!;

                                    createOrderController
                                        .getKecamatan(value.cityCode!);
                                    createOrderController.resetOther("City");
                                  }),
                              createOrderController.contactInfoWidget(
                                  label: "Kecamatan",
                                  type: "DropDown",
                                  dropDownType: "Kecamatan",
                                  valueDropDown:
                                      createOrderController.valueKec.value,
                                  item: createOrderController.selectedKec,
                                  onChangeDropDown: (value) {
                                    value as KecamatanModel;
                                    createOrderController.valueKec.value =
                                        value.kecamatanCode!;

                                    createOrderController
                                        .getKelurahan(value.kecamatanCode!);
                                  }),
                              createOrderController.contactInfoWidget(
                                  label: "Kelurahan",
                                  type: "DropDown",
                                  dropDownType: "Kelurahan",
                                  valueDropDown:
                                      createOrderController.valueKel.value,
                                  item: createOrderController.selectedKel,
                                  onChangeDropDown: (value) {
                                    value as KelurahanModel;
                                    createOrderController.valueKel.value =
                                        value.kelurahanCode!;
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
                                            padding: MaterialStateProperty.all(
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
                ),
                ListView(
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
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: Lottie.asset(
                              'assets/lottie/order-success.json',
                              height: 200)),
                      Container(
                        margin: FxSpacing.top(8),
                        width: MediaQuery.of(Get.context!).size.width * 0.6,
                        child: FxText.bodyMedium('Order Berhasil dibuat',
                            textAlign: TextAlign.center,
                            color:
                                createOrderController.theme.colorScheme.primary,
                            fontWeight: 400,
                            muted: true),
                      ),
                      FxSpacing.height(10),
                      FxButton.medium(
                        onPressed: () {
                          Get.back();
                        },
                        backgroundColor: Colors.green,
                        child: FxText.bodyMedium("Kembali",
                            color: Colors.white, fontWeight: 400, muted: true),
                        buttonType: FxButtonType.elevated,
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
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
