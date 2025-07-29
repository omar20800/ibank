class Datum {
	String? id;
	String? cardNumber;
	String? cardHolderName;
	String? expiryDate;
	String? brand;
	String? userId;

	Datum({
		this.id, 
		this.cardNumber, 
		this.cardHolderName, 
		this.expiryDate, 
		this.brand, 
		this.userId, 
	});

	factory Datum.fromJson(Map<String, dynamic> json) => Datum(
				id: json['id'] as String?,
				cardNumber: json['cardNumber'] as String?,
				cardHolderName: json['cardHolderName'] as String?,
				expiryDate: json['expiryDate'] as String?,
				brand: json['brand'] as String?,
				userId: json['userId'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'cardNumber': cardNumber,
				'cardHolderName': cardHolderName,
				'expiryDate': expiryDate,
				'brand': brand,
				'userId': userId,
			};
}
