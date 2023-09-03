import 'package:flutter/material.dart';

import '../colors/colors.dart';

class CustomFloatingActionButtom extends StatelessWidget {
  const CustomFloatingActionButtom({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(highlightColor: white.withOpacity(.2)),
      child: FloatingActionButton(
        splashColor: transparent,
        backgroundColor: yellow,
        highlightElevation: 1,
        elevation: 0,
        onPressed: () {},
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
