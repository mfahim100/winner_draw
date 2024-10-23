class ModelBank {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;

  ModelBank(
      {required this.cardNumber,
      required this.expiryDate,
      required this.cardHolderName,
      required this.cvvCode});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};


    data['cardNumber'] = cardNumber;
    data['expiryDate'] = expiryDate;
    data['cardHolderName'] = cardHolderName;
    data['cvvCode'] = cvvCode;

    return data;
  }
}
