class AuthLoginRequest {
  String? email;
  String? phonenumber;
  String password;

  AuthLoginRequest({this.email, this.phonenumber, required this.password});

  Map<String, dynamic> toJson() => {
        'identifier' : email ?? phonenumber,
        'password': password
  };
}
