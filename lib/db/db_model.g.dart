// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DbCartModelAdapter extends TypeAdapter<DbCartModel> {
  @override
  final int typeId = 1;

  @override
  DbCartModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DbCartModel(
      itemName: fields[2] as String,
      imageUrl: fields[3] as String,
      itemUnit: fields[4] as String,
      unitPrice: fields[7] as double,
      specialPrice: fields[6] as double,
      itemID: fields[0] as int,
      quantity: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DbCartModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.itemID)
      ..writeByte(2)
      ..write(obj.itemName)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.itemUnit)
      ..writeByte(5)
      ..write(obj.quantity)
      ..writeByte(6)
      ..write(obj.specialPrice)
      ..writeByte(7)
      ..write(obj.unitPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DbCartModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
