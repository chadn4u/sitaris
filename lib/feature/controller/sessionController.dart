// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:sitaris/utils/sessionUtils.dart';

class SessionController extends GetxController {
  late Session session;

  SessionController() {
    session = Session();
    init();
  }

  RxString? accessToken;
  void setAccessToken(String? value) {
    if (value != null) {
      accessToken = value.obs;
      session.addToString(value, 'accessToken');
    }
  }

  RxString? id;
  void setId(String? value) {
    if (value != null) {
      id = value.obs;
      session.addToString(value, 'id');
    }
  }

  RxString? name;
  void setName(String? value) {
    if (value != null) {
      name = value.obs;
      session.addToString(value, 'name');
    }
  }

  RxString? email;
  void setEmail(String? value) {
    if (value != null) {
      email = value.obs;
      session.addToString(value, 'email');
    }
  }

  RxString? roleId;
  void setRoleId(String? value) {
    if (value != null) {
      roleId = value.obs;
      session.addToString(value, 'roleId');
    }
  }

  RxString? deptId;
  void setDeptId(String? value) {
    if (value != null) {
      deptId = value.obs;
      session.addToString(value, 'deptId');
    }
  }

  RxString? phone;
  void setPhone(String? value) {
    if (value != null) {
      phone = value.obs;
      session.addToString(value, 'phone');
    }
  }

  RxString? activeFg;
  void setActiveFg(String? value) {
    if (value != null) {
      activeFg = value.obs;
      session.addToString(value, 'activeFg');
    }
  }

  RxString? roleName;
  void setRoleName(String? value) {
    if (value != null) {
      roleName = value.obs;
      session.addToString(value, 'roleName');
    }
  }

  RxString? deptName;
  void setDeptName(String? value) {
    if (value != null) {
      deptName = value.obs;
      session.addToString(value, 'deptName');
    }
  }

  RxString? bankId;
  void setBankId(String? value) {
    if (value != null) {
      bankId = value.obs;
      session.addToString(value, 'bankId');
    }
  }

  RxString? bankNm;
  void setBankNm(String? value) {
    if (value != null) {
      bankNm = value.obs;
      session.addToString(value, 'bankNm');
    }
  }

  void init() async {
    await session.create();
    setAccessToken(session.getStringVal("accessToken"));
    setActiveFg(session.getStringVal("activeFg"));
    setDeptId(session.getStringVal("deptId"));
    setDeptName(session.getStringVal("deptName"));
    setEmail(session.getStringVal("email"));
    setId(session.getStringVal("id"));
    setName(session.getStringVal("name"));
    setPhone(session.getStringVal("phone"));
    setRoleId(session.getStringVal("roleId"));
    setRoleName(session.getStringVal("roleName"));
    setBankId(session.getStringVal("bankId"));
    setBankNm(session.getStringVal("bankNm"));
  }

  void clearSession() {
    session.clear();
    setAccessToken(null);
    setActiveFg(null);
    setDeptId(null);
    setDeptName(null);
    setEmail(null);
    setId(null);
    setName(null);
    setPhone(null);
    setRoleId(null);
    setRoleName(null);
    setBankId(null);
    setBankNm(null);
  }
}
