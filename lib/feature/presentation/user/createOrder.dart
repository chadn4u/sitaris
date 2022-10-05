// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:sitaris/feature/controller/user/createOrderController.dart';
import 'package:sitaris/feature/model/product/product.dart';
import 'package:sitaris/utils/container.dart';
import 'package:sitaris/utils/spacing.dart';
import 'package:sitaris/utils/text.dart';
import 'package:sitaris/utils/utils.dart';

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
    // customTheme = AppTheme.customTheme;
  }

  @override
  void dispose() {
    super.dispose();
    createOrderController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: createOrderController.onWillPop,
      child: Scaffold(
          backgroundColor: createOrderController.theme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: createOrderController.theme.colorScheme.primary,
            elevation: 0,
            title: FxText.bodyLarge(data!.prodNm!,
                color: Colors.white, fontWeight: 600),
            centerTitle: true,
          ),
          body: PageView(
            controller: createOrderController.pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
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
                            child: const FxText.bodyLarge("Informasi Kontak",
                                fontWeight: 700,
                                muted: true,
                                color: Colors.black),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: FxSpacing.fromLTRB(10, 0, 0, 0),
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: const FxText.bodySmall("Nama",
                                          fontWeight: 700,
                                          muted: true,
                                          color: Colors.black),
                                    ),
                                    Expanded(
                                      child: createOrderController.textBox(
                                          controller: createOrderController
                                              .namaController,
                                          hint: "Nama",
                                          icon: Icons.people),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: FxSpacing.fromLTRB(10, 0, 0, 0),
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: const FxText.bodySmall("Provinsi",
                                          fontWeight: 700,
                                          muted: true,
                                          color: Colors.black),
                                    ),
                                    Expanded(
                                      child: InputDecorator(
                                        // isEmpty: getXHome.choiceSelected.value == '',
                                        decoration: InputDecoration(
                                          hintText: 'Pilih Provinsi',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 14.0,
                                                  horizontal: 14.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              color: createOrderController
                                                  .theme.colorScheme.primary,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              color: createOrderController
                                                  .theme.colorScheme.primary,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                                value: createOrderController
                                                    .valueProv.value,
                                                isDense: true,
                                                onChanged: (value) {
                                                  createOrderController
                                                      .valueProv.value = value!;

                                                  createOrderController
                                                      .getCity(value);
                                                  createOrderController
                                                      .resetOther("Province");
                                                },
                                                items: createOrderController
                                                    .selectedProvince
                                                    .map((e) => DropdownMenuItem<
                                                            String>(
                                                        value: e!.provinceCode,
                                                        child: FxText.bodySmall(
                                                            e.provinceName!,
                                                            fontWeight: 700,
                                                            muted: true,
                                                            color:
                                                                Colors.black)))
                                                    .toList())),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: FxSpacing.fromLTRB(10, 0, 0, 0),
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: const FxText.bodySmall("Kota",
                                          fontWeight: 700,
                                          muted: true,
                                          color: Colors.black),
                                    ),
                                    Expanded(
                                      child: InputDecorator(
                                        // isEmpty: getXHome.choiceSelected.value == '',
                                        decoration: InputDecoration(
                                          hintText: 'Pilih Kota',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 14.0,
                                                  horizontal: 14.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              color: createOrderController
                                                  .theme.colorScheme.primary,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              color: createOrderController
                                                  .theme.colorScheme.primary,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                                value: createOrderController
                                                    .valueCity.value,
                                                isDense: true,
                                                onChanged: (value) {
                                                  createOrderController
                                                      .valueCity.value = value!;

                                                  createOrderController
                                                      .getKecamatan(value);
                                                  createOrderController
                                                      .resetOther("City");
                                                },
                                                items: createOrderController
                                                    .selectedCity
                                                    .map((e) => DropdownMenuItem<
                                                            String>(
                                                        value: e!.cityCode,
                                                        child: FxText.bodySmall(
                                                            e.city!,
                                                            fontSize: 10,
                                                            fontWeight: 700,
                                                            muted: true,
                                                            color:
                                                                Colors.black)))
                                                    .toList())),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: FxSpacing.fromLTRB(10, 0, 0, 0),
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: const FxText.bodySmall("Kecamatan",
                                          fontWeight: 700,
                                          muted: true,
                                          color: Colors.black),
                                    ),
                                    Expanded(
                                      child: InputDecorator(
                                        // isEmpty: getXHome.choiceSelected.value == '',
                                        decoration: InputDecoration(
                                          hintText: 'Pilih Kecamatan',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 14.0,
                                                  horizontal: 14.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              color: createOrderController
                                                  .theme.colorScheme.primary,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              color: createOrderController
                                                  .theme.colorScheme.primary,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                                value: createOrderController
                                                    .valueKec.value,
                                                isDense: true,
                                                onChanged: (value) {
                                                  createOrderController
                                                      .valueKec.value = value!;

                                                  createOrderController
                                                      .getKelurahan(value);
                                                },
                                                items: createOrderController
                                                    .selectedKec
                                                    .map((e) => DropdownMenuItem<
                                                            String>(
                                                        value: e!.kecamatanCode,
                                                        child: FxText.bodySmall(
                                                            e.kecamatan!,
                                                            fontSize: 10,
                                                            fontWeight: 700,
                                                            muted: true,
                                                            color:
                                                                Colors.black)))
                                                    .toList())),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: FxSpacing.fromLTRB(10, 0, 0, 0),
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: const FxText.bodySmall("Kelurahan",
                                          fontWeight: 700,
                                          muted: true,
                                          color: Colors.black),
                                    ),
                                    Expanded(
                                      child: InputDecorator(
                                        // isEmpty: getXHome.choiceSelected.value == '',
                                        decoration: InputDecoration(
                                          hintText: 'Pilih Kelurahan',
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 14.0,
                                                  horizontal: 14.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              color: createOrderController
                                                  .theme.colorScheme.primary,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              color: createOrderController
                                                  .theme.colorScheme.primary,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                                value: createOrderController
                                                    .valueKel.value,
                                                isDense: true,
                                                onChanged: (value) {
                                                  createOrderController
                                                      .valueKel.value = value!;
                                                },
                                                items: createOrderController
                                                    .selectedKel
                                                    .map((e) => DropdownMenuItem<
                                                            String>(
                                                        value: e!.kelurahanCode,
                                                        child: FxText.bodySmall(
                                                            e.kelurahan!,
                                                            fontWeight: 700,
                                                            muted: true,
                                                            color:
                                                                Colors.black)))
                                                    .toList())),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: FxSpacing.fromLTRB(10, 0, 0, 0),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: const FxText.bodySmall("Alamat",
                                            fontWeight: 700,
                                            muted: true,
                                            color: Colors.black),
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          controller: createOrderController
                                              .addressController,
                                          decoration: InputDecoration(
                                              hintText: "Input alamat anda",
                                              isDense: true,
                                              filled: true,
                                              fillColor: createOrderController
                                                  .theme.colorScheme.background,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14.0,
                                                      horizontal: 14.0),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: BorderSide(
                                                  color: createOrderController
                                                      .theme
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: BorderSide(
                                                  color: createOrderController
                                                      .theme
                                                      .colorScheme
                                                      .primary,
                                                  width: 1.0,
                                                ),
                                              )),
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          minLines: 5,
                                          maxLines: 10,
                                        ),
                                      ),
                                    ],
                                  )),
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
                            ...data!.files
                                .map((e) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin:
                                                FxSpacing.fromLTRB(10, 0, 0, 0),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: FxText.bodySmall(e!.label!,
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
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color: const Color(0xfff0f0f0),
                                            ),
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
                                          padding: MaterialStateProperty.all(
                                              FxSpacing.xy(16, 0))),
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Icon(
                                            FeatherIcons.logOut,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 16),
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
