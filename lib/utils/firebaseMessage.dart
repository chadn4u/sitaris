// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/feature/controller/sessionController.dart';
import 'package:sitaris/utils/notificationPlugin.dart';

import '../core/network/apiRepo.dart';

class FirebaseMessage {
  final BuildContext context;
  late NotificationPlugin notifPlugin;
  RemoteMessage? _remoteMessage;
  RemoteMessage? get remoteMessage => _remoteMessage;
  late SessionController sessionController;
  FirebaseMessage(this.context) {
    sessionController = Get.find();
    notifPlugin = new NotificationPlugin(context);
    _getToken();
    _initMessage();
    _listenMessage();
    subscribeTopic();
  }

  void _getToken() {
    FirebaseMessaging.instance.requestPermission(
        alert: true, badge: true, provisional: false, sound: true);
    FirebaseMessaging.instance.getToken().then((value) => print(value));
  }

  void updateToken(String email) async {
    FirebaseMessaging.instance.getToken().then((value) {
      Map<String, dynamic> _dataForRequest = new Map();
      _dataForRequest['email'] = email;
      _dataForRequest['token'] = value;
      ApiRepository _apiRepository = new ApiRepository();
      // _apiRepository
      //     .postFcmTokenSaveRepo(_dataForRequest)
      //     .catchError((onError) {
      //   if (onError is DioError) {
      //     Utils.handleErrorDio(
      //       context: Get.context,
      //       dioError: onError,
      //     );
      //   } else {
      //     Utils.handleError(context: Get.context, error: onError);
      //   }
      // });
    });
  }

  void updateTokenToNull(String email) async {
    Map<String, dynamic> _dataForRequest = new Map();
    _dataForRequest['email'] = email;
    _dataForRequest['token'] = null;
    ApiRepository _apiRepository = new ApiRepository();
    // _apiRepository.postFcmTokenSaveRepo(_dataForRequest);
  }

  void _listenMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      // AndroidNotification android = message.notification?.android;
      print("message received");
      if (notification != null && !kIsWeb) {
        // Provider.of<FirebaseMessageProvider>(Get.context, listen: false)
        //     .isNotifset = true;
        _sendLocalNotif(
            message: message,
            notifPlugin: notifPlugin,
            notification: notification);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('test');
      if (message.data != null) {
        // Provider.of<FirebaseMessageProvider>(Get.context, listen: false)
        //     .isNotifset = true;
        processTheData(message);
      }
    });
  }

  void processTheData(RemoteMessage message) {
    if (sessionController.name?.value != null) {
      Map<String, dynamic> dataRemote = new Map();
      dataRemote = message.data;
    } else {}
    // Session.getStringVal('custNm').then((value) async {
    //   if (value != null) {
    //     // Map<String, dynamic> dataRemote = new Map();
    //     // dataRemote = message.data;

    //     // PromoDtl _payloadFcm = PromoDtl.from(dataRemote);
    //     // Map<String, dynamic> _dataForRequest = new Map();
    //     // _dataForRequest['id'] = _payloadFcm.idPr;
    //     // _dataForRequest['topic'] = dataRemote['type'];
    //     // _dataForRequest['mbrs'] = await Session.getStringVal('mbrsNo');
    //     // _dataForRequest['card'] = await Session.getStringVal('custCardNo');
    //     // _dataForRequest['device'] = Platform.isAndroid ? 'android' : 'ios';
    //     // ApiRepository _apiRepository = new ApiRepository();
    //     // _apiRepository.postCountingNotifRepo(_dataForRequest);
    //     // Utils.navigateBack(until: AppRoutes.HOME_SCREEN);
    //     // // Navigator.of(Get.context).popUntil((route) => route.isFirst);
    //     // final _prov =
    //     //     Provider.of<LoggedMainScreenProvider>(Get.context, listen: false);
    //     // _prov.showDialogFromFirebase(message.data);
    //   } else {
    //     Utils.showSnackbar(text: 'Silahkan Login');
    //   }
    // });
  }

  void _initMessage() {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void subscribeTopic({String? topicName}) {
    if (topicName == null) {
      // FirebaseMessaging.instance.subscribeToTopic('newPromo');
      // FirebaseMessaging.instance.subscribeToTopic('web');
      // FirebaseMessaging.instance.subscribeToTopic('partner');
      // FirebaseMessaging.instance.subscribeToTopic('coupon');
      FirebaseMessaging.instance.subscribeToTopic('message');
    } else
      FirebaseMessaging.instance.subscribeToTopic(topicName);
  }

  void unsubscribeTopic({required String topicName}) {
    FirebaseMessaging.instance.unsubscribeFromTopic(topicName);
  }

  void _sendLocalNotif(
      {NotificationPlugin? notifPlugin,
      RemoteMessage? message,
      RemoteNotification? notification}) {
    ReceivedNotification _receivedNotification = ReceivedNotification(
        id: notification.hashCode,
        title: notification!.title,
        body: notification.body,
        // imageUrl: message.data['pr_img300'],
        payload: jsonEncode(message!.data));
    if (message.data['pr_img300'] == null || message.data['pr_img300'] == "") {
      notifPlugin!.showNotification(); //_receivedNotification
    } else {
      notifPlugin!.showNotification();
      // notifPlugin!
      //     .showBigPictureNotificationHiddenLargeIcon(_receivedNotification);
    }
  }
}
