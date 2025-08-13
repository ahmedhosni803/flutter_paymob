import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_paymob/paymob_response.dart';

class PaymobIFrameInApp extends StatefulWidget {
  final String redirectURL;
  final Widget? title;
  final Color? appBarColor;
  final void Function(PaymentPaymobResponse)? onPayment;

  const PaymobIFrameInApp({
    Key? key,
    required this.redirectURL,
    this.onPayment,
    this.title,
    this.appBarColor,
  }) : super(key: key);

  static Future<PaymentPaymobResponse?> show({
    required BuildContext context,
    required String redirectURL,
    Widget? title,
    Color? appBarColor,
    void Function(PaymentPaymobResponse)? onPayment,
  }) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PaymobIFrameInApp(
            redirectURL: redirectURL,
            title: title,
            appBarColor: appBarColor,
            onPayment: onPayment,
          ),
        ),
      );

  @override
  _PaymobIFrameInAppState createState() => _PaymobIFrameInAppState();
}

class _PaymobIFrameInAppState extends State<PaymobIFrameInApp> {
  late InAppWebViewController webViewController;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: widget.title ?? const Text('Paymob Payment'),
          centerTitle: true,
          backgroundColor: widget.appBarColor),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.redirectURL)),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              useOnLoadResource: true,
              useHybridComposition: true,
              allowsInlineMediaPlayback: true,
              allowsLinkPreview: true
            ),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {
              if (kDebugMode) {
                print("Page started loading: $url");
              }
              setState(() => isLoading = true);
            },
            onLoadStop: (controller, url) {
              if (kDebugMode) {
                print("Page finished loading: $url");
              }
              setState(() => isLoading = false);

              if (url != null) {
                final urlString = url.toString();
                if (urlString.contains('txn_response_code') &&
                    urlString.contains('success') &&
                    urlString.contains('id')) {
                  final params = Uri.parse(urlString).queryParameters;
                  final response = PaymentPaymobResponse.fromJson(params);
                  if (kDebugMode) {
                    print(params);
                  }

                  if (widget.onPayment != null) {
                    widget.onPayment!(response);
                  }
                  // Navigator.pop(context, response);
                }
              }
            },
          ),
          if (isLoading)
            const Center(child: CircularProgressIndicator.adaptive()),
        ],
      ),
    );
  }
}
