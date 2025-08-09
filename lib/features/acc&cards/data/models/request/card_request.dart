class CardRequest {
  String? cardNumber;
  String? cardHolderName;
  String? expiryDate;
  String? cvv;
  String? brand;

  CardRequest({
    this.cardNumber,
    this.cardHolderName,
    this.expiryDate,
    this.cvv,
    this.brand,
  });

  Map<String, dynamic> toJson() => {
    'cardNumber': cardNumber,
    'cardHolderName': cardHolderName,
    'expiryDate': expiryDate,
    'cvv': cvv,
    'brand': brand ?? detectBrand(cardNumber ?? ''),
  };

  String detectBrand(String cardNumber) {
  if (cardNumber.startsWith('4')) return 'Visa';
  if (cardNumber.startsWith('5')) return 'MasterCard';
  if (cardNumber.startsWith('3')) return 'American Express';
  return 'Unknown';
}

}
