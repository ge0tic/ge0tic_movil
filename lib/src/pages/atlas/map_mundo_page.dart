import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ge0tic/src/controllers/data_controller.dart';
import 'package:ge0tic/src/model/data_model.dart';
import 'package:ge0tic/src/model/data_path_model.dart';
import 'package:ge0tic/src/utils/constantes.dart';
import 'package:ge0tic/src/utils/utils.dart';
import 'package:ge0tic/src/widgets/appbar_widget.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MapMundoPage extends StatefulWidget {
  static const String titlePage = 'Paises';
  static const String route = '/map_paises_page';
  static const IconData icon = Icons.language_rounded;
  MapMundoPage({Key? key}) : super(key: key);

  @override
  State<MapMundoPage> createState() => _MapMundoPageState();
}

class _MapMundoPageState extends State<MapMundoPage> {
  late List<DataModel> _stateWiseElectionResult;
  late MapShapeSource _selectionMapSource;
  late bool isDesktop;
  int _selectedIndex = -1;
  double alto = Get.width;
  double ancho = Get.height;
  List<DataPathModel> l = [];
  late MapZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    l = Constantes.listProvincias;
    Utils.sortList(l);
    final dc = Get.find<DataController>();
    _zoomPanBehavior = MapZoomPanBehavior();
    _stateWiseElectionResult = dc.getDataMundoObject();

    _selectionMapSource = MapShapeSource.asset(Constantes.mapaMundoJson,
        shapeDataField: 'name',
        dataCount: _stateWiseElectionResult.length,
        primaryValueMapper: (int index) =>
            _stateWiseElectionResult[index].nombre!,
        dataLabelMapper: (int index) => _stateWiseElectionResult[index].nombre!,
        //primaryValueMapper: (int index) => _countryColors[index].country,
        shapeColorValueMapper: (int index) {
          Color _randomColor =
              Colors.primaries[Random().nextInt(Colors.primaries.length)];
          //DataPathModel x = l.firstWhere((e) => e.nombre.contains(_stateWiseElectionResult[index].nombre!));
          return _randomColor.withOpacity(0.7);
          // Utils.hexadecColor(x.color, 0.7);
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const AppBarWidget(title: "Mapa mundial"),
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
                child: _buildMapsWidget(scrollEnabled, size),
              ),
            ),
          );
        }));
  }

  Widget _buildMapsWidget(bool scrollEnabled, Size size) {
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
                child: Text('', style: Theme.of(context).textTheme.subtitle1))),
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
                overflowMode: MapLabelOverflow.hide,
                textStyle: TextStyle(color: Colors.black87, fontSize: 11),
              ),
              // Selection will not work if [MapShapeLayerDelegate.dataCount]
              // is null or empty.
              selectedIndex: _selectedIndex,
              strokeColor: Colors.white70,
              //color: _setcolorDepartamento(_selectionMapSource),
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
                }

                setState(() {
                  _selectedIndex = (index == _selectedIndex) ? -1 : index;
                });
              },
              zoomPanBehavior: _zoomPanBehavior,
            ),
          ],
        )),
        //Expanded(child: Container())
      ]),
    ));
  }
}
