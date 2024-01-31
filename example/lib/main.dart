import 'package:flutter/material.dart';
import 'package:flutter_paymob/flutter_paymob.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterPaymob.instance.initialize(
      apiKey: "auth key",
      integrationID: 123456,
      walletIntegrationId: 123456,
      iFrameID: 123456);
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
