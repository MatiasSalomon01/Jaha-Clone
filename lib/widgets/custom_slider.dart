import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../overrides/slider_custom_track_shape.dart';
import '../providers/bus_provider.dart';
import '../providers/color_provider.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    super.key,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double valor = 0;
  @override
  Widget build(BuildContext context) {
    final busProvider = Provider.of<BusProvider>(context);
    final colorProvider = Provider.of<ColorProvider>(context);
    final size = MediaQuery.of(context).size;
    valor = busProvider.distanceNearYou;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: 'Rango de distancia: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: '${busProvider.distanceNearYou.round()}m',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width,
          child: SliderTheme(
            data: SliderThemeData(trackShape: SliderCustomTrackShape()),
            child: Slider(
              divisions: 10,
              activeColor: colorProvider.appColor,
              value: valor,
              max: 5000,
              onChanged: (value) async {
                setState(() {
                  valor = value;
                });

                // if (value < busProvider.distanceNearYou) {
                //   // busProvider.clearMarkers(busProvider.busStopsMap);
                //   await busProvider.clearNearMarkers(busProvider.busStops);
                //   print('aaaaaaaaaaaaaaaaaaaaaaaa');
                // } else {
                //   busProvider.setNearMarkers(busProvider.busStops);
                //   print('yyyyyyyyyyyyyyyyyyyyyyyyy');
                // }

                busProvider.clearNearMarkers(busProvider.busStops);
                busProvider.distanceNearYou = value;
                busProvider.setNearMarkers(busProvider.busStops);
              },
            ),
          ),
        ),
      ],
    );
  }
}
