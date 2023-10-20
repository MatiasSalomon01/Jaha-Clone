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

import '../widgets/marker_window.dart';

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
  bool _nearYou = false;

  bool get nearYou => _nearYou;

  set nearYou(bool value) {
    _nearYou = value;
    notifyListeners();
  }

  bool showCurrentLocation = false;

  Map<MarkerId, Marker> userPosition = {};
  Position position = Location.position;

  Map<MarkerId, Marker> momentaryMarker = {};

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
            const MarkerWindow(),
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
    Map<MarkerId, Marker> markersToDelete = {};
    double maxDistance = _distanceNearYou;

    var actualPosition = momentaryMarker.isEmpty
        ? userPosition.isEmpty
            ? LatLng(position.latitude, position.longitude)
            : userPosition.values.first.position
        : momentaryMarker.values.first.position;

    for (var marker in markers) {
      double distance = Location.calculateDistance(
        actualPosition.latitude,
        actualPosition.longitude,
        marker.position.latitude,
        marker.position.longitude,
      );

      if (distance <= maxDistance) {
        filteredMarkers[marker.markerId] = marker;
      }
    }

    var forDeletions = markers.difference(filteredMarkers.values.toSet());

    for (var item in forDeletions) {
      markersToDelete[item.markerId] = item;
    }

    clearMarkers(markersToDelete);
    setMarkers(filteredMarkers);
  }

  Future<void> clearNearMarkers(Set<Marker> markers) async {
    Map<MarkerId, Marker> filteredMarkers = {};
    double maxDistance = _distanceNearYou;

    var actualPosition = momentaryMarker.isEmpty
        ? userPosition.isEmpty
            ? LatLng(position.latitude, position.longitude)
            : userPosition.values.first.position
        : momentaryMarker.values.first.position;

    for (var marker in markers) {
      double distance = Location.calculateDistance(
        actualPosition.latitude,
        actualPosition.longitude,
        marker.position.latitude,
        marker.position.longitude,
      );

      if (distance > maxDistance) {
        filteredMarkers[marker.markerId] = marker;
        if (_markers.containsKey(marker.markerId)) {
          _markers.removeWhere(
              (key, value) => key == marker.markerId && value == marker);
        }
      }
    }

    // for (var element in filteredMarkers.entries) {
    //   if (_markers.containsKey(element.key)) {
    //     _markers.removeWhere(
    //         (key, value) => key == element.key && value == element.value);
    //   }
    // }
    notifyListeners();
  }

  setCurrentLocationOnMap() {
    if (showCurrentLocation == false) {
      clearMarkers(momentaryMarker);
      final id = DateTime.now().microsecondsSinceEpoch.toString();
      final marketId = MarkerId(id);
      final marker = Marker(
        markerId: marketId,
        position: LatLng(
          position.latitude,
          position.longitude,
        ),
      );
      userPosition[marketId] = marker;

      controller.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude),
        ),
      );
      momentaryMarker = {};
      setMarkers(userPosition);
    }
    if (showCurrentLocation == true) {
      clearMarkers(userPosition);
    }
    showCurrentLocation = !showCurrentLocation;
    clearMarkers(momentaryMarker);
  }

  disposeInfoController() {
    _customInfoWindowController.dispose();
  }

  Set<Circle> buildCircle(Color fillColor) {
    return {
      Circle(
        circleId: const CircleId('d7d02a51-a69a-4fed-b7da-47b011f7f59e'),
        // center: LatLng(position.latitude, position.longitude),
        center: momentaryMarker.isEmpty
            ? userPosition.isEmpty
                ? LatLng(position.latitude, position.longitude)
                : userPosition.values.first.position
            : momentaryMarker.values.first.position,

        radius: _distanceNearYou,
        strokeWidth: 2,
        fillColor: fillColor.withOpacity(.15),
        strokeColor: fillColor,
      ),
    };
  }

  void putMarker(LatLng position) {
    if (showCurrentLocation == true) {
      clearMarkers(userPosition);
    }
    showCurrentLocation = false;
    clearMarkers(momentaryMarker);

    var markerId = MarkerId(DateTime.now().microsecondsSinceEpoch.toString());
    var marker = Marker(markerId: markerId, position: position);

    momentaryMarker = {
      markerId: marker,
    };

    setMarkers(momentaryMarker);

    if (_nearYou) {
      clearMarkers(busStopsMap);
      setNearMarkers(busStops);
    }
    // notifyListeners();
  }
}
