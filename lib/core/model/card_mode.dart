class CardModel {
  String cardnumber;
  String cardholdername;
  String expirationdate;
  String? type;

  CardModel({
    required this.cardnumber,
    required this.cardholdername,
    required this.expirationdate,
    this.type,
  }) {
    type = getcardtype(cardnumber);
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
      return null;
    }
  }
}
