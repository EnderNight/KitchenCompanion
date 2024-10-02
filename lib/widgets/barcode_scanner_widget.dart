import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:kitchen_companion/widgets/camera_feed_widget.dart';

class BarcodeScannerWidget extends StatelessWidget {
  final _barcodeScanner = BarcodeScanner();
  final Function(List<String>) onBarcodes;

  BarcodeScannerWidget({
    super.key,
    required this.onBarcodes,
  });

  void _scanBarcodes(InputImage image) async {
    final barcodes = await _barcodeScanner.processImage(image);

    onBarcodes(barcodes.map((b) => b.rawValue!).toList());
  }

  @override
  Widget build(BuildContext context) {
    return CameraFeedWidget(onImage: _scanBarcodes);
  }
}
