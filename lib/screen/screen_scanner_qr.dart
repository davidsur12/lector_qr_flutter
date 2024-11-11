import 'package:flutter/material.dart';
import 'package:kit_ml_barcode/screen/scan.dart';
import 'package:kit_ml_barcode/utils/permisos.dart';
import 'package:permission_handler/permission_handler.dart';

class ScreenScanQR extends StatefulWidget {
  const ScreenScanQR({super.key});

  @override
  State<ScreenScanQR> createState() => _ScreenScanQRState();
}

class _ScreenScanQRState extends State<ScreenScanQR> {
  bool _PermissionGaratisadoCamara = false;
  bool _PermissionGaratisadoAlamcenamiento = false;

  @override
  void initState() {
    super.initState();
    _checkPermission(); // Verificar permisos al iniciar
  }

  Future<void> _checkPermission() async {
//verifico si tengo el permiso del amacenamiento lectura,  escritura y camara

    var permisoCamara = await Permission.camera.status;
    var permisoAlmacenamiento = await Permission.storage.status;
//-------------------------   almacenamiento  --------------------------
    if (permisoAlmacenamiento.isGranted) {
      setState(() {
        _PermissionGaratisadoAlamcenamiento = true; // Permiso concedido
      });
    } else if (permisoAlmacenamiento.isDenied) {
      // Solicitar el permiso si ha sido denegado
      if (await Permission.camera.request().isGranted) {
        setState(() {
          _PermissionGaratisadoAlamcenamiento = true;
        });
      }
    }

    //----------------   fin -------------------------

    // ----------------Camara --------------------
    if (permisoCamara.isGranted) {
      setState(() {
        _PermissionGaratisadoCamara = true; // Permiso concedido
      });
    } else if (permisoCamara.isDenied) {
      // Solicitar el permiso si ha sido denegado
      if (await Permission.camera.request().isGranted) {
        setState(() {
          _PermissionGaratisadoCamara = true;
        });
      }
      //---------------- fin ---------------------
    }
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      body: (Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (StreamBuilder<bool>(
            stream: Stream.fromFuture(Permisos.checkPermissionCamera()),
            builder: (context, snapshot) {
              // Mostrar indicador de carga mientras el Future se resuelve
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              // Mostrar un error si ocurrió alguno
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              // Mostrar el resultado del permiso
              if (snapshot.hasData) {
                if (snapshot.data == true) {
                  return Center(
                      child: SizedBox(
                          width: 320,
                          child: (ElevatedButton.icon(
                            onPressed: () {
                              //evento
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScanApp()),
                              );
                            },
                            label: Text("Escanear Codigo con la camara"),
                            icon: Icon(Icons.camera_alt),
                            style: ElevatedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              // Alinear el contenido a la izquierda
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical:
                                      12), // Ajustar el relleno si es necesario
                            ),
                          ))));
                } else {
/*
* Encaso de no tener permisos aqui se debe solicitar el permiso de la camara
* */
                  return Column(
                    children: [
                      Text("No tienes permisos para poder acceder a la camara"),
                      (ElevatedButton.icon(
                          onPressed: () {
                            print("Solicitando Permisos");
                            Permisos.checkPermissionCamera();
                          },
                          label: Text("Conseder permisos")))
                    ],
                  );
                }
              }

              // Si no hay datos, mostrar un mensaje de espera
              return Text('Cosultado permisos de la camara...');
            },
          )),
          StreamBuilder<bool>(
            stream:
                Stream.fromFuture(Permisos.checkPermissionAlamacenamkento()),
            builder: (context, snapshot) {
              // Mostrar indicador de carga mientras el Future se resuelve
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              // Mostrar un error si ocurrió alguno
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              // Mostrar el resultado del permiso
              if (snapshot.hasData) {
                if (snapshot.data == true) {
                  return (Center(
                      child: SizedBox(
                          width: 320,
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                alignment: Alignment.centerLeft,
                                // Alinear el contenido a la izquierda
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical:
                                        12), // Ajustar el relleno si es necesario
                              ),
                              onPressed: () {},
                              label: Text("Scanear imagen"),
                              icon: Icon(Icons.image)))));
                } else {
/*
* Encasonde no tener permisos aquie se debe solicitar el permiso de la camara
* */
                  return Column(
                    children: [
                      Text(
                          "No tienes permisos para poder acceder al almacenamiento"),
                      ElevatedButton.icon(
                          onPressed: () {
                            print("Solicitando Permisos");
                            Permisos.checkPermissionAlamacenamkento();
                          },
                          label: Text("Conseder permisos"))
                    ],
                  );
                }
              }

              // Si no hay datos, mostrar un mensaje de espera
              return Text('Cosultado permisos de la camara...');
            },
          ),
        ],
      )),
    );
  }
}
