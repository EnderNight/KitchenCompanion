import 'package:flutter/material.dart';
import 'package:kitchen_companion/datasources/remote_product_datasource.dart';
import 'package:kitchen_companion/entities/product.dart';
import 'package:kitchen_companion/widgets/barcode_scanner_widget.dart';
import 'package:kitchen_companion/widgets/product_card_widget.dart';

class ProductScannerPage extends StatefulWidget {
  final _dsProduct = RemoteProductDatasource();
  ProductScannerPage({super.key});

  @override
  State<ProductScannerPage> createState() => _ProductScannerPageState();
}

class _ProductScannerPageState extends State<ProductScannerPage> {
  Product? _product;
  bool _isBusy = false;

  Future<void> _onBarcode(List<String> barcodes) async {
    if (!_isBusy && barcodes.isNotEmpty) {
      _isBusy = true;
      final barcode = barcodes.first;

      final res = await widget._dsProduct.fetchProduct(barcode);

      if (res != null) {
        setState(() {
          _product = res;
        });
      }
      _isBusy = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product scanner'),
      ),
      body: Column(
        children: [
          BarcodeScannerWidget(
            onBarcodes: _onBarcode,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: _product == null
                ? Center(
                    child: Text('No detected product'),
                  )
                : ProductCardWidget(product: _product!),
          ),
        ],
      ),
    );
  }
}
