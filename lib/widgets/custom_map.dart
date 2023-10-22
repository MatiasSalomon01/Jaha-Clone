import 'package:custom_info_window/custom_info_window.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({super.key});

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  @override
  void dispose() {
    Provider.of<BusProvider>(context, listen: false).disposeInfoController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final busProvider = Provider.of<BusProvider>(context);
    final colorProvider = Provider.of<ColorProvider>(context);
    return Stack(
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
          initialCameraPosition: busProvider.initialPosition(),
          markers: busProvider.markers,
          onMapCreated: (controller) {
            busProvider.customInfoWindowController.googleMapController =
                controller;
            busProvider.controller = controller;
          },
          onTap: (argument) {
            busProvider.putMarker(argument);
            busProvider.customInfoWindowController.hideInfoWindow!();
          },
          onCameraMove: (position) =>
              busProvider.customInfoWindowController.hideInfoWindow!(),
          circles: busProvider.nearYou
              ? busProvider.buildCircle(colorProvider.appColor)
              : {},
        ),
        CustomInfoWindow(
          controller: busProvider.customInfoWindowController,
          height: 75,
          width: 150,
          offset: 55,
        )
      ],
    );
  }
}
