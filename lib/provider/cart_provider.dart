import 'package:flutter/material.dart';
import '../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> cartList = [];

  double savedAmt = 0.0;
  double totalAmt = 0.0;

   int cartItemCount = 0;
  double quantity = 0;
  int addressId = 0;

  getTotalAmount() {
    double totalSales = 0;
    for (var element in cartList) {
      totalSales += element.salesPrice!.toDouble() * element.quantity;
    }
    totalAmt = totalSales;
    notifyListeners();
  }

}
