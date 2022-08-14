// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sitaris/utils/sessionUtils.dart';

class SessionController extends GetxController {
  late Session session;

  SessionController() {
    session = Session();
    init();
  }

  RxString? compCode;
  void setCompCode(String? value) {
    if (value != null) {
      compCode = value.obs;
      session.addToString(value, 'compCode');
    }
    debugPrint("session ${session.getStringVal('compCode')}");
  }

  RxString? compName;
  void setCompName(String? value) {
    if (value != null) {
      compName = value.obs;

      session.addToString(value, 'compName');
    }
  }

  RxString? compCellNo;
  void setCompCellNo(String? value) {
    if (value != null) {
      compCellNo = value.obs;

      session.addToString(value, 'compCellNo');
    }
  }

  RxString? compEmail;
  void setCompEmail(String? value) {
    if (value != null) {
      compEmail = value.obs;

      session.addToString(value, 'compEmail');
    }
  }

  RxString? key;
  void setKey(String? value) {
    if (value != null) {
      key = value.obs;

      session.addToString(value, 'key');
    }
  }

  RxString? userCode;
  void setUserCode(String? value) {
    if (value != null) {
      key = value.obs;

      session.addToString(value, 'userCode');
    }
  }

  RxString? userName;
  void setUserName(String? value) {
    if (value != null) {
      userName = value.obs;

      session.addToString(value, 'userName');
    }
  }

  RxString? userCellNo;
  void setUserCellNo(String? value) {
    if (value != null) {
      userCellNo = value.obs;

      session.addToString(value, 'userCellNo');
    }
  }

  RxString? userEmail;
  void setUserEmail(String? value) {
    if (value != null) {
      userEmail = value.obs;

      session.addToString(value, 'userEmail');
    }
  }

  RxString? userLvl;
  void setUserLvl(String? value) {
    if (value != null) {
      userLvl = value.obs;

      session.addToString(value, 'userLvl');
    }
  }

  RxString? lvlLog;
  void setLvlLog(String? value) {
    if (value != null) {
      lvlLog = value.obs;

      session.addToString(value, 'lvlLog');
    }
  }

  void init() async {
    await session.create();
    setCompCellNo(session.getStringVal('compCellNo'));

    setCompCode(session.getStringVal('compCode'));
    setCompEmail(session.getStringVal('index'));
    setCompName(session.getStringVal('compName'));
    setKey(session.getStringVal('key'));
    setLvlLog(session.getStringVal('lvlLog'));
    setUserCellNo(session.getStringVal('userCellNo'));
    setUserCode(session.getStringVal('userCode'));
    setUserEmail(session.getStringVal('userEmail'));
    setUserLvl(session.getStringVal('userLvl'));
    setUserName(session.getStringVal('userName'));
  }

  void clearSession() {
    session.clear();
  }
}
