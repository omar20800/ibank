class StoreFcmTokenRequest {
  final String fcmToken;

  StoreFcmTokenRequest({required this.fcmToken});

  Map<String, dynamic> toJson() {
    return {"fcmToken": fcmToken};
  }
}
