import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:async';

class SalePointsProvider extends ChangeNotifier {
  late final String _jsonString;

  final Map<MarkerId, Marker> _salePoints = {};
  Set<Marker> get salePoints => _salePoints.values.toSet();
  Map<MarkerId, Marker> get salePointsMap => _salePoints;

  bool isActive = false;
  bool isLoading = false;

  final _salePointIcon = Completer<BitmapDescriptor>();

  SalePointsProvider() {
    loadJsonData();
    assetsToBytes('assets/sale-point.png', width: 150).then((value) {
      final bitMap = BitmapDescriptor.fromBytes(value);
      _salePointIcon.complete(bitMap);
    });
  }

  Future<void> getSalePoints() async {
    final List<dynamic> data = json.decode(_jsonString);

    for (var i in data) {
      final Map<String, dynamic> coordenates = i;

      final position = LatLng(
        coordenates['latitude'],
        coordenates['longitude'],
      );

      final id = DateTime.now().microsecondsSinceEpoch.toString();
      final marketId = MarkerId(id);
      final icon = await _salePointIcon.future;
      final marker = Marker(markerId: marketId, position: position, icon: icon);

      _salePoints[marketId] = marker;
    }
    notifyListeners();
  }

  void clearSalePoints() {
    _salePoints.clear();
    notifyListeners();
  }

  Future<void> loadJsonData() async =>
      _jsonString = await rootBundle.loadString('lib/data/sale-points.json');

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
