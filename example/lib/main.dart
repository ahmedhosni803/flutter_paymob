import 'package:flutter/material.dart';
import 'package:flutter_paymob_payment/flutter_paymob_payment.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterPaymob.instance.initialize(
      apiKey:
          "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T1RVeE5UY3lMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuV0VmSVJaMmZZQV9SZmJMU2ZpcERNNno2WFpTcjBlYlFvejdzaGJGQWFEa21BTUlQdm42VWdVclFKb0pfTVQ5RlpFS3h1TmxNU2lKQVQ2Y3NCNVhLZHc=",
      integrationID: 4432489,
      walletIntegrationId: 4432492,
      iFrameID: 814230);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Paymob'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  FlutterPaymob.instance.payWithCard(
                    context: context,
                    currency: "EGP",
                    amount: 100,
                    onPayment: (response) {
                      response.success == true
                          ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(response.message ?? "Successes")))
                          : null;
                    },
                  );
                },
                child: const Text("Pay with card")),
            ElevatedButton(
                onPressed: () {
                  FlutterPaymob.instance.payWithWallet(
                    context: context,
                    currency: "EGP",
                    amount: 100,
                    number: "01010101010",
                    onPayment: (response) {
                      response.success == true
                          ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(response.message ?? "Successes")))
                          : null;
                    },
                  );
                },
                child: const Text("Pay With Wallet")),
          ],
        ),
      ),
    );
  }
}
