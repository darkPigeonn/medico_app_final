class TopUpModel {
  int? code;
  Object? object;
  String? token;

  TopUpModel({this.code, this.object, this.token});

  TopUpModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    object =
        json['object'] != null ? new Object.fromJson(json['object']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.object != null) {
      data['object'] = this.object!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Object {
  String? statusCode;
  String? token;
  String? redirectUrl;
  dynamic errorMessages;

  Object({this.statusCode, this.token, this.redirectUrl, this.errorMessages});

  Object.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    token = json['token'];
    redirectUrl = json['redirect_url'];
    errorMessages = json['error_messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['token'] = this.token;
    data['redirect_url'] = this.redirectUrl;
    data['error_messages'] = this.errorMessages;
    return data;
  }
}
