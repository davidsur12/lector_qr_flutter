import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenPrueba extends StatefulWidget {
  const ScreenPrueba({super.key});

  @override
  State<ScreenPrueba> createState() => _ScreenPruebaState();
}

class _ScreenPruebaState extends State<ScreenPrueba> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Lector QR', style: TextStyle(color: Colors.white),),
        actions: [IconButton(onPressed: (){
          Get.changeTheme(Get.isDarkMode?ThemeData.light(): ThemeData.dark());//cambio de themaq

        }, icon: Icon(Icons.abc))],
      ),

body:

Center(child: ElevatedButton(onPressed: (){}, child: Text("Cambiar de thema")),),
    );
  }
}
