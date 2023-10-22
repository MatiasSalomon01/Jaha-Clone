import 'package:ans_map_project/providers/bus_provider.dart';
import 'package:ans_map_project/providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarkerWindow extends StatelessWidget {
  const MarkerWindow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final busProvider = Provider.of<BusProvider>(context);
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: colorProvider.appColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: Stack(
          children: [
            ListView(
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
            ),
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () =>
                    busProvider.customInfoWindowController.hideInfoWindow!(),
                child: const Icon(
                  Icons.close,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
