class CardModel {
  String? id;
  String cardnumber;
  String cardholdername;
  String expirationdate;
  String type;
  double balance;
  String cvv;

  CardModel({
    required this.cvv,
    this.id,
    required this.cardnumber,
    required this.cardholdername,
    required this.expirationdate,
    this.balance = 0.0,
    this.type = '',
  }) {
    type = getcardtype(cardnumber)!;
  }

  String? getcardtype(String cardnumber) {
    if (cardnumber.startsWith('4')) {
      return 'visa';
    } else if (cardnumber.startsWith('5') || cardnumber.startsWith('2')) {
      return 'mastercard';
    } else if (cardnumber.startsWith('3')) {
      return 'american express';
    } else if (cardnumber.startsWith('6')) {
      return 'discover';
    } else {
      return "unknown";
    }
  }
}
