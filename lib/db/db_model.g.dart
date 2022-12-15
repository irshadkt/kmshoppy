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
      keyId: fields[0] as int?,
      itemName: fields[2] as String,
      imageUrl: fields[3] as String,
      unitPrice: fields[6] as double,
      specialPrice: fields[5] as double,
      itemID: fields[1] as int,
      quantity: fields[4] as int,
      urlKey: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DbCartModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.keyId)
      ..writeByte(1)
      ..write(obj.itemID)
      ..writeByte(2)
      ..write(obj.itemName)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.quantity)
      ..writeByte(5)
      ..write(obj.specialPrice)
      ..writeByte(6)
      ..write(obj.unitPrice)
      ..writeByte(7)
      ..write(obj.urlKey);
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
