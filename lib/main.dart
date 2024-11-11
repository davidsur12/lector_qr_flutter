

import 'package:flutter/material.dart';
import 'package:kit_ml_barcode/screen/screen_carga_inicio.dart';
import 'package:get/get.dart';
import 'package:kit_ml_barcode/utils/theme.dart';


void main() {
  runApp( MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  void initState() {
    //al iniciar la aplicacion se inicia la camra y se ontine una instacia de barcodescaner
    super.initState();

  }


  @override
  Widget build(BuildContext context) {


    return   GetMaterialApp(


      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: MaterialTheme.lightScheme(),

          textTheme: TextTheme(
            //bodyText1:TextStyle(fontSize: 20)
          )) ,
      darkTheme: ThemeData(colorScheme: MaterialTheme.darkMediumContrastScheme()),
      home: const SpalshScreen(),
    );


  }

  @override
  void dispose() {
    //Estos eventos pasan cuando se cierra la app o entra en seundo plano

    super.dispose();
  }


}

