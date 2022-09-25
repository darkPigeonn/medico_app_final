class PatientModel {
  String? id;
  String? name;
  String? dob;
  String? phoneNumber;
  String? address;

  PatientModel({this.id, this.name, this.dob, this.phoneNumber, this.address});

  PatientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dob = json['dob'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    // creditBalance = json['credit_balance'];
    // realMembership = json['real_membership'];
    // if (json['vehicles'][0]['id'] != '') {
    //   vehicles = <Vehicles>[];
    //   json['vehicles'].forEach((v) {
    //     vehicles!.add(new Vehicles.fromJson(v));
    //   });
    // } else {
    //   vehicles = [];
    // }
    // mitra = json['mitra'];
    // preferensi = json['preferensi'] != null
    //     ? new Preferensi.fromJson(json['preferensi'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;

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
