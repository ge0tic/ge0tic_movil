import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

class UserLocationOptions extends LayerOptions {
  BuildContext context;
  List<Marker> markers;
  MapController mapController;

  Widget markerWidget;
  bool updateMapLocationOnPositionChange;
  bool showMoveToCurrentLocationFloatingActionButton;
  bool zoomToCurrentLocationOnLoad;
  Widget moveToCurrentLocationFloatingActionButton;

  Function(LatLng) onLocationUpdate;
  Function() onTapFAB;

  double fabBottom;
  double fabRight;
  double fabHeight;
  double fabWidth;

  bool verbose;
  bool showHeading;

  double defaultZoom;

  UserLocationOptions({
    required this.context,
    required this.markers,
    required this.mapController,
    required this.markerWidget,
    required this.onLocationUpdate,
    required this.onTapFAB,
    this.updateMapLocationOnPositionChange = true,
    this.showMoveToCurrentLocationFloatingActionButton = true,
    required this.moveToCurrentLocationFloatingActionButton,
    this.verbose = false,
    this.fabBottom = 20,
    this.fabHeight = 40,
    this.fabRight = 20,
    this.fabWidth = 40,
    this.defaultZoom = 15,
    this.zoomToCurrentLocationOnLoad = false,
    this.showHeading = true
  });
}
