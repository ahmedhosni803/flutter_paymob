## Flutter Paymob
Flutter Paymob is a library that enables Flutter applications to accept payments through online cards and electronic wallets using the Paymob service.

## :rocket: Installation

Add this to `dependencies` in your app's `pubspec.yaml`

```yaml
flutter_paymob : latest_version
```


## ⭐: Initialization

In your main.dart file, make sure to configure the Flutter Paymob library properly:

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
> You can use this singleton (instance)
> or
> Create your own  
> if you want to create different iFrames or integrations
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
## :bookmark: Usage
 
## Payment with Card

```dart
  FlutterPaymob.instance.payWithCard(
    context: context,
    currency: "EGP",
    amount: 100 ,// EGP
    // optional
    onPayment: (response) { 
    response.success == true
    ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(response.message ?? "Successes")))
    : null;
)
```


## Payment with Wallet

```dart
  FlutterPaymob.instance.payWithWallet(
    context: context,
    currency: "EGP",
    amount: 100 ,// EGP
    number: "01010101010", // wallet number
    // optional
    onPayment: (response) { 
    response.success == true
    ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(response.message ?? "Successes")))
    : null;
)
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
