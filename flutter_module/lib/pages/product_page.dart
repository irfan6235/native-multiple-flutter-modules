import 'package:flutter/material.dart';
import '../models/product.dart';
import 'cart_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<Product> _cartItems = [];

  void _addToCart(Product product) {
    setState(() {
      _cartItems.add(product);
    });
  }

  void _goToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CartPage(cartItems: _cartItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Easy - Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: _goToCart,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: dummyProducts.length,
        itemBuilder: (ctx, index) {
          final product = dummyProducts[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ListTile(
              leading:
                  Image.network(product.imageUrl, width: 60, fit: BoxFit.cover),
              title: Text(product.name),
              subtitle: Text('₹${product.price.toStringAsFixed(2)}'),
              trailing: ElevatedButton(
                child: const Text('Add to Cart'),
                onPressed: () => _addToCart(product),
              ),
            ),
          );
        },
      ),
    );
  }
}
