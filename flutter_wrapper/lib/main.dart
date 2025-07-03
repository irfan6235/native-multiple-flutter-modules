import 'package:flutter/material.dart';
import 'package:flutter_module/main.dart' as shop;
import 'package:flutter_payment_sdk/main.dart' as payment;

/// Dummy main
void main() {}

@pragma('vm:entry-point')
void shopMain() {
  runApp(const shop.ShopEasyApp());
}

@pragma('vm:entry-point')
void paymentMain() {
  runApp(const payment.PaymentApp());
}
