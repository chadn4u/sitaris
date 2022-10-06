class BaseResponse {
  late bool? status;
  late String? message;

  BaseResponse({this.status, this.message});

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        status: json['status'],
        message: json['message'],
      );
}
