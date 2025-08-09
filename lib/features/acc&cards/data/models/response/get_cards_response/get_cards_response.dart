import 'datum.dart';

class GetCardsResponse {
  bool? status;
  String? message;
  List<Datum>? data;

  GetCardsResponse({this.status, this.message, this.data});

  factory GetCardsResponse.fromJson(Map<String, dynamic> json) {
    return GetCardsResponse(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}
