import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
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

  final CameraPosition initialPosition = const CameraPosition(
    target: LatLng(-25.263978, -57.576177),
    zoom: 14,
  );

  final _busStopIcon = Completer<BitmapDescriptor>();

  bool isActive = false;

  BusProvider() {
    loadJsonData();
    assetsToBytes('assets/bus-stop.png', width: 150).then((value) {
      final bitMap = BitmapDescriptor.fromBytes(value);
      _busStopIcon.complete(bitMap);
    });
  }

  Future<void> getBusStops() async {
    print('asdasdasdsa');
    final List<dynamic> data = json.decode(_jsonString);

    for (var i in data) {
      final Map<String, dynamic> coordenates = i;

      final position = LatLng(
        coordenates['latitude'],
        coordenates['longitude'],
      );

      final id = DateTime.now().microsecondsSinceEpoch.toString();
      final marketId = MarkerId(id);
      final icon = await _busStopIcon.future;
      final marker = Marker(markerId: marketId, position: position, icon: icon);

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

  void addRange(Map<MarkerId, Marker> markers) {
    // var tempMap = <MarkerId, Marker>{};
    for (var element in markers.entries) {
      // tempMap[element.key] = element.value;
      _markers.putIfAbsent(element.key, () => element.value);
      notifyListeners();
    }
    // if (_markers.isNotEmpty) {
    //   print('Total antes de insertar: ${_markers.length}');
    //   _markers.addAll(tempMap);
    //   print('Total despues de insertar: ${_markers.length}');
    //   notifyListeners();
    //   return;
    // }
    // _markers = tempMap;
  }
}
