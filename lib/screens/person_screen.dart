import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../colors/colors.dart';
import '../data/data.dart';
import '../providers/color_provider.dart';
import '../widgets/widgets.dart';

class PersonScreen extends StatelessWidget {
  const PersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    return Scaffold(
      backgroundColor: colorProvider.appColor,
      appBar: const CustomAppBar(),
      body: Column(
        children: [
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
                itemCount: personData.length,
                itemBuilder: (context, index) => CustomTile(
                  model: personData[index],
                  verticalPadding: 5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
