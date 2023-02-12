import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:sitaris/base/baseController.dart';
import 'package:sitaris/utils/firebaseMessage.dart';

class FirebaseController extends BaseController {
  late FirebaseMessage _firebaseMessage;
  RemoteMessage? remoteMessage;

  bool isNotif = false;

  // PromoDtl _merchantPromo = null;
  // PromoDtl get merchantPromo => _merchantPromo;
  // set merchantPromoSet(PromoDtl value) {
  //   _merchantPromo = value;
  // }

  FirebaseController() {
    _firebaseMessage = new FirebaseMessage(Get.context!);
    remoteMessage = _firebaseMessage.remoteMessage;
  }

  void subscribeTo(String topicName) {
    _firebaseMessage.subscribeTopic(topicName: topicName);
  }

  void updateToken(String email) {
    _firebaseMessage.updateToken(email);
  }

  void updateTokenToNull(String email) {
    _firebaseMessage.updateTokenToNull(email);
  }

  void unsubscribeTopic(String topic) {
    _firebaseMessage.unsubscribeTopic(topicName: topic);
  }
}
