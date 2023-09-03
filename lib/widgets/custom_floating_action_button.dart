import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../colors/colors.dart';
import '../providers/color_provider.dart';

class CustomFloatingActionButtom extends StatelessWidget {
  const CustomFloatingActionButtom({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    return Theme(
      data: Theme.of(context).copyWith(highlightColor: white.withOpacity(.2)),
      child: FloatingActionButton(
        splashColor: transparent,
        backgroundColor: colorProvider.appColor,
        highlightElevation: 1,
        elevation: 0,
        onPressed: () {},
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
