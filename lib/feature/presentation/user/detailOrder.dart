import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/feature/controller/user/detailOrderController.dart';
import 'package:sitaris/feature/model/order/order.dart';
import 'package:sitaris/utils/text.dart';

class DetailOrderScreen extends StatefulWidget {
  @override
  _DetailOrderScreenState createState() => _DetailOrderScreenState();
}

class _DetailOrderScreenState extends State<DetailOrderScreen> {
  late DetailOrderController _detailOrderController;
  // late ProductModel _productModel;
  late String _orderDt;
  late String _orderNo;
  late OrderMasterModel _orderMaster;
  @override
  void initState() {
    super.initState();
    // _productModel = Get.arguments['product'];
    _orderDt = Get.arguments['orderDt'];
    _orderNo = Get.arguments['orderNo'];
    _orderMaster = Get.arguments['orderMaster'];
    _detailOrderController = Get.put(DetailOrderController());
    _detailOrderController.orderMasterModel = _orderMaster;

    debugPrint(_orderNo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD3AB2B),
        elevation: 0,
        title: FxText.bodyLarge('Order No: $_orderNo',
            color: Colors.white, fontWeight: 600),
        centerTitle: true,
      ),
      body: Obx(() => _detailOrderController.getWidgetProduct(
            date: _orderDt,
          )),
    );
  }
}
