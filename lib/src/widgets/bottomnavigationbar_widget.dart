import 'package:flutter/material.dart';

import '../utils/utils.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final String routeCurrent;

  const BottomNavigationBarWidget({Key? key, required this.routeCurrent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(40),
        topLeft: Radius.circular(40),
      ),
      child: BottomNavigationBar(
          elevation: 5,
          showUnselectedLabels: true,
          selectedFontSize: 11.0,
          unselectedFontSize: 10.0,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.7),
          backgroundColor: Utils.colorVerde(1.0),
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.abc),
            )
            /*_creaItemSubMenu(
                context,
                DlpMisSuministrosPage.titlePageResumen,
                routeCurrent,
                DlpMisSuministrosPage.route,
                DlpMisSuministrosPage.icon),*/
          ],
          onTap: (value) {
            //_redirectRegistroLoginVisita(value, context);
          }),
    );
  }

  static BottomNavigationBarItem _creaItemSubMenu(BuildContext context,
      String titulo, String ruta, String rutaPage, IconData icono) {
    return BottomNavigationBarItem(
        icon: Icon(
          icono,
          color:
              ruta == rutaPage ? Colors.white : Colors.white.withOpacity(0.7),
          size: ruta == rutaPage ? 35.0 : 30.0,
        ),
        label: titulo);
  }
}
