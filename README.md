
---

# 🚀 Flutter Paymob — Accept Payments with Zero Hassle

> **Integrate Paymob card & wallet payments inside your Flutter app with ease.**
> Secure, fast, and ready for production.

---

## 📥 Installation

Just add to your `pubspec.yaml`:

```yaml
flutter_paymob: ^latest_version
```

---

## 🔧 Setup & Initialization

Before your app runs, initialize:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterPaymob.instance.initialize(
    apiKey: "YOUR_PAYMOB_API_KEY",
    integrationID: 123456,         // Card integration ID
    walletIntegrationId: 654321,   // Wallet integration ID
    iFrameID: 789012,              // Paymob iframe ID
  );

  runApp(const MyApp());
}
```

---

## ⚡ Quick Usage Guide

### Pay with Card 💳

```dart
await FlutterPaymob.instance.payWithCard(
  title: Text("Card Payment"), // Optional - Custom title AppBar
  appBarColor: Colors.blueAccent, // Optional - Custom AppBar color
  context: context,
  currency: "EGP", 
  amount: 150, 
  onPayment: (response) {
    if (response.success) {
      print("🎉 Payment Success! TxID: ${response.transactionID}");
    } else {
      print("❌ Payment Failed: ${response.message}");
    }
  },
);
```

### Pay with Wallet 📱

```dart
await FlutterPaymob.instance.payWithWallet(
title: Text("Card Payment"), // Optional - Custom title AppBar
appBarColor: Colors.blueAccent, // Optional - Custom AppBar color
  context: context,
  currency: "EGP",
  amount: 150,
  number: "01010101010",
  onPayment: (response) {
    if (response.success) {
      print("🎉 Wallet Payment Successful");
    } else {
      print("❌ Wallet Payment Failed");
    }
  },
);
```

---

## 💡 Response Object Breakdown

| Field         | Type    | Meaning                           |
| ------------- | ------- | --------------------------------- |
| success       | bool    | Was the payment successful?       |
| transactionID | String? | Unique ID for the transaction     |
| responseCode  | String? | Numeric response from Paymob API  |
| message       | String? | Description / message from Paymob |

---

## 🧪 Test Credentials

| Type   | Number / PIN        | Expiry | CVV | OTP    |
| ------ | ------------------- | ------ | --- | ------ |
| Card   | 5123 4567 8901 2346 | 12/25  | 123 | -      |
| Wallet | 01010101010         | -      | -   | 123456 |

---

## 🚨 Important Notes

* **Webhook integration is a must!** Always verify transactions on your backend with Paymob webhooks to prevent fraud.
* Customize UI elements (`title`, `appBarColor`) to match your brand.
* Use **sandbox keys** during development to avoid live charges.
* **Error Handling:** Always wrap payment calls with try-catch to gracefully handle network or API failures.
* **Logging:** Log transaction attempts and responses for debugging and auditing.
* **Localization:** You can customize strings/messages in your app UI to support multiple languages.
* **Security:** Never expose your API keys or sensitive info in the client code; keep them safe on the server when possible.

---

## 🔄 Handling Payment States

The `onPayment` callback triggers on **success, failure, or cancellation**.
Use the `response.success` boolean and `response.message` to determine the payment state and update your UI accordingly.

---

## 🛠️ Troubleshooting

* **Blank iframe or webview?**

  * Check your internet connection.
  * Make sure your iFrame ID and payment tokens are valid and not expired.
  * Verify your Paymob account and integration settings.

* **PlatformException about view creation?**

  * Make sure you are using the latest `webview_flutter` package compatible with your Flutter version.
  * Avoid creating multiple instances of the webview controller simultaneously.

* **Payment not completing or stuck?**

  * Confirm your API credentials and integration IDs.
  * Enable verbose logging if available to inspect requests and responses.

---

## 🔗 Useful Links

* [Paymob API Docs](https://accept.paymob.com/api)

---

## 📞 Contact

Need help or want to customize? Reach out to me:
[Ahmed Hosni - LinkedIn](https://www.linkedin.com/in/ahmed-hosni-705814240)

---

# Happy coding & smooth payments! 🎉

---
