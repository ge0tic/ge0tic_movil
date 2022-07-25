import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ge0tic/src/utils/constantes.dart';
import 'package:latlong2/latlong.dart';

export 'package:flutter_map/flutter_map.dart';

class UtilsMap {
  static Widget addLayersBaseOverlay(List<LayerOptions> layers, String template,
      LatLng mapCenter, double initialZoom,
      [MapController? mapController]) {
    List<LayerOptions> listLayers = [];
    listLayers.add(TileLayerOptions(
      maxZoom: 22,
      minZoom: 5,
      urlTemplate: (template == 'osm')
          ? Constantes.urlTemplateOsm
          : Constantes.urlTemplateGoogle,
      subdomains: (template == 'osm') ? ['a', 'b', 'c'] : [],
    ));
    for (var l in layers) {
      listLayers.add(l);
    }

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: [
          Flexible(
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: mapCenter,
                zoom: initialZoom,
                plugins: [
                  //ZoomButtonsPlugin(),
                ],
              ),
              layers: listLayers,
            ),
          ),
        ],
      ),
    );
  }
}
