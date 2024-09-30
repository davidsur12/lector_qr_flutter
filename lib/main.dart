

import 'package:flutter/material.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:camera/camera.dart'; // Paquete para manejar la cámara en Flutter.


void main() {
  runApp( MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late CameraController _cameraController;
  late BarcodeScanner _barcodeScanner;
  List<Barcode> _barcodes = []; // Inicialización como lista vacía
  bool _isScanning = false;

  @override
  void initState() {
    //al iniciar la aplicacion se inicia la camra y se ontine una instacia de barcodescaner
    super.initState();
    _initializeCamera();
    _barcodeScanner = BarcodeScanner();
  }

  Future<void> _initializeCamera() async {

    //primero debo verificar si tengo los permisos
    //en  caso de que no debo pedirlos

    final cameras = await availableCameras();
    /*
    obtiene una lista de todas las cámaras disponibles en el dispositivo
    */

    print("Total de Cameras  ${cameras.length} "  );
    final CameraDescription firstCamera = cameras.first;//primera camara encontrada

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );
    /*
     se utiliza para controlar la cámara en Flutter. Específicamente, se le está diciendo a Flutter qué cámara usar y en qué resolución.
     */

    await _cameraController.initialize();
    /*
    se utiliza para inicializar el controlador de la cámara (_cameraController) en Flutter. Esta llamada es asíncrona (por eso se usa await), lo que significa que Flutter espera a que el controlador de la cámara se inicialice completamente antes de continuar con el resto del código.
     */

    setState(() {});
  }

  Future<void> _scanBarcodes() async {
    if (_isScanning) return;

    _isScanning = true;

    try {
      final picture = await _cameraController.takePicture();
      final inputImage = InputImage.fromFilePath(picture.path);

      final List<Barcode> barcodes =
      await _barcodeScanner.processImage(inputImage);

      setState(() {
        _barcodes = barcodes;
      });
    } catch (e) {
      print('Error al escanear el código de barras: $e');
    } finally {
      _isScanning = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Escáner de Códigos de Barras'),
        ),
        body: Column(
          children: [
            if (_cameraController.value.isInitialized)
              /*
               verifica si el controlador de la cámara (_cameraController) ha sido inicializado correctamente antes de intentar utilizarlo.
               */


              AspectRatio(
                aspectRatio: _cameraController.value.aspectRatio,
                child: CameraPreview(_cameraController),
              ),

            /*
            se utiliza para mostrar la vista previa de la cámara en Flutter dentro de un widget que mantiene una relación de aspecto correcta, basada en la cámara que estás usando
             */
            ElevatedButton(
              onPressed: _scanBarcodes,
              child: Text('Escanear Código de Barras'),
            ),
            if (_barcodes.isNotEmpty) // Revisa que la lista no esté vacía
              Expanded(
                child: ListView.builder(
                  itemCount: _barcodes.length,
                  itemBuilder: (context, index) {
                    final barcode = _barcodes[index];
                    return ListTile(
                      title: Text('Código de barras: ${barcode.rawValue}'),
                      subtitle: Text('Formato: ${barcode.format}'),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    //Estos eventos pasan cuando se cierra la app o entra en seundo plano
    _cameraController.dispose();
    _barcodeScanner.close();
    super.dispose();
  }


}

