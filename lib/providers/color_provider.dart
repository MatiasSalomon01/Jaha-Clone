import 'package:flutter/material.dart';

class ColorProvider extends ChangeNotifier {
  Color appColor;
  bool isActive = false;
  ColorProvider({required this.appColor});
}
