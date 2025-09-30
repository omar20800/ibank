class TransferData {
  String transactionId;

  TransferData({required this.transactionId});
  factory TransferData.fromJson(Map<String, dynamic> json) {
    return TransferData(
      transactionId: json['transactionId'],
    );
  }
}