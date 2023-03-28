class PatientModel {
  String? id;
  String? petName;
  String? dob;
  int? sex;

  PatientModel({this.id, this.petName, this.dob, this.sex});

  PatientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    petName = json['petName'];
    dob = json['dob'];
    sex = json['sex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['petName'] = this.petName;
    data['dob'] = this.dob;
    data['sex'] = this.sex;

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
