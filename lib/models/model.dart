import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Model {
  final IconData icon;
  final double iconSize;
  final String title;
  final String? subTitle;
  final bool? isFavorite;

  Model({
    this.icon = FontAwesomeIcons.bus,
    this.iconSize = 25,
    required this.title,
    this.subTitle,
    this.isFavorite,
  });
}
