import 'dart:convert';

DetailModelResponse itemModelResponseFromJson(String str) =>
    DetailModelResponse.fromJson(json.decode(str));
class DetailModelResponse {
  DetailModelResponse({
    // this.status,
    this.message,
    this.data,
  });
  DetailModelResponse.fromJson(dynamic json) {
    // status = json['status'];
    message = json['message'];
    if (json['Data'] != null) {
      data = json['Data']['ProdDetails'];
    }
  }
  // String? status;
  String? message;
  DetailModel? data;
}
DetailModel itemModelFromJson(String str) =>
    DetailModel.fromJson(json.decode(str));
class DetailModel {
  DetailModel({
    this.itemName,
    this.image,
    this.itemID,
    this.specialPrice,
    this.unitPrice,
    this.urlKey,
    this.description,
    this.shortDescription,
    this.prWeight,
    this.additionalImages,
    //this.variants,
    //this.variantList
  });
  DetailModel.fromJson(dynamic json) {
    itemName = json['prName'];
    image = json['imageUrl'];
    itemID = json['productId'];
    specialPrice = json['specialPrice'];
    unitPrice = json['unitPrice'];
    urlKey = json['urlKey'];
    description = json['description'];
    shortDescription = json['shortDescription'];
    prWeight = json['prWeight'];
    additionalImages = [];
    //variantList= json['variationJson'];
  }
  String? itemName;
  String? image;
  int? itemID;
  double? specialPrice;
  double? unitPrice;
  String? urlKey;
  String? description;
  String? shortDescription;
  String? prWeight;
  List<String>? additionalImages;
  //VariantModel? variants;
 //List<VariantModel>? variantList;
  //List ? variantList;
}
VariantModel variantModelFromJson(String str) =>
    VariantModel.fromJson(json.decode(str));
class VariantModel {
  VariantModel({
    this.itemName,
  });
  VariantModel.fromJson(Map<String, dynamic> json) {
    itemName = json['imageUrl'];
  }
  String? itemName;
}
//variants=json['variationJson']['AttrValues'];
// variants=json['variationJson'];
//variants=jsonDecode(json['variationJson']);
//variants  = json.decode(json['variationJson']);