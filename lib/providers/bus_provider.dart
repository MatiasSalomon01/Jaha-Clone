import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../services/services.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

class BusProvider extends ChangeNotifier {
  late final String _jsonString;

  Map<MarkerId, Marker> _busStops = {};
  Set<Marker> get busStops => _busStops.values.toSet();
  Map<MarkerId, Marker> get busStopsMap => _busStops;

  Map<MarkerId, Marker> _markers = {};
  Set<Marker> get markers => _markers.values.toSet();

  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  CustomInfoWindowController get customInfoWindowController =>
      _customInfoWindowController;

  set customInfoWindowController(CustomInfoWindowController value) {
    _customInfoWindowController = value;
  }

  CameraPosition initialPosition() {
    return CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14,
    );
  }

  final _busStopIcon = Completer<BitmapDescriptor>();

  bool isActive = false;
  bool _nearYou = true;

  bool get nearYou => _nearYou;

  set nearYou(bool value) {
    _nearYou = value;
    notifyListeners();
  }

  bool showCurrentLocation = false;

  Map<MarkerId, Marker> _userPosition = {};
  Position position = Location.position;

  late GoogleMapController controller;

  double _distanceNearYou = 1000;

  double get distanceNearYou => _distanceNearYou;

  set distanceNearYou(double value) {
    _distanceNearYou = value;
    notifyListeners();
  }

  BusProvider() {
    loadJsonData();
    assetsToBytes('assets/bus-stop.png', width: 150).then((value) {
      final bitMap = BitmapDescriptor.fromBytes(value);
      _busStopIcon.complete(bitMap);
    });
  }

  Future<void> getBusStops() async {
    final List<dynamic> data = json.decode(_jsonString);
    final icon = await _busStopIcon.future;

    for (var i in data) {
      final Map<String, dynamic> coordenates = i;

      final position = LatLng(
        coordenates['latitude'],
        coordenates['longitude'],
      );

      final id = DateTime.now().microsecondsSinceEpoch.toString();
      final marketId = MarkerId(id);
      final marker = Marker(
        markerId: marketId,
        position: position,
        icon: icon,
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
            Container(
                // width: 50,
                // height: 50,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(10)),
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Línea 23'),
                        Text('Línea 30 azul'),
                        Text('Línea 30 amarillo'),
                      ],
                    ),
                  ],
                )),
            position,
          );
        },
      );

      _busStops[marketId] = marker;
    }
    notifyListeners();
  }

  void clearBusStops() {
    _busStops.clear();
    notifyListeners();
  }

  void clearMarkers(Map<MarkerId, Marker> markers) {
    for (var element in markers.entries) {
      if (_markers.containsKey(element.key)) {
        _markers.removeWhere(
            (key, value) => key == element.key && value == element.value);
      }
    }
    notifyListeners();
  }

  Future<void> loadJsonData() async =>
      _jsonString = await rootBundle.loadString('lib/data/bus-stops.json');

  Future<Uint8List> assetsToBytes(String path, {int width = 100}) async {
    final byteData = await rootBundle.load(path);
    final bytes = byteData.buffer.asUint8List();
    final codec = await ui.instantiateImageCodec(bytes, targetHeight: width);
    final frame = await codec.getNextFrame();
    final newByteData =
        await frame.image.toByteData(format: ui.ImageByteFormat.png);
    return newByteData!.buffer.asUint8List();
  }

  void setMarkers(Map<MarkerId, Marker> markers) {
    for (var element in markers.entries) {
      _markers.putIfAbsent(element.key, () => element.value);
    }
    notifyListeners();
  }

  setNearMarkers(Set<Marker> markers) {
    Map<MarkerId, Marker> filteredMarkers = {};
    double maxDistance = _distanceNearYou;

    for (var marker in markers) {
      double distance = Location.calculateDistance(
        position.latitude,
        position.longitude,
        marker.position.latitude,
        marker.position.longitude,
      );

      if (distance <= maxDistance) {
        filteredMarkers[marker.markerId] = marker;
      }

      setMarkers(filteredMarkers);
    }
  }

  setCurrentLocationOnMap() {
    if (showCurrentLocation == false) {
      final id = DateTime.now().microsecondsSinceEpoch.toString();
      final marketId = MarkerId(id);
      final marker = Marker(
        markerId: marketId,
        position: LatLng(
          position.latitude,
          position.longitude,
        ),
      );
      _userPosition[marketId] = marker;

      controller.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude),
        ),
      );

      setMarkers(_userPosition);
    }
    if (showCurrentLocation == true) {
      clearMarkers(_userPosition);
    }
    showCurrentLocation = !showCurrentLocation;
  }

  disposeInfoController() {
    _customInfoWindowController.dispose();
  }

  Set<Circle> buildCircle(Color fillColor) {
    return {
      Circle(
        circleId: const CircleId('d7d02a51-a69a-4fed-b7da-47b011f7f59e'),
        center: LatLng(position.latitude, position.longitude),
        radius: _distanceNearYou,
        strokeWidth: 2,
        fillColor: fillColor.withOpacity(.15),
        strokeColor: fillColor,
      ),
    };
  }
}
