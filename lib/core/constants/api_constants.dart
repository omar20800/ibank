class ApiConstants {
  static const String baseUrl = 'http://192.168.1.13:8000/';

  static const String authorizationHeader = 'Authorization';
  static const String bearerToken = 'Bearer ';

  static const String authroute = 'auth/';
  static const String cardsroute = 'cards/';
  static const String notificationsroute = 'notifications/';
  static const String transactionsroute = 'transactions/';

  static const String isTokenValid = 'is_token_valid';
  static const String login = 'login';
  static const String register = 'register';
  static const String logout = 'logout';
  static const String profile = 'profile';
  static const String verifyEmail = 'verify-email';
  static const String requestPasswordReset = 'request-password-reset';
  static const String confirmPasswordReset = 'confirm-password-reset';
  static const String resetpasswordotpverify = 'reset-password-otp-verify';
  static const String storeFcmToken = 'register-token';
  static const String addCard = 'add_card';
  static const String getCards = 'get_cards';
  static const String deleteCard = 'delete_card';
  static const String updateCard = 'update_card';
  static const String changeDefaultCard = 'change_default_card';
  static const String transferMoney = 'transfer-money';
}
