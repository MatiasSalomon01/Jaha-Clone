import 'package:ans_map_project/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../overrides/slider_custom_track_shape.dart';
import '../../providers/bus_provider.dart';
import '../../providers/color_provider.dart';
import '../../providers/sale_points_provider.dart';
import '../custom_slider.dart';

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
            child: const Text(
              'Ok',
              style: TextStyle(
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
