class Constants {
  static const String acceptBaseUrl = "https://accept.paymob.com/api";

  final String authorization;
  final String order;
  final String keys;
  final String wallet;

  Constants({
    required this.authorization,
    required this.order,
    required this.keys,
    required this.wallet,
  });

  factory Constants.production() {
    return Constants(
      authorization: "$acceptBaseUrl/auth/tokens",
      order: "$acceptBaseUrl/ecommerce/orders",
      keys: "$acceptBaseUrl/acceptance/payment_keys",
      wallet: "$acceptBaseUrl/acceptance/payments/pay",
    );
  }

  factory Constants.staging() {
    // Define staging URLs here
    return Constants(
      authorization: "$acceptBaseUrl/auth/tokens",
      order: "$acceptBaseUrl/ecommerce/orders",
      keys: "$acceptBaseUrl/acceptance/payment_keys",
      wallet: "$acceptBaseUrl/acceptance/payments/pay",
    );
  }

  factory Constants.custom({
    required String authorization,
    required String order,
    required String keys,
    required String wallet,
  }) {
    return Constants(
      authorization: authorization,
      order: order,
      keys: keys,
      wallet: wallet,
    );
  }
}
