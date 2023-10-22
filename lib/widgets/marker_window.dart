import 'package:ans_map_project/providers/bus_provider.dart';
import 'package:ans_map_project/providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarkerWindow extends StatelessWidget {
  final List<String> content;

  const MarkerWindow({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final busProvider = Provider.of<BusProvider>(context);
    return Container(
      // padding: const EdgeInsets.only(top: 5, right: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: colorProvider.appColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        // padding: const EdgeInsets.only(bottom: 10),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowIndicator();
                  return true;
                },
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 5),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: content
                          .map((paragraph) => Text(' • $paragraph'))
                          .toList(),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 5,
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
