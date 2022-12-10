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
    this.variants,
    this.variantList
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
    variants=json['variationJson'];
    //var a=json['variationJson'];
    //var ab = json.decode(a).cast<String>().toList();
    //var b=json.decode(a);
    //variantList=ab;
   // variants=json['stockAvailability'];
    //variantList= lists[0]['AttrValues'];
    if (variants != null) {
      var lists = jsonDecode(json['variationJson']);
      if(lists != null){
        variantList = [];
        lists[0]['AttrValues'].forEach((v) {
          variantList?.add(VariantModel.fromJson(v));
        });
      }else{
        variantList=[];
      }
    }else{
      variantList=[];
    }
    //variantList=[];
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
  String? variants;
  //VariantModel? variants;
 List<VariantModel>? variantList;
  //List ? variantList;
}
// VariantModel variantModelFromJson(String str) =>
//     VariantModel.fromJson(json.decode(str));
class VariantModel {
  VariantModel({
    this.itemName,
    this.urlKey,
    this.unitPrice,
    this.specialPrice,
    this.itemID
  });
  VariantModel.fromJson(Map<String, dynamic> json) {
    itemName = json['prName'];
    urlKey = json['prName'];
    unitPrice = double.parse(json['prPrice']);
    specialPrice = double.parse(json['prSpecialPrice']);
    itemID = json['productId'];
  }
  String? itemName;
  String? itemID;
  double? specialPrice;
  double? unitPrice;
  String? urlKey;
}
//variants=json['variationJson']['AttrValues'];
// variants=json['variationJson'];
//variants=jsonDecode(json['variationJson']);
//variants  = json.decode(json['variationJson']);