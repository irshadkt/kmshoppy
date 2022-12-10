import 'dart:convert';
HomeModelResponse homeModelResponseFromJson(String str) => HomeModelResponse.fromJson(json.decode(str));
String itemModelResponseToJson(HomeModelResponse data) => json.encode(data.toJson());
class HomeModelResponse {
  HomeModelResponse({
    // this.status,
    this.message,
    this.data,});

  HomeModelResponse.fromJson(dynamic json) {
    // status = json['status'];
    message = json['Message'];
    if (json['Data']['MobileMainBanners'] != null) {
      data = [];
      json['Data']['MobileMainBanners'].forEach((v) {
        data?.add(SliderModel.fromJson(v));
      });
    }
  }
  // String? status;
  String? message;
  List<SliderModel>? data;

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

SliderModel itemModelFromJson(String str) => SliderModel.fromJson(json.decode(str));
String itemModelToJson(SliderModel data) => json.encode(data.toJson());
class SliderModel {
  SliderModel({
    this.itemName,
    this.image,
  });

  SliderModel.fromJson(dynamic json) {
    itemName = json['elementName'];
    image = json['imageUrl'];

  }
  String? itemName;
  String? image;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ItemName'] = itemName;
    map['image'] = image;
    return map;
  }

}