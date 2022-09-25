class ResponseTopUp {
  int? code;
  String? message;
  bool? success;

  ResponseTopUp({this.code, this.message, this.success});

  ResponseTopUp.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}
