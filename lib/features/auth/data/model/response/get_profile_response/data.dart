import 'package:ibank/features/acc&cards/data/models/response/get_cards_response/datum.dart';

class Data {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? imageUrl;
  Datum? defaultCard;
  int? age;
  double? balance;
  DateTime? lastLogin;
  DateTime? createdAt;
  String? token;

  Data({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.imageUrl,
    this.age,
    this.defaultCard,
    this.balance,
    this.lastLogin,
    this.createdAt,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json['_id'] as String?,
    name: json['name'] as String?,
    email: json['email'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    imageUrl: json['imageUrl'] as String?,
    age: json['age'] as int?,
    defaultCard: json['default_card'] == null ? null : Datum.fromJson(json['default_card']),
    balance: json['balance'] as double?,
    lastLogin:
        json['lastLogin'] == null
            ? null
            : DateTime.parse(json['lastLogin'] as String),
    createdAt:
        json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
    token: json['token'] as String?,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'email': email,
    'phoneNumber': phoneNumber,
    'imageUrl': imageUrl,
    'default_card': defaultCard?.toJson(),
    'age': age,
    'balance': balance,
    'lastLogin': lastLogin?.toIso8601String(),
    'createdAt': createdAt?.toIso8601String(),
    'token': token,
  };
}
