import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class CameraFeedWidget extends StatefulWidget {
  final void Function(InputImage image) onImage;
  const CameraFeedWidget({
    super.key,
    required this.onImage,
  });

  @override
  State<CameraFeedWidget> createState() => _CameraFeedWidgetState();
}

class _CameraFeedWidgetState extends State<CameraFeedWidget> {
  late CameraDescription _camera;
  CameraController? _controller;
  Future<void>? _initializeController;

  @override
  void initState() {
    super.initState();

    _initCameras();
  }

  void _initCameras() async {
    final cameras = await availableCameras();

    if (cameras.isNotEmpty) {
      _camera = cameras.first;
      _controller = CameraController(
        _camera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.nv21,
      );
      _initializeController = _controller!.initialize().then((_) {
        if (!mounted) return;

        _controller!.startImageStream(_onImage);

        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _controller?.stopImageStream();
    _controller?.dispose();

    super.dispose();
  }

  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  void _onImage(CameraImage image) {
    var rotationComp = _orientations[_controller!.value.deviceOrientation];
    if (rotationComp == null) return;

    rotationComp = (_camera.sensorOrientation - rotationComp + 360) % 360;

    final rotation = InputImageRotationValue.fromRawValue(rotationComp);
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    final plane = image.planes.first;

    if (rotation == null ||
        format != InputImageFormat.nv21 ||
        image.planes.length != 1) {
      return;
    }

    widget.onImage(
      InputImage.fromBytes(
        bytes: plane.bytes,
        metadata: InputImageMetadata(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          rotation: rotation,
          format: format!,
          bytesPerRow: plane.bytesPerRow,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = 300.0;
    return FutureBuilder(
      future: _initializeController,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SizedBox(
            width: size,
            height: size,
            child: ClipRect(
              child: OverflowBox(
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: SizedBox(
                    height: size * _controller!.value.aspectRatio,
                    child: CameraPreview(_controller!),
                  ),
                ),
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
