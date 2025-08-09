import 'data.dart';

class CardResponse {
  bool? status;
  String? message;
  Data? data;

  CardResponse({this.status, this.message, this.data});

  factory CardResponse.fromJson(Map<String, dynamic> json) => CardResponse(
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
