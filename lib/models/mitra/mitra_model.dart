class MitraModel {
  String? id;
  String? customerId;
  String? name;
  String? address;
  String? city;
  String? subdistrict;
  String? ktp;
  String? selfi;
  String? savingBook;
  bool? isWorkshop;
  bool? isApprove;
  bool? isActive;
  bool? isVerified;
  WorkshopLocation? workshopLocation;
  WorkshopLocation? requestLocation;
  OperationHour? operationHour;
  String? createdAt;
  String? updateAt;

  MitraModel(
      {this.id,
      this.customerId,
      this.name,
      this.address,
      this.city,
      this.subdistrict,
      this.ktp,
      this.selfi,
      this.savingBook,
      this.isWorkshop,
      this.isApprove,
      this.isActive,
      this.isVerified,
      this.workshopLocation,
      this.requestLocation,
      this.operationHour,
      this.createdAt,
      this.updateAt});

  MitraModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    subdistrict = json['subdistrict'];
    ktp = json['ktp'];
    selfi = json['selfi'];
    savingBook = json['savingBook'];
    isWorkshop = json['isWorkshop'];
    isApprove = json['isApprove'];
    isActive = json['isActive'];
    isVerified = json['is_verified'];
    workshopLocation = json['workshopLocation'] != null
        ? new WorkshopLocation.fromJson(json['workshopLocation'])
        : null;
    requestLocation = json['requestLocation'] != null
        ? new WorkshopLocation.fromJson(json['requestLocation'])
        : null;
    operationHour = json['operation_hour'] != null
        ? new OperationHour.fromJson(json['operation_hour'])
        : null;
    createdAt = json['created_at'];
    updateAt = json['update_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['city'] = this.city;
    data['subdistrict'] = this.subdistrict;
    data['ktp'] = this.ktp;
    data['selfi'] = this.selfi;
    data['savingBook'] = this.savingBook;
    data['isWorkshop'] = this.isWorkshop;
    data['isApprove'] = this.isApprove;
    data['isActive'] = this.isActive;
    data['is_verified'] = this.isVerified;
    if (this.workshopLocation != null) {
      data['workshopLocation'] = this.workshopLocation!.toJson();
    }
    if (this.requestLocation != null) {
      data['requestLocation'] = this.requestLocation!.toJson();
    }
    if (this.operationHour != null) {
      data['operation_hour'] = this.operationHour!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['update_at'] = this.updateAt;
    return data;
  }
}

class WorkshopLocation {
  String? type;
  List<String>? coordinate;

  WorkshopLocation({this.type, this.coordinate});

  WorkshopLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinate = json['coordinate'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinate'] = this.coordinate;
    return data;
  }
}

class OperationHour {
  Sunday? sunday;
  Sunday? monday;
  Sunday? tuesday;
  Sunday? wednesday;
  Sunday? thursday;
  Sunday? friday;
  Sunday? saturday;

  OperationHour(
      {this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday});

  OperationHour.fromJson(Map<String, dynamic> json) {
    sunday =
        json['sunday'] != null ? new Sunday.fromJson(json['sunday']) : null;
    monday =
        json['monday'] != null ? new Sunday.fromJson(json['monday']) : null;
    tuesday =
        json['tuesday'] != null ? new Sunday.fromJson(json['tuesday']) : null;
    wednesday = json['wednesday'] != null
        ? new Sunday.fromJson(json['wednesday'])
        : null;
    thursday =
        json['thursday'] != null ? new Sunday.fromJson(json['thursday']) : null;
    friday =
        json['friday'] != null ? new Sunday.fromJson(json['friday']) : null;
    saturday =
        json['saturday'] != null ? new Sunday.fromJson(json['saturday']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sunday != null) {
      data['sunday'] = this.sunday!.toJson();
    }
    if (this.monday != null) {
      data['monday'] = this.monday!.toJson();
    }
    if (this.tuesday != null) {
      data['tuesday'] = this.tuesday!.toJson();
    }
    if (this.wednesday != null) {
      data['wednesday'] = this.wednesday!.toJson();
    }
    if (this.thursday != null) {
      data['thursday'] = this.thursday!.toJson();
    }
    if (this.friday != null) {
      data['friday'] = this.friday!.toJson();
    }
    if (this.saturday != null) {
      data['saturday'] = this.saturday!.toJson();
    }
    return data;
  }
}

class Sunday {
  bool? active;
  int? hourStart;
  int? hourEnd;
  int? capacity;

  Sunday({this.active, this.hourStart, this.hourEnd, this.capacity});

  Sunday.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    hourStart = json['hour_start'];
    hourEnd = json['hour_end'];
    capacity = json['capacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['hour_start'] = this.hourStart;
    data['hour_end'] = this.hourEnd;
    data['capacity'] = this.capacity;
    return data;
  }
}
