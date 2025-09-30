// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DatumAdapter extends TypeAdapter<Datum> {
  @override
  final int typeId = 2;

  @override
  Datum read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Datum(
      id: fields[0] as String?,
      cardNumber: fields[1] as String?,
      cardHolderName: fields[2] as String?,
      expiryDate: fields[3] as String?,
      brand: fields[4] as String?,
      userId: fields[5] as String?,
      balance: fields[6] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Datum obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.cardNumber)
      ..writeByte(2)
      ..write(obj.cardHolderName)
      ..writeByte(3)
      ..write(obj.expiryDate)
      ..writeByte(4)
      ..write(obj.brand)
      ..writeByte(5)
      ..write(obj.userId)
      ..writeByte(6)
      ..write(obj.balance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
