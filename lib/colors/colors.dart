import 'dart:math';

import 'package:flutter/material.dart';

const black = Colors.black;
const grey = Colors.grey;
const white = Colors.white;
const transparent = Colors.transparent;
const yellow = Color(0xfffdc52c);
const green = Color(0xff6abf4a);
const purple = Color(0xffa55a95);
const lightBlue = Color(0xff00c2de);
const colors = [yellow, green, purple, lightBlue];

Color getRandomColor() => colors[Random().nextInt(colors.length)];
