import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ge0tic/src/pages/atlas/map_bolivia_page.dart';
import 'package:ge0tic/src/pages/atlas/map_departamentos_page.dart';
import 'package:ge0tic/src/pages/atlas/map_mundo_page.dart';
import 'package:ge0tic/src/pages/atlas/map_municipios_page.dart';
import 'package:ge0tic/src/pages/atlas/map_provincias_page.dart';
import 'package:ge0tic/src/utils/utils.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainAtlasPage extends StatefulWidget {
  static const String titlePage = 'Main';
  static const String route = '/main_atlas_page';
  MainAtlasPage({Key? key}) : super(key: key);

  @override
  State<MainAtlasPage> createState() => _MainAtlasPageState();
}

class _MainAtlasPageState extends State<MainAtlasPage> {
  int _selectedIndex = 0;
  //static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  final List<Widget> _widgetOptions = [];
  final List<String> _pagesRoutes = [];
  final List<GButton> _botones = [];
  bool isDark = Get.isDarkMode;

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      MapMundoPage(),
      MapDepartamentosPage(),
      MapProvinciasPage(),
      MapMunicipiosPage(),
      //MapViewerPage(mapSource: null, stateWiseElectionResult: const [])
    ];
    List<String> _pagesRoutes = const <String>[
      MapMundoPage.route,
      MapDepartamentosPage.route,
      MapProvinciasPage.route,
      MapMunicipiosPage.route,
    ];
    List<GButton> _botones = <GButton>[
      const GButton(
        icon: MapMundoPage.icon,
        text: MapMundoPage.titlePage,
      ),
      const GButton(
        icon: MapDepartamentosPage.icon,
        text: MapDepartamentosPage.titlePage,
      ),
      const GButton(
        icon: MapProvinciasPage.icon,
        text: MapProvinciasPage.titlePage,
      ),
      const GButton(
        icon: MapMunicipiosPage.icon,
        text: MapMunicipiosPage.titlePage,
      ),
    ];

    return Scaffold(
      endDrawer: _createDrawer(_pagesRoutes.elementAt(_selectedIndex)),
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.green[100]!,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 20,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Utils.colorVerde(0.95), // Colors.grey[100]!,
              color: Colors.black,
              curve: Curves.easeOutExpo, // tab animation curves
              tabBorderRadius: 15,
              textStyle: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
              tabs: _botones,
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  // ENDDRAWER
  Drawer _createDrawer(String routeCurrent) {
    return Drawer(
      child: SizedBox(
        height: Get.height,
        child: ListView(
          children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        _creaItemSubMenu("HomePage.titlePage", routeCurrent,
                            "HomePage.route", Icons.ac_unit_sharp, -1),
                      ],
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }

  ListTile _creaItemSubMenu(
      String titulo, String ruta, String rutaPage, IconData icono, int indexP,
      [String? urlPage]) {
    return ListTile(
      trailing: Icon(icono,
          size: 20,
          color: Get.isDarkMode ? Colors.orange[900] : Utils.colorVerde(0.9)),
      leading:
          Icon(Icons.chevron_left, size: 20, color: Utils.colorGuindo(0.9)),
      title: ruta == rutaPage
          ? Utils.estiloTexto(
              titulo,
              12,
              false,
              Utils.colorGuindo(0.9),
            )
          : Utils.estiloTexto(
              titulo,
              12,
              false,
              //Colors.black.withOpacity(0.85),
            ),
      selected: ruta == rutaPage, //Color opción seleccionada
      enabled: ruta != rutaPage ? true : false,
      onTap: () {
        if (titulo.contains('Cerrar')) {
          Utils.showConfirmCloseApp(
              "¡Atención!", "¿Está seguro(a) de cerrar la sesión?");
        } else {
          if (indexP == -1) {
            Get.offNamed(rutaPage);
          } else {
            Get.back();
            setState(() {
              _selectedIndex = indexP;
            });
          }
        }
      },
    );
  }
}
