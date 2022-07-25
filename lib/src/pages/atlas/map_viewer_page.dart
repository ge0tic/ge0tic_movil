import 'package:flutter/material.dart';
import 'package:ge0tic/src/model/data_model.dart';
import 'package:ge0tic/src/model/data_path_model.dart';
import 'package:ge0tic/src/utils/utils.dart';
import 'package:ge0tic/src/widgets/appbar_widget.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MapViewerPage extends StatefulWidget {
  MapShapeSource mapSource;
  List<DataModel> stateWiseElectionResult;
  DataPathModel dataPath;
  MapViewerPage(
      {Key? key,
      required this.mapSource,
      required this.stateWiseElectionResult,
      required this.dataPath})
      : super(key: key);

  @override
  State<MapViewerPage> createState() => _MapViewerPageState();
}

class _MapViewerPageState extends State<MapViewerPage> {
  int _indexSelection = -1;
  MapZoomPanBehavior _zoomPanBehavior = MapZoomPanBehavior();

  @override
  void initState() {
    _zoomPanBehavior = MapZoomPanBehavior();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(title: widget.dataPath.nombre),
      body: Stack(children: [
        Positioned(left: 10.0, top: 10.0, child: _botonEscudo(widget.dataPath)),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_cardinal('N')],
          ),
          Expanded(
              //padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _cardinal('O'),
              Expanded(
                child: SfMaps(
                  layers: <MapLayer>[
                    MapShapeLayer(
                      loadingBuilder: (BuildContext context) {
                        return Utils.circulrProgressIndicator();
                      },
                      source: widget.mapSource,
                      showDataLabels: true,
                      dataLabelSettings: const MapDataLabelSettings(
                        overflowMode: MapLabelOverflow.hide,
                        textStyle:
                            TextStyle(color: Colors.black87, fontSize: 10),
                      ),
                      // Selection will not work if [MapShapeLayerDelegate.dataCount]
                      // is null or empty.
                      selectedIndex: _indexSelection, // _selectedIndex,
                      strokeColor: Colors
                          .white70, //Utils.hexadecColor(vList[i].color, 0.7),
                      color: Colors
                          .black54, // Utils.hexadecColor(vList[i].color, 0.4),

                      selectionSettings: const MapSelectionSettings(
                          color: Color.fromRGBO(252, 177, 0, 1),
                          strokeColor: Colors.white,
                          strokeWidth: 2),
                      // Passes the tapped or clicked shape index to the callback.
                      onSelectionChanged: (int index) {
                        if (index != _indexSelection) {
                          Utils.showAwesomeDialog(
                            widget.stateWiseElectionResult[index].nombre!,
                            Column(
                              children: <Widget>[
                                Text(
                                    widget
                                        .stateWiseElectionResult[index].nombre!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          color: Colors.black87,
                                        )),
                              ],
                            ),
                          );
                        }

                        setState(() {
                          _indexSelection =
                              (index == _indexSelection) ? -1 : index;
                          /*_selectedIndex =
                                    (index ==  _selectedIndex)
                                        ? -1
                                        : index;*/
                        });
                      },
                      zoomPanBehavior: _zoomPanBehavior,
                    ),
                  ],
                ),
              ),
              _cardinal('E')
            ],
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_cardinal('S')],
          ),
        ]),
      ]),
    );
  }

  _botonEscudo(DataPathModel l) {
    return Container(
      width: 80.0,
      //height: 80.0,
      decoration: const BoxDecoration(color: Colors.white),
      child: Image.asset(l.escudo),
    );
  }

  _cardinal(String s) => Text(
        s,
        style: const TextStyle(fontSize: 16),
      );
}
