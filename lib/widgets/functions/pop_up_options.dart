import 'package:ans_map_project/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/bus_provider.dart';
import '../../providers/color_provider.dart';
import '../../providers/sale_points_provider.dart';

Future<dynamic> popUpOptions(
    BuildContext context,
    Size size,
    ColorProvider colorProvider,
    bool nearYou,
    BusProvider busProvider,
    bool buses,
    bool ventas,
    SalePointsProvider salePointsProvider) {
  return showMenu(
    context: context,
    position: RelativeRect.fromLTRB(150, size.height, 150, 0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    items: [
      PopupMenuItem(
        padding: EdgeInsets.zero,
        child: StatefulBuilder(
          builder: (context, setState) {
            return Theme(
              data: ThemeData(
                checkboxTheme: CheckboxThemeData(
                  fillColor: MaterialStateProperty.all(colorProvider.appColor),
                  overlayColor: MaterialStateProperty.all(Colors.purple),
                  splashRadius: 10,
                  side: const BorderSide(color: Colors.black54, width: 2),
                ),
              ),
              child: CheckboxMenuButton(
                style: ButtonStyle(
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                value: nearYou,
                onChanged: (_) {
                  busProvider.nearYou = !busProvider.nearYou;
                  setState(() => nearYou = busProvider.nearYou);
                },
                trailingIcon: MaterialButton(
                  minWidth: 0,
                  padding: const EdgeInsets.all(8),
                  onPressed: () => modalNearYou(context),
                  highlightColor: Colors.black12,
                  shape: const CircleBorder(),
                  child: const Icon(Icons.more_vert),
                ),
                child: const Text(
                  'Cercanos a ti',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      PopupMenuItem(
        padding: EdgeInsets.zero,
        child: StatefulBuilder(
          builder: (context, setState) {
            return CheckboxListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              value: buses,
              title: const Text(
                'Paradas de buses',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              activeColor: colorProvider.appColor,
              onChanged: (_) async {
                busProvider.isActive = !busProvider.isActive;

                if (busProvider.isActive) {
                  if (busProvider.busStops.isEmpty) {
                    await busProvider.getBusStops();
                  }

                  if (busProvider.nearYou) {
                    busProvider.setNearMarkers(busProvider.busStops);
                  } else {
                    busProvider.setMarkers(busProvider.busStopsMap);
                  }
                } else {
                  busProvider.clearMarkers(busProvider.busStopsMap);
                }
                setState(() => buses = busProvider.isActive);
              },
            );
          },
        ),
      ),
      PopupMenuItem(
        padding: EdgeInsets.zero,
        child: StatefulBuilder(
          builder: (context, setState) {
            return CheckboxListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              title: const Text(
                'Puntos de ventas',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              activeColor: colorProvider.appColor,
              value: ventas,
              onChanged: (_) async {
                salePointsProvider.isActive = !salePointsProvider.isActive;

                if (salePointsProvider.isActive) {
                  if (salePointsProvider.salePoints.isEmpty) {
                    await salePointsProvider.getSalePoints();
                  }

                  if (busProvider.nearYou) {
                    busProvider.setNearMarkers(salePointsProvider.salePoints);
                  } else {
                    busProvider.setMarkers(salePointsProvider.salePointsMap);
                  }
                } else {
                  busProvider.clearMarkers(salePointsProvider.salePointsMap);
                }
                setState(() => ventas = salePointsProvider.isActive);
              },
            );
          },
        ),
      ),
    ],
  );
}

void modalNearYou(
  BuildContext context,
) {
  showDialog(
    context: context,
    useSafeArea: true,
    builder: (context) {
      return AlertDialog(
        content: Container(
          color: white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [CustomSlider()],
          ),
        ),
        actions: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.grey.withOpacity(.1),
              ),
              overlayColor: MaterialStateProperty.all(
                Colors.grey.withOpacity(.4),
              ),
              splashFactory: NoSplash.splashFactory,
            ),
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Ok',
              style: const TextStyle(
                fontSize: 16,
                color: black,
              ),
            ),
          ),
        ],
      );
    },
  );
}

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
              onChanged: (value) {
                setState(() {
                  valor = value;
                });
                busProvider.distanceNearYou = value;
              },
            ),
          ),
        ),
      ],
    );
  }
}

class SliderCustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    super.paint(
      context,
      offset,
      parentBox: parentBox,
      sliderTheme: sliderTheme,
      enableAnimation: enableAnimation,
      textDirection: textDirection,
      thumbCenter: thumbCenter,
      additionalActiveTrackHeight: additionalActiveTrackHeight,
    );
  }

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    const double trackHeight = 5;
    const double trackLeft = 0;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
