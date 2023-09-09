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
    bool buses = busProvider.isActive;
    bool ventas = colorProvider.isActive;
    return PopupMenuButton(
      splashRadius: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.zero,
      offset: const Offset(30, 0),
      tooltip: '',
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            padding: EdgeInsets.zero,
            child: StatefulBuilder(
              builder: (context, setState) {
                return CheckboxListTile(
                  value: buses,
                  title: const Text('Paradas de buses'),
                  activeColor: colorProvider.appColor,
                  onChanged: (_) {
                    busProvider.isActive = !busProvider.isActive;

                    if (busProvider.isActive) {
                      busProvider.getBusStops();
                    } else {
                      busProvider.clearBusStops();
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
                  title: const Text('Puntos de ventas'),
                  activeColor: colorProvider.appColor,
                  value: ventas,
                  onChanged: (_) {
                    colorProvider.isActive = !colorProvider.isActive;
                    setState(() => ventas = colorProvider.isActive);
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
