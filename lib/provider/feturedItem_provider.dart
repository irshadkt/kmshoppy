import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kmshoppy/models/detils_model.dart';

import '../models/feturedItem_model.dart';

class ItemProvider with ChangeNotifier{
  List<VariantModel> variantList = [];
  List<ItemModel> frequentItemList = [];
  late DetailModel productDetail;

  void addDetails(String response) {
    final decode = jsonDecode(response);
    if (decode != null) {
      productDetail = DetailModel.fromJson(decode['Data']['ProdDetails']);
      notifyListeners();
    }
  }
  // void addVariants(String response) {
  //   final decode = jsonDecode(response);
  //   if (decode != null) {
  //     variantList = VariantModel.fromJson(decode['Data']['ProdDetails']);
  //     notifyListeners();
  //   }
  // }

  void addVariants(String response) {
    final decode = jsonDecode(response);
    //print("decode=$decode");
    final privilege = decode['Data']['ProdDetails'];
   // print("privilege========================================$privilege");
    final variant = decode['Data']['ProdDetails']['variationJson'];
    final parsedJson = json.decode(variant);
    final value = parsedJson['Attrname'];
    print("value=$value");
   //   final parsedJson = jsonDecode(decode['Data']['ProdDetails']['ProductCategories']);
   //  print("parsedJson=$parsedJson");
    //final privilege = parsedJson['Data']['ProdDetails']['variationJson'];
    //print("privilege=$privilege");
    // if (decode != null) {
    //   var branches = [];
    //   branches = decode['Data']['ProdDetails'].map((items) {
    //     return VariantModel.fromJson(items);
    //   }).toList();
    //   variantList = List<VariantModel>.from(branches);
    //   print("VariantModel=$VariantModel");
    //   notifyListeners();
    // }
    // print('frequentItemList=$frequentItemList');
    print('frequentItemList.length${frequentItemList.length}');
  }
  void addFrequentItems(String response) {
    final decode = jsonDecode(response);
    if (decode != null) {
      var branches = [];
      branches = decode['Data'].map((items) {
        return ItemModel.fromJson(items);
      }).toList();
      frequentItemList = List<ItemModel>.from(branches);
      notifyListeners();
    }
    // print('frequentItemList=$frequentItemList');
    print('frequentItemList.length${frequentItemList.length}');
  }
}