import 'package:medico_app/models/outlet/operationalHours_model.dart';

class SublistModel {
  String? id;
  String? name;
  String? parentName;
  List<String>? holidays;
  List<OperationalModel>? operationalHours;
  List<ServiceModel>? services;

  SublistModel({
    this.id,
    this.parentName,
    this.name,
    this.holidays,
    this.operationalHours,
  });

  SublistModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    parentName = json['parentName'];

    name = json['name'];

    if (json['holidays'][0] != '') {
      holidays = [];
      json['holidays'].forEach((v) {
        holidays!.add(v);
      });
    } else {
      holidays = [];
    }

    if (json['operationalHours'][0]['hourStart'] != '') {
      operationalHours = <OperationalModel>[];
      json['operationalHours'].forEach((v) {
        operationalHours!.add(new OperationalModel.fromJson(v));
      });
    } else {
      operationalHours = [];
    }
    if (json['services'][0]['_id'] != '') {
      services = <ServiceModel>[];
      json['services'].forEach((v) {
        services!.add(new ServiceModel.fromJson(v));
      });
    } else {
      services = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['parentName'] = this.parentName;
    data['name'] = this.name;

    if (this.operationalHours![0].hourStart != '') {
      data['operationalHours'] =
          this.operationalHours!.map((v) => v.toJson()).toList();
    } else {
      data['operationalHours'] = [];
    }

    return data;
  }
}

class ServiceModel {
  String? id;
  String? name;
  int? price;
  bool isSelected = false;

  void setIsChecked(bool isChecked) {
    this.isSelected = isChecked;
  }

  bool getIsChecked() {
    return isSelected;
  }

  ServiceModel({
    this.id,
    this.name,
    this.price,
  });

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;

    return data;
  }
}
