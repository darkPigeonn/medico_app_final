import 'package:medico_app/models/mitra/mitra_availibility_model.dart';

class MitraServiceModel {
  String? id;
  String? mitraId;
  String? name;
  List<ServiceAvailability>? serviceAvailability;
  int? price;
  bool? activeStatus;

  MitraServiceModel(
      {this.id,
      this.mitraId,
      this.name,
      this.serviceAvailability,
      this.price,
      this.activeStatus});

  MitraServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mitraId = json['mitraId'];
    name = json['name'];
    if (json['serviceAvailability'] != null) {
      serviceAvailability = <ServiceAvailability>[];
      json['serviceAvailability'].forEach((v) {
        serviceAvailability!.add(new ServiceAvailability.fromJson(v));
      });
    }
    price = json['price'];
    activeStatus = json['activeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mitraId'] = this.mitraId;
    data['name'] = this.name;
    if (this.serviceAvailability != null) {
      data['serviceAvailability'] =
          this.serviceAvailability!.map((v) => v.toJson()).toList();
    }
    data['price'] = this.price;
    data['activeStatus'] = this.activeStatus;
    return data;
  }
}
