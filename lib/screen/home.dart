import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kit_ml_barcode/screen/pantalla_prueba.dart';
import 'package:kit_ml_barcode/screen/screen_scanner_qr.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';





class Home extends StatelessWidget {
  Home({super.key});

  //PersistentTabController _controller;


  List<Widget> _buildScreens() {
    return [
      ScreenPrueba(),
      ScreenScanQR()
    ];
  }
  late BuildContext contexto;

  List<PersistentBottomNavBarItem> _navBarsItems() {
    //lista de items  con los parametros para navegar en el botton nav
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.store, color: Theme.of(contexto).colorScheme.surface,),
        title: ("Tienda"),
        activeColorPrimary:Theme.of(contexto).colorScheme.surface,
        inactiveColorPrimary: Colors.yellowAccent,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.store, color: Theme.of(contexto).colorScheme.surface,),
        title: ("Alarmas"),
        textStyle: TextStyle(color: Colors.green),
        activeColorPrimary:Theme.of(contexto).colorScheme.surface,
        inactiveColorPrimary: Theme.of(contexto).colorScheme.onSurface,
      ),



    ];
  }

  @override
  Widget build(BuildContext context) {
    contexto = context;
    PersistentTabController _controller =  PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      //confineInSafeArea: true,

      backgroundColor: Theme.of(context).colorScheme.onSurface, // color del background.
      handleAndroidBackButtonPress: true, // habilitar retroceder.
      resizeToAvoidBottomInset: true, // redimencionar
      stateManagement: true, //
    //  hideNavigationBarWhenKeyboardShows: true, //
      decoration: NavBarDecoration(
        useBackdropFilter: true,
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.green,//Theme.of(context).colorScheme.surface,
      ),

      navBarStyle: NavBarStyle.style1, // estilo
    );
  }
}
