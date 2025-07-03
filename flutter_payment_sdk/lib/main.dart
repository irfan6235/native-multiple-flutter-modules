import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const PaymentApp());
}

class PaymentApp extends StatelessWidget {
  const PaymentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaymentPage(),
    );
  }
}

class PaymentPage extends StatelessWidget {
  static const channel = MethodChannel("jodetx/payment");

  void sendResult(bool success) async {
    try {
      await channel.invokeMethod("paymentResult", {
        "status": success ? "Success" : "Failed",
        "amount": 799.0,
      });
      SystemNavigator.pop();
    } catch (e) {
      debugPrint("Failed to send result: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => sendResult(true),
              child: const Text("Confirm Payment"),
            ),
            ElevatedButton(
              onPressed: () => sendResult(false),
              child: const Text("Fail Payment"),
            ),
          ],
        ),
      ),
    );
  }
}
