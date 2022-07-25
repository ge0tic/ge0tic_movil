import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ge0tic/src/controllers/data_controller.dart';
import 'package:ge0tic/src/pages/atlas/main_atlas_page.dart';
import 'package:ge0tic/src/pages/atlas/map_departamentos_page.dart';
import 'package:ge0tic/src/pages/atlas/map_mundo_page.dart';
import 'package:ge0tic/src/pages/atlas/map_municipios_page.dart';
import 'package:ge0tic/src/pages/atlas/map_provincias_page.dart';
import 'package:ge0tic/src/pages/games/game_find_country_page.dart';
import 'package:ge0tic/src/pages/games/game_find_country_sudamerica_page.dart';
import 'package:ge0tic/src/pages/games/game_find_deps_page.dart';
import 'package:ge0tic/src/pages/main_page.dart';
import 'package:ge0tic/src/utils/constantes.dart';
import 'package:ge0tic/src/utils/utils.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(DataController());
  // Mapas mundo
  String paises = await Utils.readJsonFile(Constantes.mapaMundoJson);
  String paisesSudamerica =
      await Utils.readJsonFile(Constantes.mapaSudamericaJson);

  //Bolivia
  String deps = await Utils.readJsonFile(Constantes.mapaDepartamentosJson);
  String provs = await Utils.readJsonFile(Constantes.mapaProvinciasJson);
  String muns = await Utils.readJsonFile(Constantes.mapaMunicipiosJson);

  final dc = Get.find<DataController>();
  dc.setDataMundo(paises);
  dc.setDataSudAmerica(paisesSudamerica);
  dc.setDataDepartamentos(deps);
  dc.setDataProvincias(provs);
  dc.setDataMunicipios(muns);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: _navigatorKey,
      scaffoldMessengerKey: _scaffoldMessengerKey,
      enableLog: false,
      themeMode: ThemeMode.system,
      locale: window.locale,
      supportedLocales: const [
        Locale('es'),
        Locale('en'),
        Locale('fr'),
      ],
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: "Maps",
      initialRoute: MainPage
          .route, //GameFindCountrySudamericaPage.route, // MainPage.route,
      getPages: [
        GetPage(name: MainPage.route, page: () => MainPage()),
        GetPage(name: MainAtlasPage.route, page: () => MainAtlasPage()),
        GetPage(name: MapMundoPage.route, page: () => MapMundoPage()),
        GetPage(name: MapMundoPage.route, page: () => MapMundoPage()),
        GetPage(
            name: MapDepartamentosPage.route,
            page: () => MapDepartamentosPage()),
        GetPage(name: MapProvinciasPage.route, page: () => MapProvinciasPage()),
        GetPage(name: MapMunicipiosPage.route, page: () => MapMunicipiosPage()),

        //Juegos
        GetPage(
            name: GameFindCountryPage.route, page: () => GameFindCountryPage()),
        GetPage(
            name: GameFindCountrySudamericaPage.route,
            page: () => GameFindCountrySudamericaPage()),

        //Bolivia
        GetPage(name: GameFindDepsPage.route, page: () => GameFindDepsPage()),
      ],
    );
  }
}
