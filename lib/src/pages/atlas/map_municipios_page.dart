import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ge0tic/src/controllers/data_controller.dart';
import 'package:ge0tic/src/model/data_model.dart';
import 'package:ge0tic/src/model/data_path_model.dart';
import 'package:ge0tic/src/pages/atlas/map_viewer_page.dart';
import 'package:ge0tic/src/utils/constantes.dart';
import 'package:ge0tic/src/utils/utils.dart';
import 'package:ge0tic/src/widgets/custom_expansion_tile.dart';
import 'package:ge0tic/src/widgets/custom_scrollview_widget.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MapMunicipiosPage extends StatefulWidget {
  static const String titlePage = 'Municipios';
  static const String route = '/map_municipios_page';
  static const IconData icon = Icons.map_outlined;
  MapMunicipiosPage({Key? key}) : super(key: key);

  @override
  State<MapMunicipiosPage> createState() => _MapMunicipiosPageState();
}

class _MapMunicipiosPageState extends State<MapMunicipiosPage> {
  late List<DataModel> _stateWiseElectionResult;
  final List<MapShapeSource> _listSelectionMapSource = [];
  List<DataPathModel> l = [];
  final List<int> _indexSelections = [-1, -1, -1, -1, -1, -1, -1, -1, -1];
  double alto = Get.width;
  double ancho = Get.height;
  final List<MapZoomPanBehavior> _listZoomPanBehavior = [];

  @override
  void initState() {
    final dc = Get.find<DataController>();
    _stateWiseElectionResult = dc.getDataMunicipiosObject();
    l = Constantes.listMunicipios;
    Utils.sortList(l);
    for (var e in l) {
      _listZoomPanBehavior.add(MapZoomPanBehavior());
      _listSelectionMapSource.add(MapShapeSource.asset(e.path,
          shapeDataField: 'MUNICIPIO',
          dataCount: _stateWiseElectionResult.length,
          primaryValueMapper: (int index) =>
              _stateWiseElectionResult[index].nombre!,
          dataLabelMapper: (int index) =>
              _stateWiseElectionResult[index].nombre!,
          shapeColorValueMapper: (int index) {
            Color _randomColor =
                Colors.primaries[Random().nextInt(Colors.primaries.length)];
            return _randomColor.withOpacity(0.7);
          }));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          return CustomScrollViewWidget(
              colorFondo: Utils.primaryColor,
              imagenFondo: Constantes.srcImgLaPaz1,
              titulo: 'Municipios',
              silverList: SliverList(
                  delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _makeListTile(l, _listSelectionMapSource, index);
                },
                childCount: l.length,
              )));
        }));
  }

  _makeListTile(
      List<DataPathModel> vList, List<MapShapeSource> listSelectionMap, int i) {
    String titulo = vList[i].nombre;
    Image icono = Image.asset(
      vList[i].bandera,
      height: 40,
    );
    return Card(
      elevation: 1.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
          decoration: Utils.boxDecoraton(),
          child: ListTile(
            leading: icono,
            contentPadding: const EdgeInsets.all(15),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            title: Utils.estiloTexto(
              titulo,
              14.0,
              false,
            ),
            onTap: () {
              Get.to(MapViewerPage(
                mapSource: _listSelectionMapSource[i],
                stateWiseElectionResult: _stateWiseElectionResult,
                dataPath: vList[i],
              ));
            },
          )),
    );
  }
}
