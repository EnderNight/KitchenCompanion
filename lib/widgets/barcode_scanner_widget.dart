import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:kitchen_companion/widgets/camera_feed_widget.dart';

class BarcodeScannerWidget extends StatefulWidget {
  final Function(List<String>) onBarcodes;

  const BarcodeScannerWidget({
    super.key,
    required this.onBarcodes,
  });

  @override
  State<BarcodeScannerWidget> createState() => _BarcodeScannerWidgetState();
}

class _BarcodeScannerWidgetState extends State<BarcodeScannerWidget> {
  final _barcodeScanner = BarcodeScanner();
  bool _isBusy = false;

  Future<void> _scanBarcodes(InputImage image) async {
    if (_isBusy) return;

    _isBusy = true;
    final barcodes = await _barcodeScanner.processImage(image);

    widget.onBarcodes(barcodes.map((b) => b.rawValue!).toList());
    _isBusy = false;
  }

  @override
  Widget build(BuildContext context) {
    return CameraFeedWidget(onImage: _scanBarcodes);
  }
}
