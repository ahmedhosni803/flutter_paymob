class PaymentPaymobResponse {
  bool success;
  String? transactionID;
  String? responseCode;
  String? message;

  PaymentPaymobResponse({
    required this.success,
    this.transactionID,
    this.responseCode,
    this.message,
  });

  factory PaymentPaymobResponse.fromJson(Map<String, dynamic> json) {
    return PaymentPaymobResponse(
      success: json['success'] == true,
      transactionID: json['id'],
      message: json['message'],
      responseCode: json['txn_response_code'],
    );
  }
}
