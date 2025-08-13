library flutter_paymob;

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_paymob/billing_data.dart';
import 'package:flutter_paymob/paymob_iframe.dart';
import 'package:flutter_paymob/paymob_response.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

class FlutterPaymob {
  late String _authKey;
  late String _authToken;
  late String _paymentKey;
  late String _iFrameURL;
  late String _walletURL;
  late int _iFrameID;
  late int _integrationId;
  late int _walletIntegrationId;
  late int _orderId;
  late int _userTokenExpiration;
  bool _isInitialized = false;

  static FlutterPaymob instance = FlutterPaymob();
  Constants constants = Constants.production();

  Future<bool> initialize({
    required String apiKey,
    int? integrationID,
    int? walletIntegrationId,
    required int iFrameID,
    int userTokenExpiration = 3600,
  }) async {
    if (_isInitialized) return true;

    _authKey = apiKey;
    _integrationId = integrationID!;
    _walletIntegrationId = walletIntegrationId!;
    _iFrameID = iFrameID;
    _iFrameURL =
        'https://accept.paymob.com/api/acceptance/iframes/$_iFrameID?payment_token=';
    _isInitialized = true;
    _userTokenExpiration = userTokenExpiration;
    return _isInitialized;
  }

  var headers = {'Content-Type': 'application/json'};

  Future<String> _getApiKey() async {
    Map<String, dynamic> requestBody = {"api_key": _authKey};
    http.Response response = await http.post(
      Uri.parse(constants.authorization),
      body: jsonEncode(requestBody),
      headers: headers,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      _authToken = jsonDecode(response.body)["token"];
      return _authToken;
    } else {
      throw "Error getting API key";
    }
  }

  Future<int> _getOrderId(double amount, String currency) async {
    Map<String, dynamic> requestBody = {
      "auth_token": _authToken,
      "delivery_needed": false,
      "amount_cents": ((amount * 100).round()).toString(),
      "currency": currency,
      "items": []
    };
    http.Response response = await http.post(
      Uri.parse(constants.order),
      body: jsonEncode(requestBody),
      headers: headers,
    );

    if (response.statusCode >= 200) {
      _orderId = jsonDecode(response.body)["id"];
      return _orderId;
    } else {
      throw "Error creating order";
    }
  }

  Future<String> _requestToken({
    required double amount,
    required String currency,
    required String integrationId,
    required BillingData billingData,
  }) async {
    Map<String, dynamic> requestBody = {
      "auth_token": _authToken,
      "expiration": _userTokenExpiration,
      "amount_cents": ((amount * 100).round()).toString(),
      "order_id": _orderId,
      "billing_data": billingData.toJson(),
      "currency": currency,
      "integration_id": integrationId,
      "lock_order_when_paid": false
    };
    http.Response response = await http.post(
      Uri.parse(constants.keys),
      body: jsonEncode(requestBody),
      headers: headers,
    );

    if (response.statusCode >= 200) {
      _paymentKey = jsonDecode(response.body)["token"];
      return _paymentKey;
    } else {
      throw "Error getting payment token";
    }
  }

  Future<String> _requestUrlWallet({
    required String number,
  }) async {
    Map<String, dynamic> requestBody = {
      "source": {"identifier": number, "subtype": "WALLET"},
      "payment_token": _paymentKey
    };
    http.Response response = await http.post(
      Uri.parse(constants.wallet),
      body: jsonEncode(requestBody),
      headers: headers,
    );

    if (response.statusCode >= 200) {
      final body = jsonDecode(response.body);
      _walletURL = body["redirect_url"] == null || body["redirect_url"].isEmpty
          ? body["iframe_redirection_url"]
          : body["redirect_url"];
      return _walletURL;
    } else {
      throw "Error getting wallet URL";
    }
  }

  Future payWithCard({
    required BuildContext context,
    required String currency,
    required double amount,
    Widget? title,
    Color? appBarColor,
    void Function(PaymentPaymobResponse response)? onPayment,
    BillingData? billingData,
  }) async {
    await _getApiKey();
    await _getOrderId(amount, currency);
    await _requestToken(
      integrationId: _integrationId.toString(),
      amount: amount,
      currency: currency,
      billingData: billingData ?? BillingData(),
    );
    if (context.mounted) {
      return await PaymobIFrameInApp.show(
        title: title,
        appBarColor: appBarColor,
        context: context,
        redirectURL: "$_iFrameURL$_paymentKey",
        onPayment: (p0) {
          // Navigator.pop(context);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onPayment!(p0);
          });
        },
      );
    }
    return null;
  }

  Future payWithWallet({
    required BuildContext context,
    required String currency,
    required String number,
    required double amount,
    Widget? title,
    Color? appBarColor,
    void Function(PaymentPaymobResponse response)? onPayment,
    BillingData? billingData,
  }) async {
    await _getApiKey();
    await _getOrderId(amount, currency);
    await _requestToken(
      integrationId: _walletIntegrationId.toString(),
      amount: amount,
      currency: currency,
      billingData: billingData ?? BillingData(),
    );
    await _requestUrlWallet(number: number);
    if (context.mounted) {
      return await PaymobIFrameInApp.show(
        title: title,
        appBarColor: appBarColor,
        context: context,
        redirectURL: _walletURL,
        onPayment: (p0) {
          // Navigator.pop(context);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onPayment!(p0);
          });
        },
      );
    }
    return null;
  }
}
