class Loket {
  String? sId;
  String? name;
  String? code;
  List<String>? coordinate;

  Loket({this.sId, this.name, this.code, this.coordinate});

  Loket.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
    if (json['location']['coordinate'] != null) {
      coordinate = json['location']['coordinate'].cast<String>();
    } else {
      coordinate = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['code'] = this.code;
    data['coordinate'] = this.coordinate;

    return data;
  }
}
