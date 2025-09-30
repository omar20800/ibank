class StoreFcmResponse {
  bool status;
  String message;
  StoreFcmResponse({
    required this.status,
    required this.message,
  });
  factory StoreFcmResponse.fromJson(Map<String, dynamic> json) {
    return StoreFcmResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}
