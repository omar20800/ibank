import 'package:hive/hive.dart';

part 'datum.g.dart';

@HiveType(typeId: 2)
class Datum {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? cardNumber;
  @HiveField(2)
  String? cardHolderName;
  @HiveField(3)
  String? expiryDate;
  @HiveField(4)
  String? brand;
  @HiveField(5)
  String? userId;

  Datum({
    this.id,
    this.cardNumber,
    this.cardHolderName,
    this.expiryDate,
    this.brand,
    this.userId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json['id'] as String?,
    cardNumber: json['cardNumber'] as String?,
    cardHolderName: json['cardHolderName'] as String?,
    expiryDate: json['expiryDate'] as String?,
    brand: json['brand'] as String?,
    userId: json['userId'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'cardNumber': cardNumber,
    'cardHolderName': cardHolderName,
    'expiryDate': expiryDate,
    'brand': brand,
    'userId': userId,
  };
}
