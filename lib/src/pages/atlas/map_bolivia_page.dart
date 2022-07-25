import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ge0tic/src/controllers/data_controller.dart';
import 'package:ge0tic/src/model/data_model.dart';
import 'package:ge0tic/src/utils/constantes.dart';
import 'package:ge0tic/src/utils/utils.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MapBoliviaPage extends StatefulWidget {
  static const String titlePage = 'Departamentos';
  static const String route = '/map_bolivia_page';
  static const IconData icon = Icons.map_outlined;
  MapBoliviaPage({Key? key}) : super(key: key);

  @override
  State<MapBoliviaPage> createState() => _MapBoliviaPageState();
}

class _MapBoliviaPageState extends State<MapBoliviaPage> {
  late List<DataModel> _stateWiseElectionResult;
  late List<MapColorMapper> _colorMappers;
  late MapShapeSource _selectionMapSource;
  late bool isDesktop;
  int _selectedIndex = -1;
  double alto = Get.width;
  double ancho = Get.height;

  @override
  void initState() {
    final dc = Get.find<DataController>();
    _stateWiseElectionResult = dc.getDataDepartamentosObject();

    _colorMappers = <MapColorMapper>[
      const MapColorMapper(
          from: 80,
          to: 100,
          color: Color.fromRGBO(0, 0, 81, 1.0),
          text: '{Democratic},{}'),
      const MapColorMapper(
          from: 75, to: 80, color: Color.fromRGBO(0, 43, 132, 1.0), text: ''),
      const MapColorMapper(
          from: 70, to: 75, color: Color.fromRGBO(6, 69, 180, 1.0), text: ''),
      const MapColorMapper(
          from: 65, to: 70, color: Color.fromRGBO(22, 102, 203, 1.0), text: ''),
      const MapColorMapper(
          from: 60, to: 65, color: Color.fromRGBO(67, 137, 227, 1.0), text: ''),
      const MapColorMapper(
          from: 55, to: 60, color: Color.fromRGBO(80, 154, 242, 1.0), text: ''),
      const MapColorMapper(
          from: 45,
          to: 55,
          color: Color.fromRGBO(134, 182, 242, 1.0),
          text: ''),
      const MapColorMapper(
          from: -55,
          to: -45,
          color: Color.fromRGBO(255, 178, 178, 1.0),
          text: ''),
      const MapColorMapper(
          from: -60,
          to: -55,
          color: Color.fromRGBO(255, 127, 127, 1.0),
          text: ''),
      const MapColorMapper(
          from: -65,
          to: -60,
          color: Color.fromRGBO(255, 76, 76, 1.0),
          text: ''),
      const MapColorMapper(
          from: -70,
          to: -65,
          color: Color.fromRGBO(255, 50, 50, 1.0),
          text: ''),
      const MapColorMapper(
          from: -75, to: -70, color: Color.fromRGBO(178, 0, 0, 1.0), text: ''),
      const MapColorMapper(
          from: -80, to: -75, color: Color.fromRGBO(127, 0, 0, 1.0), text: ''),
      const MapColorMapper(
          from: -100,
          to: -80,
          color: Color.fromRGBO(102, 0, 0, 1.0),
          text: 'Republican'),
    ];

    _selectionMapSource = MapShapeSource.asset(
      Constantes.mapaDepartamentosJson,
      shapeDataField: 'DEPARTAMEN',
      dataCount: _stateWiseElectionResult.length,
      primaryValueMapper: (int index) =>
          _stateWiseElectionResult[index].nombre!,
      /*shapeColorValueMapper: (int index) {
        if (_stateWiseElectionResult[index].nombre == 'La Paz') {
          return 2;
        } else {
          return -3;
        }
      },*/
      //shapeColorMappers: _colorMappers,
      dataLabelMapper: (int index) => _stateWiseElectionResult[index].nombre!,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    isDesktop = kIsWeb ||
        themeData.platform == TargetPlatform.macOS ||
        themeData.platform == TargetPlatform.linux ||
        themeData.platform == TargetPlatform.windows;
    return Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          final bool scrollEnabled = constraints.maxHeight > 400;
          double height = scrollEnabled ? constraints.maxHeight : 400;
          if ((MediaQuery.of(context).orientation == Orientation.landscape)) {
            final double refHeight = height * 0.6;
            height =
                height > 500 ? (refHeight < 500 ? 500 : refHeight) : height;
          }

          final Size size = Size(constraints.maxWidth, height);
          return Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: constraints.maxWidth,
                height: height,
                child: _buildMapsWidget(scrollEnabled, size, themeData),
              ),
            ),
          );
        }));
  }

  Widget _buildMapsWidget(bool scrollEnabled, Size size, ThemeData themeData) {
    return Center(
        child: Padding(
      padding: scrollEnabled
          ? EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
              bottom: MediaQuery.of(context).size.height * 0.05,
              right: 15,
              left: 15)
          : const EdgeInsets.only(right: 10, bottom: 15),
      child: Column(children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
                child: Text('Bolivia',
                    style: Theme.of(context).textTheme.subtitle1))),
        Expanded(
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
              dataLabelSettings: const MapDataLabelSettings(
                //overflowMode: MapLabelOverflow.visible,
                textStyle: TextStyle(color: Colors.black, fontSize: 10),
              ),
              // Selection will not work if [MapShapeLayerDelegate.dataCount]
              // is null or empty.
              selectedIndex: _selectedIndex,
              strokeColor: Colors.green[900],
              /*legend: MapLegend.bar(
                MapElement.shape,
                segmentSize: isDesktop
                    ? const Size(25, 12)
                    : Size((size.width * 0.80) / _colorMappers.length, 12.0),
                position: MapLegendPosition.bottom,
                padding: const EdgeInsets.only(top: 15),
                spacing: 0.0,
                textStyle: const TextStyle(fontSize: 10),
              ),*/
              selectionSettings: const MapSelectionSettings(
                  color: Color.fromRGBO(252, 177, 0, 1),
                  strokeColor: Colors.white,
                  strokeWidth: 2),
              // Passes the tapped or clicked shape index to the callback.
              onSelectionChanged: (int index) {
                if (index != _selectedIndex) {
                  Utils.showAwesomeDialog(
                    _stateWiseElectionResult[index].nombre!,
                    Column(
                      children: <Widget>[
                        Text(_stateWiseElectionResult[index].nombre!,
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Colors.black87,
                                    )),
                      ],
                    ),
                  );

                  /* ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green[200],
                    /*_stateWiseElectionResult[index].party == 'Republican'
                            ? Colors.red
                            : Colors.blue,*/
                    content: Container(
                      height: 100,
                      padding: const EdgeInsets.only(top: 8),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(_stateWiseElectionResult[index].nombre!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                              Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        ScaffoldMessenger.of(context)
                                            .removeCurrentSnackBar();
                                      },
                                      child: const Icon(Icons.close,
                                          color: Colors.white),
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    duration: const Duration(seconds: 3),
                  ));*/
                }
                // Tapped or clicked shape UI won't change until the parent widget
                // rebuilds the maps widget with the new selected [index].
                //
                // Passing -1 to the [MapShapeLayer.selectedIndex] for unselecting
                // the previous selected shape.
                setState(() {
                  _selectedIndex = (index == _selectedIndex) ? -1 : index;
                });
              },
            ),
          ],
        )),
        //Expanded(child: Container())
      ]),
    ));
  }
}
