import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:sitaris/utils/spacing.dart';
import 'package:sitaris/utils/text.dart';
import 'package:sitaris/utils/utils.dart';

class QRPage extends StatefulWidget {
  @override
  _QRPageState createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  late String qrData;
  late String nextDept;
  @override
  void initState() {
    super.initState();
    qrData = Get.arguments['qrData'];
    nextDept = Get.arguments['nextDept'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD3AB2B),
        elevation: 0,
        title: FxText.bodyLarge('QR $nextDept',
            color: Colors.white, fontWeight: 600),
        centerTitle: true,
      ),
      body: Container(
        height: Utils.dynamicHeight(100),
        width: Utils.dynamicWidth(100),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                color: Colors.white,
                child: PrettyQr(
                  image: AssetImage('assets/icon/iconApps.png'),
                  // typeNumber: 3,
                  size: Utils.dynamicHeight(25),
                  data: qrData,
                  errorCorrectLevel: QrErrorCorrectLevel.M,
                  roundEdges: true,
                ),
              ),
              FxSpacing.height(10),
              FxText.labelMedium("Tunjukkan QR Code ini ke $nextDept",
                  color: Colors.black, fontWeight: 600),
            ]),
      ),
    );
  }
}
