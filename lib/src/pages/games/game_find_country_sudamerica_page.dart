import 'dart:math';
import 'dart:developer' as dev;

import 'package:audioplayers/audioplayers.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ge0tic/src/controllers/data_controller.dart';
import 'package:ge0tic/src/model/data_model.dart';
import 'package:ge0tic/src/model/data_path_model.dart';
import 'package:ge0tic/src/utils/constantes.dart';
import 'package:ge0tic/src/utils/utils.dart';
import 'package:ge0tic/src/widgets/appbar_widget.dart';
import 'package:ge0tic/src/widgets/round_button_widget.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class GameFindCountrySudamericaPage extends StatefulWidget {
  static const String titlePage = 'Busca Departamentos';
  static const String route = '/game_busca_paises_sudamerica_page';
  static const IconData icon = Icons.map_outlined;
  GameFindCountrySudamericaPage({Key? key}) : super(key: key);

  @override
  State<GameFindCountrySudamericaPage> createState() =>
      _GameFindCountrySudamericaPageState();
}

class _GameFindCountrySudamericaPageState
    extends State<GameFindCountrySudamericaPage> {
  late List<DataModel> _stateWiseElectionResult;
  List<DataModel> _objectsCorrects = [];
  List<DataModel> _objectsFails = [];
  late List<DataModel> _objectsABuscar;

  late MapShapeSource _selectionMapSource;
  late bool isDesktop;
  int _selectedIndex = -1;
  double alto = Get.width;
  double ancho = Get.height;
  List<DataPathModel> l = [];

  String _objectABuscar = '';
  int numObjects = 0;
  int minutos = 0;
  Color _colorObject = Colors.grey.withOpacity(0.5);
  bool _switchBotonReiniciar = false;
  bool _isPause = true;
  bool _firstGame = false;

  String _dataStringJson = Constantes.mapaSudamericaJson;

  final CustomTimerController _controller = CustomTimerController();

  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    l = Constantes.listProvincias;
    Utils.sortList(l);
    final dc = Get.find<DataController>();
    _stateWiseElectionResult = dc.getDataSudamericaObject();

    _selectionMapSource = MapShapeSource.asset(
      _dataStringJson,
      shapeDataField: 'name',
      dataCount: _stateWiseElectionResult.length,
      primaryValueMapper: (int index) =>
          _stateWiseElectionResult[index].nombre!,
      dataLabelMapper: (int index) {
        String nombreObj = _stateWiseElectionResult[index].nombre!;

        //_foodList.where((food) => food.name.toLowerCase().contains(userInputValue.toLowerCase()).toList();

        return "";
      },
      /*shapeColorValueMapper: (int index) {
          Color colorObject = Colors.grey;
          int x = _buscarPosObject(
              _objectsCorrects, _stateWiseElectionResult[index].nombre!);
          int y = _buscarPosObject(
              _objectsFails, _stateWiseElectionResult[index].nombre!);

          colorObject = x == y
              ? Colors.grey
              : x > y
                  ? Colors.green
                  : Colors.red;
          return colorObject;
        }*/
    );

    _objectsABuscar = List.from(_stateWiseElectionResult);
    // _objectABuscar = _getNombreDep();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const AppBarWidget(title: "Países del mundo"),
        body: _buildMapsWidget());
  }

  Widget _buildMapsWidget() {
    return Stack(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: SfMaps(
          layers: <MapLayer>[
            MapShapeLayer(
              loadingBuilder: (BuildContext context) {
                return const SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                );
              },
              source: _selectionMapSource,
              showDataLabels: true,
              /*dataLabelSettings: const MapDataLabelSettings(
            overflowMode: MapLabelOverflow.visible,
            textStyle: TextStyle(color: Colors.black, fontSize: 11),
          ),*/
              // Selection will not work if [MapShapeLayerDelegate.dataCount]
              // is null or empty.
              selectedIndex: _selectedIndex,
              strokeColor: Colors.white70,
              //color: _colorObject,

              /*legend: MapLegend.bar(
                MapElement.shape,
                segmentSize: const Size(25, 12),
                position: MapLegendPosition.bottom,
                overflowMode: MapLegendOverflowMode.wrap,
                padding: const EdgeInsets.only(top: 15),
                spacing: 0.0,
                textStyle: const TextStyle(fontSize: 10),
              ),*/
              selectionSettings: const MapSelectionSettings(
                  color: Color.fromRGBO(252, 177, 0, 1),
                  strokeColor: Colors.white,
                  strokeWidth: 2),
              // Passes the tapped or clicked shape index to the callback.
              onSelectionChanged: (int index) async {
                if (_isPause == false) {
                  if (_objectABuscar ==
                      _stateWiseElectionResult[index].nombre!) {
                    _objectsCorrects.add(_stateWiseElectionResult[index]);
                  } else {
                    _objectsFails.add(_stateWiseElectionResult[_buscarPosObject(
                        _stateWiseElectionResult, _objectABuscar)]);
                  }
                  /////////////
                  _selectionMapSource = MapShapeSource.asset(_dataStringJson,
                      shapeDataField: 'name',
                      dataCount: _stateWiseElectionResult.length,
                      primaryValueMapper: (int index) =>
                          _stateWiseElectionResult[index].nombre!,
                      dataLabelMapper: (int index) {
                        String nombreObj =
                            _stateWiseElectionResult[index].nombre!;
                        int x = _buscarPosObject(_objectsCorrects, nombreObj);
                        int y = _buscarPosObject(_objectsFails, nombreObj);

                        nombreObj = x == y
                            ? ""
                            : x > y
                                ? _objectsCorrects[x].nombre.toString()
                                : _objectsFails[y].nombre.toString();

                        return nombreObj;
                      },
                      shapeColorValueMapper: (int index) {
                        Color colorObject = Colors.grey;
                        int x = _buscarPosObject(_objectsCorrects,
                            _stateWiseElectionResult[index].nombre!);
                        int y = _buscarPosObject(_objectsFails,
                            _stateWiseElectionResult[index].nombre!);

                        colorObject = x == y
                            ? Colors.grey.withOpacity(0.5)
                            : x > y
                                ? Colors.green
                                : Colors.red;
                        return colorObject;
                      });

                  // FIN del juego
                  if (_objectsABuscar.isEmpty) {
                    if (_objectsCorrects.length > _objectsFails.length) {
                      await Utils.soundOk();
                    } else {
                      await Utils.soundFail();
                    }

                    _controller.pause();
                    _isPause = true;
                    _firstGame = false;
                    Utils.showAwesomeDialog(
                        "Fin del juego",
                        Text("Correctos: ${_objectsCorrects.length} \n" +
                            "Incorrectos: ${_objectsFails.length} "));
                    _switchBotonReiniciar = true;
                  }

                  setState(() {
                    _selectedIndex = (index == _selectedIndex) ? -1 : index;
                    _objectABuscar = _getNombreDep();
                    //_colorObject = colorO;
                  });
                }
              },
            ),
          ],
        ),
      ),
      _timer(),
      _legend(),
    ]);
  }

  String _getNombreDep() {
    numObjects = _objectsABuscar.length;
    String n = '';
    dev.log("Lengtht: $numObjects");
    if (numObjects > 0) {
      int i = Random().nextInt(numObjects);
      dev.log("INDEX: $i");
      n = _objectsABuscar[i].nombre.toString();
      _objectsABuscar.removeAt(i);
      dev.log("DEP: $n");
    }
    return n;
  }

  _timer() {
    return Positioned(
      right: 10.0,
      top: 10.0,
      child: Card(
        elevation: 2,
        child: Container(
            decoration: Utils.boxDecoraton(),
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: ancho * 0.15,
                      child: _switchBotonReiniciar
                          ? RoundButtonWidget(
                              text: "Reiniciar",
                              color: Colors.blueAccent,
                              onPressed: () {
                                setState(() {
                                  _switchBotonReiniciar = false;
                                  _objectsCorrects = [];
                                  _objectsFails = [];
                                  _isPause = false;
                                  _controller.reset();
                                  _firstGame = false;
                                  _objectsABuscar =
                                      List.from(_stateWiseElectionResult);
                                  _selectionMapSource = MapShapeSource.asset(
                                      _dataStringJson,
                                      shapeDataField: 'name',
                                      dataCount:
                                          _stateWiseElectionResult.length,
                                      primaryValueMapper: (int index) =>
                                          _stateWiseElectionResult[index]
                                              .nombre!,
                                      dataLabelMapper: (int index) {
                                        String nombreObj =
                                            _stateWiseElectionResult[index]
                                                .nombre!;

                                        //_foodList.where((food) => food.name.toLowerCase().contains(userInputValue.toLowerCase()).toList();

                                        return "";
                                      },
                                      shapeColorValueMapper: (int index) {
                                        Color colorObject =
                                            Colors.grey.withOpacity(0.5);

                                        return colorObject;
                                      });
                                });
                                if (_firstGame == false) {
                                  _objectABuscar = _getNombreDep();
                                  _firstGame = true;
                                }
                                _controller.state.index < 2
                                    ? _controller.start()
                                    : _controller.pause();
                              },
                            )
                          : RoundButtonWidget(
                              text: _controller.state.index < 2
                                  ? "Juega"
                                  : "Pausa",
                              color: _controller.state.index < 2
                                  ? Colors.green
                                  : Colors.red,
                              onPressed: () {
                                if (_firstGame == false) {
                                  _objectABuscar = _getNombreDep();
                                  _firstGame = true;
                                }
                                if (_controller.state.index < 2) {
                                  _controller.start();
                                  _isPause = false;
                                } else {
                                  _controller.pause();
                                  _isPause = true;
                                }
                                setState(() {});
                              },
                            ),
                    ),
                  ],
                ),
                Utils.espacio05,
                CustomTimer(
                    controller: _controller,
                    begin: const Duration(),
                    end: const Duration(days: 1),
                    builder: (remaining) {
                      String mili =
                          double.parse(remaining.milliseconds.substring(1))
                              .round()
                              .toString();
                      String sec = int.parse(remaining.seconds) > 9
                          ? int.parse(remaining.seconds).toString()
                          : '0' + int.parse(remaining.seconds).toString();
                      dev.log("NAME:  ${_controller.state.index}");
                      return Text(
                          "${remaining.hours}:${remaining.minutes}:$sec",
                          style: const TextStyle(fontSize: 14.0));
                    }),
                Utils.espacio05,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Utils.estiloTexto("Busca: ", 12, false),
                    Utils.estiloTexto(_objectABuscar, 14, true),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  int _buscarPosObject(List<DataModel> objects, String s) {
    int i = -1;
    i = objects.indexWhere((e) => e.nombre == s);
    return i;
  }

  _legend() {
    return Positioned(
        left: 10.0,
        top: 10.0,
        child: Card(
            elevation: 2,
            child: Container(
                width: ancho * 0.1,
                decoration: Utils.boxDecoraton(),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          color: Colors.green,
                        ),
                        Utils.estiloTexto(
                            _objectsCorrects.length.toString(), 16, false)
                      ],
                    ),
                    Utils.espacio10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.disabled_by_default_rounded,
                          color: Colors.red,
                        ),
                        // Utils.estiloTexto("Incorrectos: ", 14, true),
                        Utils.estiloTexto(
                            _objectsFails.length.toString(), 16, false)
                      ],
                    ),
                  ],
                ))));
  }
}
