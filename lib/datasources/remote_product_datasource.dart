import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kitchen_companion/entities/product.dart';

const int deltaApiCall = 600; // 100 req/min => 1 req/0.6s => 1 req/600ms

class RemoteProductDatasource {
  DateTime _lastApiCall = DateTime.now();

  Future<Product?> fetchProduct(String code) async {
    final now = DateTime.now();

    if (now.difference(_lastApiCall).inMilliseconds <= deltaApiCall) {
      return null;
    }

    _lastApiCall = now;

    final url = Uri.parse(
        'https://world.openfoodfacts.org/api/v2/product/$code?fields=code,product_name');

    final response = await http.get(
      url,
      headers: {
        'User-Agent': 'KitchenCompanion/v0.1.0 (ndxendernight@gmail.com)',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Product.fromJSON(json);
    }
    return null;
  }
}
