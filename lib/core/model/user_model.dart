import 'package:hive/hive.dart';
import 'package:ibank/features/acc&cards/data/models/response/get_cards_response/datum.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  String? uid;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? imageUrl;
  @HiveField(4)
  String? phoneNumber;
  @HiveField(5)
  int? age;
  @HiveField(6)
  double? balance;
  @HiveField(7)
  Datum? defaultCard;
  DateTime? lastLogin;
  DateTime? createdAt;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.imageUrl,
    this.phoneNumber,
    this.defaultCard,
    this.age,
    this.balance,
    this.lastLogin,
    this.createdAt,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    imageUrl = json['imageUrl'];
    defaultCard = json['defaultCard'] != null
        ? Datum.fromJson(json['defaultCard'])
        : null;
    phoneNumber = json['phoneNumber'];
    age = json['age'];
    balance = json['balance'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['imageUrl'] = imageUrl;
    data['phoneNumber'] = phoneNumber;
    data['defaultCard'] = defaultCard?.toJson();
    data['age'] = age;
    data['balance'] = balance;
    data['lastLogin'] = lastLogin;
    data['createdAt'] = createdAt;
    return data;
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? imageUrl,
    Datum? defaultCard,
    String? phoneNumber,
    int? age,
    double? balance,
    DateTime? lastLogin,
    DateTime? createdAt,
  }) => UserModel(
    uid: uid ?? this.uid,
    name: name ?? this.name,
    email: email ?? this.email,
    imageUrl: imageUrl ?? this.imageUrl,
    defaultCard: defaultCard ?? this.defaultCard,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    age: age ?? this.age,
    balance: balance ?? this.balance,
    lastLogin: lastLogin ?? this.lastLogin,
    createdAt: createdAt ?? this.createdAt,
  );
}
