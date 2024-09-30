
import 'package:permission_handler/permission_handler.dart';

class Permisos{
  Future<void> checkCameraPermission() async {
    // Verificar si el permiso de la cámara ya ha sido concedido.
    if (await Permission.camera.isGranted) {
      // Permiso concedido, puedes usar la cámara.
      print('Permiso de cámara concedido.');
    }
    // Si no está concedido, pedimos el permiso.
    else {
      PermissionStatus status = await Permission.camera.request();
      if (status.isGranted) {
        print('Permiso de cámara concedido tras la solicitud.');
      } else if (status.isDenied) {
        print('Permiso de cámara denegado.');
      } else if (status.isPermanentlyDenied) {
        print('Permiso de cámara denegado permanentemente.');
        openAppSettings(); // Redirige a la configuración de la aplicación para que el usuario lo habilite manualmente.
      }
    }
  }

}