import 'package:ibank/features/transfer/data/model/response/transfer_data.dart';

class TransferResponse {
  bool status;
  String message;
  TransferData data;

  TransferResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TransferResponse.fromJson(Map<String, dynamic> json) {
    return TransferResponse(
      status: json['status'],
      message: json['message'],
      data: TransferData.fromJson(json['data']),
    );
  }
}