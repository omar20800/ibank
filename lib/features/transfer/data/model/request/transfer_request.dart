
class TransferRequest {
  String receiverEmail;
  bool usebalance;
  int amount;
  String? cardId;

  TransferRequest({
    required this.receiverEmail,
      required this.usebalance,
    required this.amount,
    this.cardId,
  });

  Map<String, dynamic> toJson() => {
        'receiverEmail': receiverEmail,
        'amount': amount,
        'usebalance': usebalance,
        'cardId': cardId,
      };
}