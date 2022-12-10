import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';

class CartProvider with ChangeNotifier {

  //DbHelper dbHelper = DbHelper();
  // List<DbCart> dbCart = [];
  // List<CartModel> cartList = [];
  List<CartModel> cartList = [];
  //List<ItemModel> searchItemList = [];
  double savedAmt = 0.0;
  double totalAmt = 0.0;

   int cartItemCount = 0;
  double quantity = 0;
  int addressId = 0;

  // getCart(context) async {
  //   // final stateBranch = Provider.of<BranchProvider>(context, listen: false);
  //   // final cartValues = await dbHelper.getCart(1);
  //   // final cartValues = await dbHelper.getCart(stateBranch.selectedBranchId);
  //   final state = Provider.of<BranchProvider>(context, listen: false);
  //   cartList = await dbHelper.getCart(state.selectedBranchId);
  //   print('cartList ${cartList}length${cartList.length}');
  //   notifyListeners();
  // }


  getTotalAmount() {
    double totalSales = 0;
    for (var element in cartList) {
      totalSales += element.salesPrice!.toDouble() * element.quantity;
    }
    totalAmt = totalSales;
    notifyListeners();
  }

  // getQuantity(int itemID) async {
  //   final qty = await dbHelper.getQuantity(itemID);
  //   print('qty$qty');
  //   quantity = qty;
  // }
}
