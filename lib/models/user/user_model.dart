import 'package:medico_app/models/user/patient_model.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? realMembership;
  int? creditBalance;
  List<Vehicles>? vehicles;
  List<Vital>? vital;
  String? mitra;
  Preferensi? preferensi;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.password,
      this.creditBalance,
      this.vehicles,
      this.realMembership,
      this.mitra});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['patientList'][0]['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    // creditBalance = json['credit_balance'];
    // realMembership = json['real_membership'];
    if (json['patientList'][0]['vitalList'] != '') {
      vital = <Vital>[];
      json['patientList'][0]['vitalList'].forEach((v) {
        vital!.add(new Vital.fromJson(v));
      });
    } else {
      vital = [];
    }
    // mitra = json['mitra'];
    // preferensi = json['preferensi'] != null
    //     ? new Preferensi.fromJson(json['preferensi'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['main_phone'] = this.phone;
    data['password'] = this.password;
    data['real_membership'] = this.realMembership;
    if (this.vehicles![0].id != '') {
      data['vehicles'] = this.vehicles!.map((v) => v.toJson()).toList();
    } else {
      data['vehicles'] = [];
    }
    data['mitra'] = this.mitra;
    return data;
  }
}

class Vehicles {
  String? id;
  String? name;
  int? manufacturYear;
  int? registrationYear;
  String? image;
  String? nopol;

  Vehicles({
    this.id,
    this.name,
    this.manufacturYear,
    this.registrationYear,
    this.image,
    this.nopol,
  });

  Vehicles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    manufacturYear = json['manufactur_year'];
    registrationYear = json['registration_year'];
    image = json['image'];
    nopol = json['nopol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['manufactur_year'] = this.manufacturYear;
    data['registration_year'] = this.registrationYear;
    data['image'] = this.image;
    data['nopol'] = this.nopol;
    return data;
  }
}

class Preferensi {
  String? one;
  String? three;
  String? two;

  Preferensi({this.one, this.three, this.two});

  Preferensi.fromJson(Map<String, dynamic> json) {
    one = json['one'];
    three = json['three'];
    two = json['two'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['one'] = this.one;
    data['three'] = this.three;
    data['two'] = this.two;
    return data;
  }
}

//medic
class Vital {
  String? createdAt;
  int? weight,
      height,
      oxygen,
      tensiSistole,
      tensiDiastole,
      tensiPulse,
      kolestrol,
      asamUrat,
      glucose,
      darahPuasa,
      darah2Jam;

  Vital(
      {this.createdAt,
      this.weight,
      this.oxygen,
      this.tensiSistole,
      this.tensiDiastole,
      this.tensiPulse,
      this.kolestrol,
      this.asamUrat,
      this.glucose,
      this.darahPuasa,
      this.darah2Jam});

  Vital.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    weight = json['weight'];
    height = json['height'];
    oxygen = json['oxygen'];
    tensiSistole = json['tensiSistole'];
    tensiDiastole = json['tensiDiastole'];
    tensiPulse = json['tensiPulse'];
    kolestrol = json['kolestrol'];
    asamUrat = json['asamUrat'];
    glucose = json['glucose'];
    darahPuasa = json['darahPuasa'];
    darah2Jam = json['darah2Jam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['oxygen'] = this.oxygen;
    data['tensiSistole'] = this.tensiSistole;
    data['tenstiDiastole'] = this.tensiDiastole;
    data['tensiPulse'] = this.tensiPulse;
    data['kolestrol'] = this.kolestrol;
    data['asamUrat'] = this.asamUrat;
    data['glucose'] = this.glucose;
    data['darahPuasa'] = this.darahPuasa;
    data['darah2Jam'] = this.darah2Jam;
    return data;
  }
}
