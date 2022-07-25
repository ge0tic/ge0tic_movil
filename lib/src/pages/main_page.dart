import 'package:flutter/material.dart';
import 'package:ge0tic/src/pages/atlas/main_atlas_page.dart';
import 'package:ge0tic/src/pages/games/game_find_country_sudamerica_page.dart';
import 'package:ge0tic/src/utils/utils.dart';
import 'package:ge0tic/src/widgets/pushable_button.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  static const String titlePage = 'MainPage';
  static const String route = '/main_page';
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_botonAtlas(), Utils.espacio10, _botonJuegos()],
      ),
    );
  }

  _botonAtlas() => Utils.boton3D("ATLAS", Colors.greenAccent, true, () {
        Get.toNamed(MainAtlasPage.route);
      });
  _botonJuegos() => Utils.boton3D("JUEGOS", Colors.blueAccent, true, () {
        Get.to(GameFindCountrySudamericaPage());
      });
}
