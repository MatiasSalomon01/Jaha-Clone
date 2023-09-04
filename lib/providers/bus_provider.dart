import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

class BusProvider extends ChangeNotifier {
  late final String _jsonString;

  final Map<MarkerId, Marker> _busStops = {};
  Set<Marker> get busStops => _busStops.values.toSet();

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
    final List<dynamic> data = json.decode(_jsonString);

    int count = 0;
    for (var i in data) {
      final Map<String, dynamic> coordenates = i;

      final position = LatLng(
        coordenates['latitude'],
        coordenates['longitude'],
      );

      final id = count.toString();
      final marketId = MarkerId(id);
      final icon = await _busStopIcon.future;
      final marker = Marker(markerId: marketId, position: position, icon: icon);

      _busStops[marketId] = marker;
      count++;
    }
    notifyListeners();
  }

  void clearBusStops() {
    _busStops.clear();
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
}
