class Product {
  final String code;
  final String productName;

  const Product({
    required this.code,
    required this.productName,
  });

  factory Product.fromJSON(Map<String, dynamic> json) {
    return switch (json) {
      {
        'product': {
          'code': String code,
          'product_name': String productName,
        },
      } =>
        Product(
          code: code,
          productName: productName,
        ),
      _ => throw const FormatException('Invalid product json format'),
    };
  }

  @override
  String toString() {
    return 'Product($code, $productName)';
  }
}
