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
				'brand': brand,
			};
}
