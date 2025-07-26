class AuthResponse {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? imageUrl;
  int? age;
  double? balance;
  DateTime? lastLogin;
  DateTime? createdAt;
  String? token;
  String? message;

  AuthResponse({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.imageUrl,
    this.age,
    this.balance,
    this.lastLogin,
    this.createdAt,
    this.token,
    this.message,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    id: json['_id'] as String?,
    name: json['name'] as String?,
    email: json['email'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    imageUrl: json['imageUrl'] as String?,
    age: json['age'] as int?,
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
    message: json['message'] as String?,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'email': email,
    'phoneNumber': phoneNumber,
    'imageUrl': imageUrl,
    'age': age,
    'balance': balance,
    'lastLogin': lastLogin?.toIso8601String(),
    'createdAt': createdAt?.toIso8601String(),
    'token': token,
  };
}
