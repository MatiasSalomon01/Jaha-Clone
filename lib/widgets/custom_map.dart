import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class CustomMap extends StatelessWidget {
  const CustomMap({super.key});

  @override
  Widget build(BuildContext context) {
    return const GoogleMap(
      zoomControlsEnabled: false,
      initialCameraPosition: CameraPosition(
        target: LatLng(-25.263978, -57.576177),
        zoom: 14,
      ),
    );
  }
}
