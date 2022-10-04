class LoginModel {
  late String? id;
  late String? name;
  late String? email;

  late String? roleId;
  late String? deptId;
  late String? phone;
  late String? activeFg;
  late String? roleName;
  late String? deptName;
  late String? bankId;
  late String? bankNm;
  LoginModel(
      {this.id,
      this.name,
      this.email,
      this.roleId,
      this.deptId,
      this.phone,
      this.activeFg,
      this.roleName,
      this.deptName,
      this.bankId,
      this.bankNm});

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    roleId = json['role_id'];
    deptId = json['dept_id'];
    phone = json['phone'];
    activeFg = json['active_fg'];
    roleName = json['role_name'];
    deptName = json['dept_nm'];
    bankId = json['bank_id'];
    bankNm = json['bank_nm'];
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
          status: json['status'],
          message: json['message'],
          data: (json['data'] == null)
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
