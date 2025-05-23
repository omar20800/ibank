import 'package:hive/hive.dart';

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

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.imageUrl,
    this.phoneNumber,
    this.age,
    this.balance,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    imageUrl = json['imageUrl'];
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
    data['age'] = age;
    data['balance'] = balance;
    return data;
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? imageUrl,
    String? phoneNumber,
    int? age,
    double? balance,
  }) => UserModel(
    uid: uid ?? this.uid,
    name: name ?? this.name,
    email: email ?? this.email,
    imageUrl: imageUrl ?? this.imageUrl,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    age: age ?? this.age,
    balance: balance ?? this.balance,
  );
}
