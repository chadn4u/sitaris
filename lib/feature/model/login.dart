class LoginModel {
  late String? compCode;
  late String? compName;
  late String? compCellNo;
  late String? emailComp;

  late String? key;
  late String? contract;
  late String? userCode;
  late String? userName;
  late String? userCellNo;
  late String? emailUsr;
  late String? lvlUsr;
  late String? lvlLog;

  LoginModel(
      {this.compCode,
      this.compName,
      this.compCellNo,
      this.emailComp,
      this.key,
      this.contract,
      this.userCode,
      this.userName,
      this.userCellNo,
      this.emailUsr,
      this.lvlUsr,
      this.lvlLog});

  LoginModel.fromJson(Map<String, dynamic> json) {
    compCode = json['compCode'];
    compName = json['compName'];
    compCellNo = json['compCellNo'];
    emailComp = json['email_comp'];

    key = json['key'];
    contract = json['contract'];
    userCode = json['userCode'];
    userName = json['userName'];

    userCellNo = json['userCellNo'];
    emailUsr = json['email_usr'];
    lvlUsr = json['lvl_usr'];
    lvlLog = json['lvl_log'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['code'] = this.code;
  //   data['messages'] = this.messages;
  //   if (this.data != null) {
  //     data['data'] = this.data!.toJson();
  //   }
  //   return data;
  // }
}

class BaseResponseLogin {
  late bool? status;
  late String? message;
  late LoginModel? data;

  BaseResponseLogin({this.status, this.message, this.data});

  factory BaseResponseLogin.fromJson(Map<String, dynamic> json) =>
      BaseResponseLogin(
          status: json['success'],
          message: json['message'],
          data: (json['data'] is String)
              ? null
              : LoginModel.fromJson(json['data']));
  // status = ;
  // message = ;
  // data = ;

}

// class PostList {
//   late List<Posts> postList;

//   PostList(this.postList);

//   factory PostList.fromJson(List<dynamic> json) =>
//       PostList(json.map((e) => Posts.fromJson(e)).toList());
// }
