import 'package:hive/hive.dart';
part 'db_model.g.dart';

@HiveType(typeId: 1)
class DbCartModel {
  @HiveField(0)
  final int itemID;
  @HiveField(2)
  final String itemName;
  //final int barcode;
  @HiveField(3)
  final String imageUrl;
  @HiveField(4)
  final String itemUnit;
  @HiveField(5)
  final int quantity;
  @HiveField(6)
  final double specialPrice;
  @HiveField(7)
  final double unitPrice;
  int? key;

  DbCartModel({
    required this.itemName,
    //required this.barcode,
    required this.imageUrl,
    required this.itemUnit,
    required this.unitPrice,
    required this.specialPrice,
    required this.itemID,
    required this.quantity,
    this.key

  });
}
