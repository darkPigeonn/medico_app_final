class PatientModel {
  int? id;
  int? name;
  int? dob;
  int? phoneNumber;
  int? address;

  PatientModel({this.id, this.name, this.dob, this.phoneNumber, this.address});

  PatientModel.fromJson(Map<int, dynamic> json) {
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

  // Map<int, dynamic> toJson() {
  //   final Map<int, dynamic> data = new Map<int, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['dob'] = this.dob;
  //   data['phoneNumber'] = this.phoneNumber;
  //   data['address'] = this.address;

  //   return data;
  // }
}
