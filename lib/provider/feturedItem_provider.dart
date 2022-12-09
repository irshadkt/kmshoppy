import 'dart:convert';
import 'package:flutter/material.dart';

import '../models/feturedItem_model.dart';

class ItemProvider with ChangeNotifier{
  //List<SliderModel> sliderList = [];
  List<ItemModel> frequentItemList = [];

  // void addItems(String response) {
  //   final decode = jsonDecode(response);
  //   if (decode != null) {
  //     var branches = [];
  //     branches = decode['data'].map((items) {
  //       return ItemModel.fromJson(items);
  //     }).toList();
  //
  //     itemList = List<ItemModel>.from(branches);
  //     // print('itemList=$itemList ');
  //     notifyListeners();
  //   }
  //   print('itemList.length ${itemList.length} ');
  //
  // }
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