class VerifyEmailRequest {
  final String email;
  final String otp;

  VerifyEmailRequest({required this.email, required this.otp});

  Map<String, dynamic> toJson() {
    return {"email": email, "otp": otp};
  }

}