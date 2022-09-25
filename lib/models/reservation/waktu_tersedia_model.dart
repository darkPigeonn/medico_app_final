class WaktuTersedia {
  String? id;
  String? label;
  int? capacity;
  bool isTersedia = false;
  bool enabled = true;

  WaktuTersedia({this.id, this.label, this.capacity});

  WaktuTersedia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    capacity = json['capacity'];
    isTersedia = json['capacity'] > 0 ? true : false;

    bool isDisabled = false;
    if (json['isDisabled'] != null) {
      isDisabled = json['isDisabled'];
    }
    bool breakTime = false;
    if (json['breakTime'] != null) {
      breakTime = json['breakTime'];
    }
    if (json['capacity'] <= 0 || isDisabled || breakTime) {
      enabled = false;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['label'] = this.label;
    data['capacity'] = this.capacity;
    return data;
  }
}
