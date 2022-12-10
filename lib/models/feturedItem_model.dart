import 'dart:convert';
ItemModelResponse itemModelResponseFromJson(String str) => ItemModelResponse.fromJson(json.decode(str));
String itemModelResponseToJson(ItemModelResponse data) => json.encode(data.toJson());
class ItemModelResponse {
  ItemModelResponse({
   // this.status,
    this.message,
    this.data,});

  ItemModelResponse.fromJson(dynamic json) {
   // status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ItemModel.fromJson(v));
      });
    }
  }
 // String? status;
  String? message;
  List<ItemModel>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
   // map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));
String itemModelToJson(ItemModel data) => json.encode(data.toJson());
class ItemModel {
  ItemModel({
    this.itemName,
    this.image,
    this.itemID,
    this.salesPrice,
    this.urlKey
  });

  ItemModel.fromJson(dynamic json) {
    itemName = json['prName'];
    image = json['imageUrl'];
    itemID = json['productId'];
    salesPrice = json['unitPrice'];
    urlKey=json['urlKey'];
  }
  String? itemName;
  String? image;
  int? itemID;
  double? salesPrice;
  String? urlKey;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ItemName'] = itemName;
    map['image'] = image;
    map['ItemID'] = itemID;
    map['SalesPrice'] = salesPrice;
    map['urlKey'] = urlKey;
    return map;
  }

}