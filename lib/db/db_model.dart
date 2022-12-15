import 'package:hive/hive.dart';
part 'db_model.g.dart';

@HiveType(typeId: 1)
class DbCartModel {
  @HiveField(0)
    int? keyId;
  @HiveField(1)
  final int itemID;
  @HiveField(2)
  final String itemName;
  //final int barcode;
  @HiveField(3)
  final String imageUrl;
  @HiveField(4)
  final int quantity;
  @HiveField(5)
  final double specialPrice;
  @HiveField(6)
  final double unitPrice;
  @HiveField(7)
  final String urlKey;

  DbCartModel({
    this.keyId,
    required this.itemName,
    //required this.barcode,
    required this.imageUrl,
    required this.unitPrice,
    required this.specialPrice,
    required this.itemID,
    required this.quantity,
    required this.urlKey

  });
}
