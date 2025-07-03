import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/product.dart';

class CartPage extends StatelessWidget {
  final List<Product> cartItems;

  const CartPage({super.key, required this.cartItems});

  double get totalAmount => cartItems.fold(0, (sum, item) => sum + item.price);
  static const platform = MethodChannel('jodetx/payment');
  void _startPayment(BuildContext context, {required bool success}) async {
    String status = success ? "Success" : "Failed";

    try {
      await platform.invokeMethod('paymentResult', {
        'status': status,
        'amount': totalAmount,
      });
      await platform.invokeMethod('closeFlutter');
    } catch (e) {
      debugPrint('Failed to send result: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (ctx, index) {
                final product = cartItems[index];
                return ListTile(
                  leading: Image.network(product.imageUrl, width: 50),
                  title: Text(product.name),
                  subtitle: Text('₹${product.price}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text('Total: ₹${totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _startPayment(context, success: true),
                  child: const Text("Confirm to pay"),
                ),
                ElevatedButton(
                  onPressed: () => _startPayment(context, success: false),
                  child: const Text("Failed to pay"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
