/*import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:camera/camera.dart'; // Paquete para manejar la cámara en Flutter.
import 'package:flutter/material.dart';
class BarcodeScannerExample extends StatefulWidget {
  @override
  _BarcodeScannerExampleState createState() => _BarcodeScannerExampleState();
}

class _BarcodeScannerExampleState extends State<BarcodeScannerExample> {
  late CameraController _cameraController;
  late BarcodeScanner _barcodeScanner;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _barcodeScanner = BarcodeScanner();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first; // Selecciona la cámara principal.

    _cameraController = CameraController(
      camera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _cameraController.initialize();
    _startBarcodeDetection();
  }

  void _startBarcodeDetection() {
    _cameraController.startImageStream((CameraImage image) async {
      if (isDetecting) return;
      isDetecting = true;

      final WriteBuffer allBytes = WriteBuffer();
      for (var plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());
      final InputImageRotation imageRotation = InputImageRotation.Rotation_0deg;
      final InputImageFormat inputImageFormat = InputImageFormatMethods.fromRawValue(image.format.raw) ?? InputImageFormat.NV21;

      final planeData = image.planes.map(
            (Plane plane) {
          return InputImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        },
      ).toList();

      final inputImageData = InputImageData(
        size: imageSize,
        imageRotation: imageRotation,
        inputImageFormat: inputImageFormat,
        planeData: planeData,
      );

      final inputImage = InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

      final barcodes = await _barcodeScanner.processImage(inputImage);
      for (Barcode barcode in barcodes) {
        final String value = barcode.value.displayValue ?? '';
        print('Código de barras detectado: $value');
        // Aquí puedes manejar los datos del código de barras.
      }

      isDetecting = false;
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) {
      return Container(); // Si la cámara aún no está inicializada.
    }

    return Scaffold(
      appBar: AppBar(title: Text('Escáner de Códigos de Barras')),
      body: CameraPreview(_cameraController),
    );
  }
}
*/