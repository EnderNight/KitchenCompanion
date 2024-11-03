import 'package:flutter/material.dart';
import 'package:kitchen_companion/entities/product.dart';

class ProductCardWidget extends StatelessWidget {
  final Product product;

  const ProductCardWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(product.productName),
        subtitle: Text(product.code),
      ),
    );
  }
}
