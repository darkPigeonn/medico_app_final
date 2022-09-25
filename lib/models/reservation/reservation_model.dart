import 'package:medico_app/models/outlet/sublist_model.dart';
import 'package:medico_app/models/reservation/loket_model.dart';
import 'package:medico_app/models/user/user_model.dart';

class ReservationModel {
  String? id;
  String? patientId;
  String? subOutletId;
  String? reservationDate;
  List<ServiceModel>? services;

  ReservationModel(
      {this.id,
      this.patientId,
      this.reservationDate,
      this.subOutletId,
      this.services});

  ReservationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patientId'];
    reservationDate = json['reservationDate'];
    subOutletId = json['subOutletId'];
    if (json['services'] != null) {
      services = [];
      json['services'].forEach((v) {
        services!.add(new ServiceModel.fromJson(v));
      });
    } else {
      services = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patientId'] = this.patientId;
    data['reservationDate'] = this.reservationDate;
    data['subOutletId'] = this.subOutletId;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReservationDataModel {
  String? id;
  String? patientName;
  String? outletName;
  String? subOutletName;
  int? status;
  String? reservationDate;
  List<ServicesReservationModel>? services;

  ReservationDataModel(
      {this.id,
      this.patientName,
      this.outletName,
      this.subOutletName,
      this.status,
      this.reservationDate,
      this.services});

  ReservationDataModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    patientName = json['patientName'];
    outletName = json['outletName'];
    subOutletName = json['subOutletName'];
    status = json['status'];
    reservationDate = json['reservationDate'];
    if (json['services'][0]['serviceName'] != '') {
      services = <ServicesReservationModel>[];
      json['services'].forEach((v) {
        services!.add(new ServicesReservationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['patientName'] = this.patientName;
    data['outletName'] = this.outletName;
    data['subOutletName'] = this.subOutletName;
    data['status'] = this.status;
    data['reservationDate'] = this.reservationDate;
    if (this.services![0].serviceName != '') {
      data['services'] = this.services!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class ServicesReservationModel {
  String? serviceName;
  int? amount;

  ServicesReservationModel({this.serviceName, this.amount});

  ServicesReservationModel.fromJson(Map<String, dynamic> json) {
    serviceName = json['serviceName'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serviceName'] = this.serviceName;
    data['amount'] = this.amount;
    return data;
  }
}
