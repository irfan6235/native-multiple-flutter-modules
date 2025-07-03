import 'package:flutter/material.dart';
import 'pages/product_page.dart';

void main() {
  runApp(const ShopEasyApp());
}

class ShopEasyApp extends StatelessWidget {
  const ShopEasyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JodeTx Payment SDK',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const ProductListPage(),
    );
  }
}
