// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_book_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StockBookModelAdapter extends TypeAdapter<StockBookModel> {
  @override
  final int typeId = 1;

  @override
  StockBookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StockBookModel(
      id: fields[0] as int,
      bookName: fields[1] as String,
      creationDate: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, StockBookModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.bookName)
      ..writeByte(2)
      ..write(obj.creationDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockBookModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
