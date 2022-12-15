import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kmshoppy/db/db_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
ValueNotifier<List<DbCartModel>> cartListNotifier= ValueNotifier([]);

Future<void> addItem(DbCartModel value) async {
  final cartDb=await  Hive.openBox<DbCartModel>('cart_db');
  final  id = await cartDb.add(value);
  value.keyId=id;
  getDbData();
  cartListNotifier.notifyListeners();
}
Future<void> updateCartItem(DbCartModel value,) async {
  final cartDb=await  Hive.openBox<DbCartModel>('cart_db');
   await cartDb.put(value.keyId, value);
  getDbData();
  cartListNotifier.notifyListeners();
}
Future<void> cartClear() async {
  final cartDb=await  Hive.openBox<DbCartModel>('cart_db');
 // final  id = await cartDb.add(value);
  //cartListNotifier.value.addAll(cartDb.values);
  await cartDb.clear();
  cartListNotifier.notifyListeners();
  getDbData();
  //cartListNotifier.value.add(value);

  //print("cart list=${cartListNotifier}");
}

Future<void> getDbData() async {
  final cartDb=await  Hive.openBox<DbCartModel>('cart_db');
  cartListNotifier.value.clear();
  cartListNotifier.value.addAll(cartDb.values);
  cartListNotifier.notifyListeners();
  print("cart list=${jsonEncode(cartListNotifier.value.length)}");
}

Future<void> removeItem(int id) async {
  //cartListNotifier.removeWhere((item) => item.itemID == itemID);
  final cartDb=await  Hive.openBox<DbCartModel>('cart_db');
  cartDb.delete(id);
  cartListNotifier.notifyListeners();
  getDbData();
  //cartListNotifier.value.add(value);
}


