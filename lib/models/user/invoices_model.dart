// To parse this JSON data, do
//
//     final invoicesModel = invoicesModelFromJson(jsonString);

import 'dart:convert';

InvoicesModel invoicesModelFromJson(String str) =>
    InvoicesModel.fromJson(json.decode(str));

String invoicesModelToJson(InvoicesModel data) => json.encode(data.toJson());

class InvoicesModel {
  String? id;
  String? containerId;
  List<MsList>? msList;
  String? customerId;
  String? customerName;
  List<Medicine>? medicines;
  List<CustomItem>? petFoods;
  List<CustomItem>? labServices;
  List<CustomItem>? customItems;
  List<Service>? services;
  int? surcharge;
  int? ongkir;
  int? courier;
  int? totalPurchase;
  int? discount;
  int? payment;
  int? paymentMethod;
  bool? payless;
  String? outletId;
  String? outletName;
  String? subOutletId;
  String? subOutletName;
  bool? effective;
  String? attendantId;
  String? attendantName;
  String? doctorName;
  String? name;
  CreatedAt? invoiceDate;
  CreatedAt? createdAt;
  String? createdBy;
  String? cashierId;
  String? cashierName;
  CreatedAt? paymentTimestamp;

  InvoicesModel({
    this.id,
    this.containerId,
    this.msList,
    this.customerId,
    this.customerName,
    this.medicines,
    this.petFoods,
    this.labServices,
    this.customItems,
    this.services,
    this.surcharge,
    this.ongkir,
    this.courier,
    this.totalPurchase,
    this.discount,
    this.payment,
    this.paymentMethod,
    this.payless,
    this.outletId,
    this.outletName,
    this.subOutletId,
    this.subOutletName,
    this.effective,
    this.attendantId,
    this.attendantName,
    this.doctorName,
    this.name,
    this.invoiceDate,
    this.createdAt,
    this.createdBy,
    this.cashierId,
    this.cashierName,
    this.paymentTimestamp,
  });

  factory InvoicesModel.fromJson(Map<String, dynamic> json) => InvoicesModel(
        id: json["_id"],
        containerId: json["containerId"],
        msList: json["msList"] == null
            ? []
            : List<MsList>.from(json["msList"]!.map((x) => MsList.fromJson(x))),
        customerId: json["customerId"],
        customerName: json["customerName"],
        medicines: json["medicines"] == null
            ? []
            : List<Medicine>.from(
                json["medicines"]!.map((x) => Medicine.fromJson(x))),
        petFoods: json["petFoods"] == null
            ? []
            : List<CustomItem>.from(
                json["petFoods"]!.map((x) => CustomItem.fromJson(x))),
        labServices: json["labServices"] == null
            ? []
            : List<CustomItem>.from(
                json["labServices"]!.map((x) => CustomItem.fromJson(x))),
        customItems: json["customItems"] == null
            ? []
            : List<CustomItem>.from(
                json["customItems"]!.map((x) => CustomItem.fromJson(x))),
        services: json["services"] == null
            ? []
            : List<Service>.from(
                json["services"]!.map((x) => Service.fromJson(x))),
        surcharge: json["surcharge"],
        ongkir: json["ongkir"],
        courier: json["courier"],
        totalPurchase: json["totalPurchase"],
        discount: json["discount"],
        payment: json["payment"],
        paymentMethod: json["paymentMethod"],
        payless: json["payless"],
        outletId: json["outletId"],
        outletName: json["outletName"],
        subOutletId: json["subOutletId"],
        subOutletName: json["subOutletName"],
        effective: json["effective"],
        attendantId: json["attendantId"],
        attendantName: json["attendantName"],
        doctorName: json["doctorName"],
        name: json["name"],
        invoiceDate: json["invoiceDate"] == null
            ? null
            : CreatedAt.fromJson(json["invoiceDate"]),
        createdAt: json["createdAt"] == null
            ? null
            : CreatedAt.fromJson(json["createdAt"]),
        createdBy: json["createdBy"],
        cashierId: json["cashierId"],
        cashierName: json["cashierName"],
        paymentTimestamp: json["paymentTimestamp"] == null
            ? null
            : CreatedAt.fromJson(json["paymentTimestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "containerId": containerId,
        "msList": msList == null
            ? []
            : List<dynamic>.from(msList!.map((x) => x.toJson())),
        "customerId": customerId,
        "customerName": customerName,
        "medicines": medicines == null
            ? []
            : List<dynamic>.from(medicines!.map((x) => x.toJson())),
        "petFoods": petFoods == null
            ? []
            : List<dynamic>.from(petFoods!.map((x) => x.toJson())),
        "labServices": labServices == null
            ? []
            : List<dynamic>.from(labServices!.map((x) => x.toJson())),
        "customItems": customItems == null
            ? []
            : List<dynamic>.from(customItems!.map((x) => x.toJson())),
        "services": services == null
            ? []
            : List<dynamic>.from(services!.map((x) => x.toJson())),
        "surcharge": surcharge,
        "ongkir": ongkir,
        "courier": courier,
        "totalPurchase": totalPurchase,
        "discount": discount,
        "payment": payment,
        "paymentMethod": paymentMethod,
        "payless": payless,
        "outletId": outletId,
        "outletName": outletName,
        "subOutletId": subOutletId,
        "subOutletName": subOutletName,
        "effective": effective,
        "attendantId": attendantId,
        "attendantName": attendantName,
        "doctorName": doctorName,
        "name": name,
        "invoiceDate": invoiceDate?.toJson(),
        "createdAt": createdAt?.toJson(),
        "createdBy": createdBy,
        "cashierId": cashierId,
        "cashierName": cashierName,
        "paymentTimestamp": paymentTimestamp?.toJson(),
      };
}

class CreatedAt {
  DateTime? date;

  CreatedAt({
    this.date,
  });

  factory CreatedAt.fromJson(Map<String, dynamic> json) => CreatedAt(
        date: json["\u0024date"] == null
            ? null
            : DateTime.parse(json["\u0024date"]),
      );

  Map<String, dynamic> toJson() => {
        "\u0024date": date?.toIso8601String(),
      };
}

class CustomItem {
  String? id;
  String? name;
  int? price;
  int? qty;
  int? subtotal;
  String? msId;
  bool? isCustom;
  String? stockId;
  int? cogs;

  CustomItem({
    this.id,
    this.name,
    this.price,
    this.qty,
    this.subtotal,
    this.msId,
    this.isCustom,
    this.stockId,
    this.cogs,
  });

  factory CustomItem.fromJson(Map<String, dynamic> json) => CustomItem(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        qty: json["qty"],
        subtotal: json["subtotal"],
        msId: json["msId"],
        isCustom: json["isCustom"],
        stockId: json["stockId"],
        cogs: json["cogs"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "qty": qty,
        "subtotal": subtotal,
        "msId": msId,
        "isCustom": isCustom,
        "stockId": stockId,
        "cogs": cogs,
      };
}

class Medicine {
  String? id;
  String? name;
  int? price;
  int? cogs;
  int? qty;
  int? subtotal;
  String? stockId;
  String? requestId;
  bool? needPres;
  String? msId;

  Medicine({
    this.id,
    this.name,
    this.price,
    this.cogs,
    this.qty,
    this.subtotal,
    this.stockId,
    this.requestId,
    this.needPres,
    this.msId,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        cogs: json["cogs"],
        qty: json["qty"],
        subtotal: json["subtotal"],
        stockId: json["stockId"],
        requestId: json["requestId"],
        needPres: json["needPres"],
        msId: json["msId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "cogs": cogs,
        "qty": qty,
        "subtotal": subtotal,
        "stockId": stockId,
        "requestId": requestId,
        "needPres": needPres,
        "msId": msId,
      };
}

class MsList {
  String? id;
  String? name;
  int? total;
  String? patientId;
  String? patientName;

  MsList({
    this.id,
    this.name,
    this.total,
    this.patientId,
    this.patientName,
  });

  factory MsList.fromJson(Map<String, dynamic> json) => MsList(
        id: json["_id"],
        name: json["name"],
        total: json["total"],
        patientId: json["patientId"],
        patientName: json["patientName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "total": total,
        "patientId": patientId,
        "patientName": patientName,
      };
}

class Service {
  String? name;
  int? price;
  int? qty;
  int? subtotal;
  String? msId;
  String? sid;
  int? type;

  Service({
    this.name,
    this.price,
    this.qty,
    this.subtotal,
    this.msId,
    this.sid,
    this.type,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        name: json["name"],
        price: json["price"],
        qty: json["qty"],
        subtotal: json["subtotal"],
        msId: json["msId"],
        sid: json["sid"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "qty": qty,
        "subtotal": subtotal,
        "msId": msId,
        "sid": sid,
        "type": type,
      };
}
