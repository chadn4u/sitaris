import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sitaris/core/network/apiRepo.dart';
import 'package:sitaris/feature/controller/homeController.dart';
import 'package:sitaris/feature/model/baseResponse/baseResponse.dart';
import 'package:sitaris/utils/spacing.dart';
import 'package:sitaris/utils/text.dart';
import 'package:sitaris/utils/utils.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen>
    with SingleTickerProviderStateMixin {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late HomeController homeController;
  var json;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void initState() {
    super.initState();
    homeController = Get.find<HomeController>();
    // homeController.tabController.animateTo(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      // if (scanData) {
      if (describeEnum(scanData.format) == 'qrcode') {
        if (scanData.code != null) {
          if (_checkValidData(scanData.code!)) {
            controller.pauseCamera();
            _postTask(json!);
          }
        }
      }
      // notifyListeners();
      // }
    });
  }

  void _postTask(Map<String, dynamic> data) async {
    ApiRepository _apiRepository = ApiRepository();
    try {
      BaseResponse result = await _apiRepository.postTaskSubmit(data: data);

      // print(data.status);
      if (result.status!) {
        Get.dialog(
            Center(
              child: Container(
                width: Utils.dynamicWidth(70),
                height: Utils.dynamicHeight(15),
                padding: const EdgeInsets.all(8.0),
                color: Colors.white,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 45,
                      ),
                      FxSpacing.height(10),
                      FxText.bodyMedium('Task berhasil di update')
                    ]),
              ),
            ),
            barrierDismissible: false,
            barrierColor: Colors.grey.withOpacity(0.3));
        Future.delayed(Duration(seconds: 2), (() {
          Utils.navigateBack();
          homeController.tabController.animateTo(0);
          homeController.getTask();
        }));
      } else {
        Utils.showSnackBar(text: result.message!);
      }
    } catch (e) {
      Utils.showSnackBar(text: "$e");
    }
  }

  bool _checkValidData(String value) {
    // $_cardN0|$_name|$_cellNo|$_mbrsNo
    String data = utf8.decode(base64.decode(value));
    json = jsonDecode(data);
    try {
      if (json!["order_id"] != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
