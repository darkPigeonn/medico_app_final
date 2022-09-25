class Layanan {
  String? sId;
  String? name;
  String? category;
  String? lastUpdateBy;
  int? price;
  int? priceSilver;
  int? priceGold;
  int? cogs;
  bool? cogsFlag;
  String? createdAt;
  String? updateAt;
  int? realPrice;
  bool isChecked = false;
  int qtyTotal = 0;

  void setIsChecked(bool isChecked) {
    this.isChecked = isChecked;
  }

  bool getIsChecked() {
    return isChecked;
  }

  void addQty(int val) {
    this.qtyTotal = this.qtyTotal + val;
  }

  void removeQty(int val) {
    this.qtyTotal = this.qtyTotal - val;
  }

  Layanan(
      {this.sId,
      this.name,
      this.category,
      this.lastUpdateBy,
      this.price,
      this.priceSilver,
      this.priceGold,
      this.cogs,
      this.cogsFlag,
      this.createdAt,
      this.updateAt,
      this.realPrice});

  Layanan.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    category = json['category'];
    lastUpdateBy = json['last_update_by'];
    price = json['price'];
    priceSilver = json['price_silver'];
    priceGold = json['price_gold'];
    cogs = json['cogs'];
    cogsFlag = json['cogs_flag'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
    realPrice = json['real_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['category'] = this.category;
    data['last_update_by'] = this.lastUpdateBy;
    data['price'] = this.price;
    data['price_silver'] = this.priceSilver;
    data['price_gold'] = this.priceGold;
    data['cogs'] = this.cogs;
    data['cogs_flag'] = this.cogsFlag;
    data['created_at'] = this.createdAt;
    data['update_at'] = this.updateAt;

    data['real_price'] = this.realPrice;
    return data;
  }
}

// class Layanan {
//   String? sId;
//   String? name;
//   String? sku;
//   String? description;
//   String? barcode;
//   String? category;
//   int? qty;
//   int? qtyThreshold;
//   int? cogs;
//   int? price;
//   String? note;
//   bool? cogsFlag;
//   String? lastCogsChanged;
//   String? createdAt;
//   String? createdBy;
//   String? updateAt;
//   String? lastUpdateBy;
//   bool isChecked = false;
//   int qtyTotal = 0;

//   void setIsChecked(bool isChecked) {
//     this.isChecked = isChecked;
//   }

//   bool getIsChecked() {
//     return isChecked;
//   }

//   void addQty(int val) {
//     this.qtyTotal = this.qtyTotal + val;
//   }

//   void removeQty(int val) {
//     this.qtyTotal = this.qtyTotal - val;
//   }

//   Layanan(
//       {this.sId,
//       this.name,
//       this.sku,
//       this.description,
//       this.barcode,
//       this.category,
//       this.qty,
//       this.qtyThreshold,
//       this.cogs,
//       this.price,
//       this.note,
//       this.cogsFlag,
//       this.lastCogsChanged,
//       this.createdAt,
//       this.createdBy,
//       this.updateAt,
//       this.lastUpdateBy});

//   Layanan.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     sku = json['sku'];
//     description = json['description'];
//     barcode = json['barcode'];
//     category = json['category'];
//     qty = json['qty'];
//     qtyThreshold = json['qty_threshold'];
//     cogs = json['cogs'];
//     price = json['price'];
//     note = json['note'];
//     cogsFlag = json['cogs_flag'];
//     lastCogsChanged = json['last_cogs_changed'];
//     createdAt = json['created_at'];
//     createdBy = json['created_by'];
//     updateAt = json['update_at'];
//     lastUpdateBy = json['last_update_by'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['sku'] = this.sku;
//     data['description'] = this.description;
//     data['barcode'] = this.barcode;
//     data['category'] = this.category;
//     data['qty'] = this.qty;
//     data['qty_threshold'] = this.qtyThreshold;
//     data['cogs'] = this.cogs;
//     data['price'] = this.price;
//     data['note'] = this.note;
//     data['cogs_flag'] = this.cogsFlag;
//     data['last_cogs_changed'] = this.lastCogsChanged;
//     data['created_at'] = this.createdAt;
//     data['created_by'] = this.createdBy;
//     data['update_at'] = this.updateAt;
//     data['last_update_by'] = this.lastUpdateBy;
//     return data;
//   }
// }


// class Layanan {
//   final String? id;
//   final String? layanan;
//   bool isChecked = false;

//   void setIsChecked(bool isChecked) {
//     this.isChecked = isChecked;
//   }

//   bool getIsChecked() {
//     return isChecked;
//   }

//   Layanan({
//     this.id,
//     this.layanan,
//   });
// }
