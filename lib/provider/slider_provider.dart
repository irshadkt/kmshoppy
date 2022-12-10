import 'dart:convert';
import 'package:flutter/material.dart';

import '../models/feturedItem_model.dart';
import '../models/slider_model.dart';

class SliderProvider with ChangeNotifier{
  List<SliderModel> sliderList = [];

  void addSliders(String response) {
    final decode = jsonDecode(response);
    if (decode != null) {
      var branches = [];
      branches = decode['Data']['MobileMainBanners'].map((items) {
        return SliderModel.fromJson(items);
      }).toList();
      sliderList = List<SliderModel>.from(branches);
      notifyListeners();
    }
    // print('frequentItemList=$frequentItemList');
    print('sliderList.length${sliderList.length}');
  }
}