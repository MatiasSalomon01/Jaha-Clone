import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

class PopUpOptions extends StatefulWidget {
  const PopUpOptions({
    super.key,
  });

  @override
  State<PopUpOptions> createState() => _PopUpOptionsState();
}

class _PopUpOptionsState extends State<PopUpOptions> {
  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final busProvider = Provider.of<BusProvider>(context);
    final salePointsProvider = Provider.of<SalePointsProvider>(context);
    bool buses = busProvider.isActive;
    bool ventas = salePointsProvider.isActive;
    bool nearYou = busProvider.nearYou;
    return PopupMenuButton(
      splashRadius: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.zero,
      offset: const Offset(30, 0),
      tooltip: '',
      itemBuilder: (context) {
        return <PopupMenuEntry>[
          PopupMenuItem(
            padding: EdgeInsets.zero,
            child: StatefulBuilder(
              builder: (context, setState) {
                return CheckboxListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  value: nearYou,
                  title: const Text(
                    'Cercanos a ti',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  activeColor: colorProvider.appColor,
                  onChanged: (_) async {
                    busProvider.nearYou = !busProvider.nearYou;
                    setState(() => nearYou = busProvider.nearYou);
                  },
                );
              },
            ),
          ),
          const PopupMenuDivider(height: .1),
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
                        busProvider
                            .setNearMarkers(salePointsProvider.salePoints);
                      } else {
                        busProvider
                            .setMarkers(salePointsProvider.salePointsMap);
                      }
                    } else {
                      busProvider
                          .clearMarkers(salePointsProvider.salePointsMap);
                    }
                    setState(() => ventas = salePointsProvider.isActive);
                  },
                );
              },
            ),
          ),
        ];
      },
      child: const Icon(FontAwesomeIcons.store),
    );
  }
}
