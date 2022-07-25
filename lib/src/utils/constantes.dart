import 'package:ge0tic/src/model/data_path_model.dart';

class Constantes {
// ignore: non_constant_identifier_names
  static String fonoLuz = '800173333';
  static String numWhatsapp = '+59171623333';
  static String nombreET = 'ENDE TECNOLOGÍAS S.A.';
  static String textoMensajeWhatsapp =
      'señores DELAPAZ, quiero consultar sobre...';

  static String nombreDLP = 'DELAPAZ';
  static String urlDev = 'http://10.241.122.65:6060';
  static String urlProd =
      'https://dlpmiddleware.et.bo'; //'http://localhost'; //

  static String geoserverDev = 'http://10.241.122.65:8585/geoserver';
  static String geoserverProd = 'https://dlpagcmovil.et.bo/geoserver';

  static String nombreApp = "AppLuz";
  static String versionApp = "v1.3.0";

  static String urlRestApi = urlProd;
  static String urlGeoserver = geoserverProd;
  static String urlRestApiGdi = "http://190.129.163.232:8180";
  static String tipoMapa = 'osm'; //google

// URLs para mapas base
  static String urlTemplateGoogle =
      "http://mt{s}.google.com/vt/lyrs=s,h&x={x}&y={y}&z={z}";
  static String urlTemplateOsm =
      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";

  static String mensajeComunicaraALaBrevedad =
      "SR. CONSUMIDOR, DELAPAZ SE COMUNICARÁ CON UD. A LA BREVEDAD POSIBLE PARA BRINDARLE LA INFORMACIÓN SOLICITADA.";

  // IMAGENES LAPAZ
  static const String srcImgLaPaz1 = "assets/img/lapaz-1.png";
  static const String srcImgLaPaz2 = "assets/img/lapaz-2.png";
  static const String srcImgLaPaz3 = "assets/img/lapaz-3.png";
  static const String srcImgLaPaz4 = "assets/img/lapaz-4.png";
  static const String srcImgLaPaz5 = "assets/img/lapaz-5.png";
  static const String srcImgLaPaz6 = "assets/img/lapaz-6.png";
  static const String srcImgLaPaz7 = "assets/img/lapaz-7.png";

  // Variables de DB
  static int dbVersion = 1;
  static String tablaUsuario = 'Usuario';
  static String tablaNotificaciones = 'Notificaciones';
  static String tablaTokenFireBase = 'Tokenfirebase';

  //METODOS
  static const String post = 'POST';
  static String get = 'GET';
  static String put = 'PUT';
  static String del = 'DELETE';
  // Header Default
  static final Map<String, String> headers = {
    "Content-type": "application/json",
    "Accept": "application/json"
  };
  static Map<String, String> setTokenHeaders(String token) {
    return {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
  }

  // URIs servicios
  static String servLogin = '/security-se/api/v1/usermanager/login';

  // JSONs mapas
  static String mapaMundoJson = 'assets/json/world_map.json';
  static String mapaSudamericaJson = 'assets/json/south_america.json';

  //Boilvia
  static String mapaDepartamentosJson = 'assets/json/bolivia3.json';
  static String mapaProvinciasJson = 'assets/json/provincias.json';
  static String mapaMunicipiosJson = 'assets/json/municipios.json';
  // Provincias
  static String mapaProvLaPazJson = 'assets/json/prov-lapaz.json';
  static String mapaProvOruroJson = 'assets/json/prov-oruro.json';
  static String mapaProvPotosiJson = 'assets/json/prov-potosi.json';
  static String mapaProvCochabambaJson = 'assets/json/prov-cochabamba.json';
  static String mapaProvChuquisacaJson = 'assets/json/prov-chuquisaca.json';
  static String mapaProvTarijaJson = 'assets/json/prov-tarija.json';
  static String mapaProvPandoJson = 'assets/json/prov-pando.json';
  static String mapaProvBeniJson = 'assets/json/prov-beni.json';
  static String mapaProvSantaCruzJson = 'assets/json/prov-santacruz.json';
  // Municipios
  static String mapaMunLaPazJson = 'assets/json/mun-lapaz.json';
  static String mapaMunOruroJson = 'assets/json/mun-oruro.json';
  static String mapaMunPotosiJson = 'assets/json/mun-potosi.json';
  static String mapaMunCochabambaJson = 'assets/json/mun-cochabamba.json';
  static String mapaMunChuquisacaJson = 'assets/json/mun-chuquisaca.json';
  static String mapaMunTarijaJson = 'assets/json/mun-tarija.json';
  static String mapaMunPandoJson = 'assets/json/mun-pando.json';
  static String mapaMunBeniJson = 'assets/json/mun-beni.json';
  static String mapaMunSantaCruzJson = 'assets/json/mun-santacruz.json';

  // Referencia banderas:
  // https://www.eabolivia.com/blogs/15081-banderas-de-los-9-departamentos-de-bolivia.html
  static String banderaLaPaz = 'assets/img/bandera-lp.png';
  static String banderaOruro = 'assets/img/bandera-or.png';
  static String banderaPotosi = 'assets/img/bandera-pt.png';
  static String banderaCochabamba = 'assets/img/bandera-cbb.png';
  static String banderaChuquisaca = 'assets/img/bandera-ch.png';
  static String banderaTarija = 'assets/img/bandera-tj.png';
  static String banderaPando = 'assets/img/bandera-pd.png';
  static String banderaBeni = 'assets/img/bandera-bn.png';
  static String banderaSantaCruz = 'assets/img/bandera-sc.png';
  //Colores
  static String colorLp = '#009E72';
  static String colorOr = '#D91800';
  static String colorPt = '#D91800';
  static String colorCbb = '#85C6F0';
  static String colorCh = '#D91700';
  static String colorTj = '#D91800';
  static String colorPd = '#007B3A';
  static String colorBn = '#007B3A';
  static String colorSc = '#007B3A';
  // Ref.: Escudos
  // http://www.redescuela.org/Inicio/Bienvenidos
  static String escudoLp = 'assets/img/escudo-lp.png';
  static String escudoOr = 'assets/img/escudo-or.png';
  static String escudoPt = 'assets/img/escudo-pt.png';
  static String escudoCbb = 'assets/img/escudo-cbb.png';
  static String escudoCh = 'assets/img/escudo-ch.png';
  static String escudoTj = 'assets/img/escudo-tj.png';
  static String escudoPd = 'assets/img/escudo-pd.png';
  static String escudoBn = 'assets/img/escudo-bn.png';
  static String escudoSc = 'assets/img/escudo-sc.png';

  static List<DataPathModel> listProvincias = [
    DataPathModel('La Paz', mapaProvLaPazJson, banderaLaPaz, colorLp, escudoLp),
    DataPathModel('Oruro', mapaProvOruroJson, banderaOruro, colorOr, escudoOr),
    DataPathModel(
        'Potosí', mapaProvPotosiJson, banderaPotosi, colorPt, escudoPt),
    DataPathModel('Cochabamba', mapaProvCochabambaJson, banderaCochabamba,
        colorCbb, escudoCbb),
    DataPathModel('Chuquisaca', mapaProvChuquisacaJson, banderaChuquisaca,
        colorCh, escudoCh),
    DataPathModel(
        'Tarija', mapaProvTarijaJson, banderaTarija, colorTj, escudoTj),
    DataPathModel('Pando', mapaProvPandoJson, banderaPando, colorPd, escudoPd),
    DataPathModel('Beni', mapaProvBeniJson, banderaBeni, colorBn, escudoBn),
    DataPathModel('Santa Cruz', mapaProvSantaCruzJson, banderaSantaCruz,
        colorSc, escudoSc),
  ];
  // Lista Municipios
  static List<DataPathModel> listMunicipios = [
    DataPathModel('La Paz', mapaMunLaPazJson, banderaLaPaz, colorLp, escudoLp),
    DataPathModel('Oruro', mapaMunOruroJson, banderaOruro, colorOr, escudoOr),
    DataPathModel(
        'Potosí', mapaMunPotosiJson, banderaPotosi, colorPt, escudoPt),
    DataPathModel('Cochabamba', mapaMunCochabambaJson, banderaCochabamba,
        colorCbb, escudoCbb),
    DataPathModel('Chuquisaca', mapaMunChuquisacaJson, banderaChuquisaca,
        colorCh, escudoCh),
    DataPathModel(
        'Tarija', mapaMunTarijaJson, banderaTarija, colorTj, escudoTj),
    DataPathModel('Pando', mapaMunPandoJson, banderaPando, colorPd, escudoPd),
    DataPathModel('Beni', mapaMunBeniJson, banderaBeni, colorBn, escudoBn),
    DataPathModel('Santa Cruz', mapaMunSantaCruzJson, banderaSantaCruz, colorSc,
        escudoSc),
  ];

  // Fondos imágenes de Bolivia
  static String fondo1 = 'assets/img/fondos1.png';
}
