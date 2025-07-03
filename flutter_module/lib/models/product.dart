class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl});
}

final List<Product> dummyProducts = [
  Product(
    id: 'p1',
    name: 'Wireless Headphones',
    price: 899.0,
    imageUrl: 'https://m.media-amazon.com/images/I/71zfpkr4bYL._AC_UY218_.jpg',
  ),
  Product(
    id: 'p2',
    name: 'Smart Watch',
    price: 1799.0,
    imageUrl: 'https://m.media-amazon.com/images/I/61rmkmqD5VL._AC_UY218_.jpg',
  ),
  Product(
    id: 'p3',
    name: 'Fitness Tracker',
    price: 599.0,
    imageUrl: 'https://m.media-amazon.com/images/I/71St5sqS6CL._AC_UY218_.jpg',
  ),
  Product(
    id: 'p4',
    name: 'Wireless Speaker',
    price: 1199.0,
    imageUrl: 'https://m.media-amazon.com/images/I/71GNqOPWAuL._AC_UY218_.jpg',
  ),
];
