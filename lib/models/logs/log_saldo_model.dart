class LogSaldoModel {
  String? sId;
  String? customer;
  String? createdBy;
  String? name;
  String? note;
  int? transactionCode;
  bool? typeTransaction;
  String? eventDate;

  LogSaldoModel(
      {this.sId,
      this.customer,
      this.createdBy,
      this.name,
      this.note,
      this.transactionCode,
      this.typeTransaction,
      this.eventDate});

  LogSaldoModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customer = json['customer'];
    createdBy = json['createdBy'];
    name = json['name'];
    note = json['note'];
    transactionCode = json['transaction_code'];
    typeTransaction = json['type_transaction'];
    eventDate = json['event_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['customer'] = this.customer;
    data['createdBy'] = this.createdBy;
    data['name'] = this.name;
    data['note'] = this.note;
    data['transaction_code'] = this.transactionCode;
    data['type_transaction'] = this.typeTransaction;
    data['event_date'] = this.eventDate;
    return data;
  }
}
