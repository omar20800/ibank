import 'data.dart';

class AuthResponse {
  bool? status;
  String? message;
  Data? data;

  AuthResponse({this.status, this.message, this.data});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    status: json['status'] as bool?,
    message: json['message'] as String?,
    data:
        json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}
