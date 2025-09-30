class Data {
  String? id;
  String? cardNumber;
  String? cardHolderName;
  double? balance;
  String? expiryDate;
  String? brand;

  Data({
    this.id,
    this.cardNumber,
    this.cardHolderName,
    this.expiryDate,
    this.balance,
    this.brand,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json['id'] as String?,
    cardNumber: json['cardNumber'] as String?,
    cardHolderName: json['cardHolderName'] as String?,
    balance: (json['balance'] as num?)?.toDouble(),
    expiryDate: json['expiryDate'] as String?,
    brand: json['brand'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'cardNumber': cardNumber,
    'cardHolderName': cardHolderName,
    'expiryDate': expiryDate,
    'balance': balance,
    'brand': brand,
  };
}
