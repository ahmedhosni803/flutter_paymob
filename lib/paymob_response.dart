class PaymentPaymobResponse {
  bool success;
  String? transactionID;
  String? responseCode;
  String? message;
  int? amountCents;
  String? dataMessage;

  PaymentPaymobResponse(
      {required this.success,
      this.transactionID,
      this.responseCode,
      this.amountCents,
      this.message,
      this.dataMessage});

  factory PaymentPaymobResponse.fromJson(Map<String, dynamic> json) {
    return PaymentPaymobResponse(
      success: json['success'].toString() == "true",
      transactionID: json['id'],
      message: json['message'] ?? json['data.message'] != null
          ? Uri.decodeComponent(json['data.message']!)
          : '',
      responseCode: json['txn_response_code'],
      amountCents: int.tryParse(json['amount_cents'] ?? '0') ?? 0,
      dataMessage: json['data.message'] != null
          ? Uri.decodeComponent(json['data.message']!)
          : '',
    );
  }
}
