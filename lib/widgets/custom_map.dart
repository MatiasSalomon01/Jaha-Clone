import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

class CustomMap extends StatelessWidget {
  const CustomMap({super.key});

  @override
  Widget build(BuildContext context) {
    final busProvider = Provider.of<BusProvider>(context);
    return GoogleMap(
      zoomControlsEnabled: false,
      initialCameraPosition: busProvider.initialPosition,
      markers: busProvider.busStops,
    );
  }
}
