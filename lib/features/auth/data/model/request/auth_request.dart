class AuthRequest {
  String? name;
  String email;
  String password;
  String? passwordConfirm;
  String? phoneNumber;
  String? imageUrl;
  int? age;
  
  AuthRequest({
    required this.email,
    required this.password,
    this.passwordConfirm,
    this.name,
    this.phoneNumber,
    this.imageUrl,
    this.age
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
    'passwordConfirm': passwordConfirm,
    'phoneNumber': phoneNumber,
    'imageUrl': imageUrl,
    'age': age
  };
  
}