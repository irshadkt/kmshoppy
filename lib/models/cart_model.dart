class CartModel {
  final int itemID;
  final String itemName;
  //final int barcode;
  final String imageUrl;
  //final String itemUnit;
  final int quantity;
  double? salesPrice;
  double? unitPrice;
  int? key;

  CartModel({
    required this.itemName,
    //required this.barcode,
    required this.imageUrl,
    //required this.itemUnit,
    this.unitPrice,
    this.salesPrice,
    required this.itemID,
    required this.quantity,
    this.key

  });

  Map<String, dynamic> toMap() {
    return {
      'itemID': itemID,
      'quantity': quantity,
      'salesPrice': salesPrice,
      'mrP': unitPrice,
      'itemName': itemName,
      'imageUrl': imageUrl,
      //'itemUnit': itemUnit,
      //'barcode':barcode
      // 'cartItem': cartItem
    };
  }
}
