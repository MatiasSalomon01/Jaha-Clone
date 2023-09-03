import 'package:ans_map_project/data/data.dart';
import 'package:ans_map_project/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../colors/colors.dart';

class BusesScreen extends StatelessWidget {
  const BusesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellow,
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          const SearchTile(),
          Container(
            height: 2,
            color: white,
          ),
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return true;
              },
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: busesData.length,
                itemBuilder: (context, index) => CustomTile(
                  model: busesData[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
