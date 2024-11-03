import 'package:flutter/material.dart';
import 'package:kitchen_companion/pages/product_scanner_page.dart';

class KitchenCompanionApp extends StatelessWidget {
  const KitchenCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kitchen Companion',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: ProductScannerPage(),
    );
  }
}
