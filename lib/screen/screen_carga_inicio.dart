import 'package:flutter/material.dart';

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:kit_ml_barcode/screen/home.dart';
import 'package:kit_ml_barcode/screen/pantalla_prueba.dart';
import 'package:kit_ml_barcode/screen/scan.dart';
import 'package:kit_ml_barcode/screen/screen_scanner_qr.dart'; // Para el temporizador


class SpalshScreen extends StatelessWidget {
  const SpalshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return    FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.white,
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
      },
      childWidget: SizedBox(
        height: 200,
        width: 200,
        child: Image.asset("assets/iconos/codigo-qr.png",),
      ),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      nextScreen:  Home(),
    );
  }
}
