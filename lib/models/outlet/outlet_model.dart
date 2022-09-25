import 'package:medico_app/models/outlet/sublist_model.dart';

class OutletModel {
  String? name;
  String? address;
  List<String>? holidays = [];
  List<SublistModel>? subList;
  String? tzOffset;

  OutletModel(
      {this.name, this.address, this.holidays, this.tzOffset, this.subList});

  OutletModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];

    if (json['holidays'][0] != '') {
      json['holidays'].forEach((v) {
        holidays!.add(v.toString());
      });
    } else {
      holidays = [];
    }
    tzOffset = json['tzOffset'];

    if (json['subList'][0]['_id'] != '') {
      subList = <SublistModel>[];
      json['subList'].forEach((v) {
        subList!.add(new SublistModel.fromJson(v));
      });
    } else {
      subList = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['tzOffset'] = this.tzOffset;
    if (this.holidays![0] != '') {
      data['holidays'] = this.holidays;
    } else {
      data['holidays'] = [];
    }
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
