library flutter_paymob;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_paymob/paymob_billing_data.dart';
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

  // Initialize Paymob instance.
  Future<bool> initialize({
    required String apiKey,
    int? integrationID,
    int? walletIntegrationId,
    required int iFrameID,
    int userTokenExpiration = 3600,
  }) async {
    if (_isInitialized) {
      return true;
    }
    _authKey = apiKey;
    _integrationId = integrationID!;
    _walletIntegrationId = walletIntegrationId!;
    _iFrameID = iFrameID;
    _iFrameURL =
        'https://accept.paymobsolutions.com/api/acceptance/iframes/$_iFrameID?payment_token=';
    _isInitialized = true;
    _userTokenExpiration = userTokenExpiration;
    return _isInitialized;
  }

  var headers = {'Content-Type': 'application/json'};

  // Get API Key from the server.
  Future<String> _getApiKey() async {
    Map<String, dynamic> requestBody = {"api_key": _authKey};
    String requestBodyJson = jsonEncode(requestBody);
    http.Response response = await http.post(
      Uri.parse(Constants.authorization),
      body: requestBodyJson,
      headers: headers,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      _authToken = jsonDecode(response.body)["token"];
      return _authToken;
    } else {
      throw "Error";
    }
  }

  // Get Order ID from the server.
  Future<int> _getOrderId(double amount, String currency) async {
    Map<String, dynamic> requestBody = {
      "auth_token": _authToken,
      "delivery_needed": "false",
      "amount_cents": "${amount * 100}",
      "currency": currency,
      "items": []
    };
    String requestBodyJson = jsonEncode(requestBody);
    http.Response response = await http.post(Uri.parse(Constants.order),
        body: requestBodyJson, headers: headers);
    if (response.statusCode >= 200) {
      _orderId = jsonDecode(response.body)["id"];
      return _orderId;
    } else {
      throw "Error";
    }
  }

  // Request a payment token.
  Future<String> _requestToken({
    required double amount,
    required String currency,
    required String integrationId,
    required PaymobBillingData billingData,
  }) async {
    Map<String, dynamic> requestBody = {
      "auth_token": _authToken,
      "expiration": _userTokenExpiration,
      "amount_cents": "${amount * 100}",
      "order_id": _orderId,
      "billing_data": billingData
          .toJson(), // Assuming toJson() is implemented in PaymobBillingData
      "currency": currency,
      "integration_id": integrationId,
      "lock_order_when_paid": "false"
    };
    String requestBodyJson = jsonEncode(requestBody);
    http.Response response = await http.post(Uri.parse(Constants.keys),
        body: requestBodyJson, headers: headers);
    if (response.statusCode >= 200) {
      _paymentKey = jsonDecode(response.body)["token"];
      return _paymentKey;
    } else {
      throw "Error";
    }
  }

  Future<String> _requestUrlWallet({
    required String number,
  }) async {
    Map<String, dynamic> requestBody = {
      "source": {"identifier": number, "subtype": "WALLET"},
      "payment_token": _paymentKey // token obtained in step 3
    };
    String requestBodyJson = jsonEncode(requestBody);
    http.Response response = await http.post(Uri.parse(Constants.wallet),
        body: requestBodyJson, headers: headers);
    if (response.statusCode >= 200) {
      _walletURL = jsonDecode(response.body)["redirect_url"];
      return _walletURL;
    } else {
      throw "Error";
    }
  }

  // Initiate payment with a card.
  Future payWithCard({
    required BuildContext context,
    required String currency,
    required double amount,
    void Function(PaymobResponse response)? onPayment,
    List? items,
    PaymobBillingData? billingData,
  }) async {
    await _getApiKey();
    await _getOrderId(amount, currency);
    await _requestToken(
        integrationId: _integrationId.toString(),
        amount: amount,
        currency: currency,
        billingData: billingData ?? PaymobBillingData());
    if (context.mounted) {
      final response = await PaymobIFrame.show(
        context: context,
        redirectURL: "$_iFrameURL$_paymentKey",
        onPayment: onPayment,
      );
      return response;
    }
    return null;
  }

  Future payWithWallet({
    required BuildContext context,
    required String currency,
    required String number,
    required double amount,
    void Function(PaymobResponse response)? onPayment,
    List? items,
    PaymobBillingData? billingData,
  }) async {
    await _getApiKey();
    await _getOrderId(amount, currency);
    await _requestToken(
        integrationId: _walletIntegrationId.toString(),
        amount: amount,
        currency: currency,
        billingData: billingData ?? PaymobBillingData());
    await _requestUrlWallet(number: number);
    if (context.mounted) {
      final response = await PaymobIFrame.show(
        context: context,
        redirectURL: _walletURL,
        onPayment: onPayment,
      );
      return response;
    }
    return null;
  }
}
