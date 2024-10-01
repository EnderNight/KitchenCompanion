import 'package:flutter/material.dart';
import 'package:kitchen_companion/barcode_scanner_widget.dart';

class KitchenCompanionApp extends StatelessWidget {
  const KitchenCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kitchen Companion',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _scannedBarcode;

  void _onBarcodes(List<String> codes) {
    if (codes.isNotEmpty) {
      setState(() {
        _scannedBarcode = codes.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kitchen Companion'),
      ),
      body: Column(
        children: [
          BarcodeScannerWidget(onBarcodes: _onBarcodes),
          Center(
            child: Text(
              _scannedBarcode == null
                  ? 'No barcode detected'
                  : _scannedBarcode!,
            ),
          )
        ],
      ),
    );
  }
}

void main() {
  runApp(const KitchenCompanionApp());
}
