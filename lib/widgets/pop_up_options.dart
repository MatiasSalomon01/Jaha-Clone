import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/color_provider.dart';

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
    bool buses = false;
    bool ventas = false;
    return PopupMenuButton(
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
                  onChanged: (value) => setState(() => buses = value!),
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
                  onChanged: (value) => setState(() => ventas = value!),
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
