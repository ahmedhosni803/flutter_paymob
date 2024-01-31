## Flutter Paymob
#### Flutter Paymob is a library that allows Flutter applications to accept online card and e-wallet payments through the Paymob service.

### Inspired by [Ahmed Abogameel](https://www.linkedin.com/in/jimmy2622000)!

## :rocket: Installation

Add this to `dependencies` in your app's `pubspec.yaml`

```yaml
flutter_paymob : latest_version
```


## ⭐: Initialization
### To initialize the FlutterPaymob instance, you can use the initialize method. Here's how you can initialize it:
In the main.dart file, make sure the Flutter Paymob library is configured correctly:

```dart
  void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ...
  FlutterPaymob.instance.initialize(
      apiKey:
      "auth key", //  // from dashboard Select Settings -> Account Info -> API Key 
      integrationID: 123456 , // // from dashboard Select Developers -> Payment Integrations -> Online Card ID 
      walletIntegrationId: 123456, // // from dashboard Select Developers -> Payment Integrations -> Online wallet
      iFrameID: 12346); // from paymob Select Developers -> iframes 
  ...
  runApp(const MyApp());
}
```

> :pushpin: Note :
>
> You can use (instance).
> or
> If you want to create a different iframe or integration
> Alternatively, you can create your own instance:

```dart
final FlutterPaymob flutterPaymob = FlutterPaymob();
  flutterPaymob.initialize(
    apiKey:"auth key",   // from dashboard Select Settings -> Account Info -> API Key 
    integrationID: 123456 , // optional => from dashboard Select Developers -> Payment Integrations -> Online Card ID 
    walletIntegrationId: 123456, // optional => from dashboard Select Developers -> Payment Integrations -> Online wallet
    iFrameID: 12346); // from paymob Select Developers -> iframes 
);
```
## :💡: Usage
### To use the FlutterPaymob instance after it has been initialized, you can make payment attempts using either a card or a wallet. Here's how you can use it:
 

## 💳 Payment with Card
### To initiate a payment with a card using the FlutterPaymob instance, you can use the payWithCard method. Here's how you can use it:

```dart
// Initiates a payment with a card using the FlutterPaymob instance
  FlutterPaymob.instance.payWithCard(
    context: context, // Passes the BuildContext required for UI interactions
    currency: "EGP", // Specifies the currency for the transaction (Egyptian Pound)
    amount: 100, // Sets the amount of money to be paid (100 EGP)
    // Optional callback function invoked when the payment process is completed
    onPayment: (response) {
    // Checks if the payment was successful
    if (response.success == true) {
    // If successful, displays a snackbar with the success message
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(response.message ??
      "Success"), // Shows "Success" message or response message
        ),
    );}
    },
  );

```


## 📲 Payment with Wallet
### To initiate a payment with a wallet using the FlutterPaymob instance, you can use the payWithWallet method. Here's how you can use it:

```dart
// Initiates a payment with a wallet using the FlutterPaymob instance
    FlutterPaymob.instance.payWithWallet(
       context: context, // Passes the BuildContext required for UI interactions
       currency: "EGP", // Specifies the currency for the transaction (Egyptian Pound)
       amount: 100, // Sets the amount of money to be paid (100 EGP)
       number: "01010101010", // Specifies the wallet number
       // Optional callback function invoked when the payment process is completed
       onPayment: (response) {
       // Checks if the payment was successful
       if (response.success == true) {
       // If successful, displays a snackbar with the success message
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message ?? "Success"), // Shows "Success" message or response message
         ),
    );}
    },
  );

```

## :incoming_envelope: PaymobResponse

| Variable      | Type    | Description          |
| ------------- |---------| -------------------- |
| success       | bool    | Indicates if the transaction was successful or not |
| transactionID | String? | The ID of the transaction |
| responseCode  | String? | The response code for the transaction |
| message       | String? | A brief message describing the transaction |


## Test
Use the following card test data to perform a test transaction with your test integration ID:

#### MasterCard

| Variable     | Description      |
|--------------|------------------|
| Card Number  | 5123456789012346 |
| Expiry Month | 12               |
| Expiry Year  | 25               |
| CVV          | 123              |

👍
That's it, you've successfully finalized your Card payments integration with Accept :tada:.
Now, prepare endpoints to receive payment notifications from Accept's server, to learn more about the transactions webhooks

#### Wallet

| Mobile Number | PIN    | OTP    |
|---------------|--------|--------|
| 01010101010   | 123456 | 123456 |


👍
That's it, you've successfully finalized your Mobile Wallets Payments integration with Accept :tada:.
Now, prepare endpoints to receive payment notifications from Accept's server, to learn more about the transactions webhooks

### To Contact with me  [Ahmed Hosni](https://www.linkedin.com/in/ahmed-hosni-705814240)