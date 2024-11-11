
import 'package:permission_handler/permission_handler.dart';

class Permisos{

  static Future<bool> checkPermissionCamera() async {

    //Permiso de la camara devuelve true si se tiene permiso de los contrario debuel  false
    var permisoCamara = await Permission.camera.status;
    bool _PermissionGaratisadoCamara = false;
    if (permisoCamara.isGranted) {

      //_PermissionGaratisadoCamara = true;
      return  await true;
    } else if (permisoCamara.isDenied) {
      // Solicitar el permiso si ha sido denegado
      if (await Permission.camera
          .request()
          .isGranted) {

        //_PermissionGaratisadoCamara = true;
        return await true;
      }
    }
    return await false;
  }

  static Future<bool> checkPermissionAlamacenamkento() async{
    //Permiso de la almacenamiento devuelve true si se tiene permiso de los contrario debuel  false


    var permisoAlmacenamiento = await Permission.storage.status;

    if (permisoAlmacenamiento.isGranted) {


      //_PermissionGaratisadoAlamcenamiento = true; // Permiso concedido
      return await true;
    } else if (permisoAlmacenamiento.isDenied) {
      // Solicitar el permiso si ha sido denegado
      if (await Permission.camera
          .request()
          .isGranted) {

        //_PermissionGaratisadoAlamcenamiento = true;
        return await true;
      }
    }
    return await false;
  }


}