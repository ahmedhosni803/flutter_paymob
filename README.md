
Easily accept payments through Online Cards and Wallet in your app with Paymob.

## :rocket: Installation

Add this to `dependencies` in your app's `pubspec.yaml`

```yaml
flutter_paymob : latest_version
```


## : Initialization

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
 
## Usage Card 

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


## Usage wallet

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



