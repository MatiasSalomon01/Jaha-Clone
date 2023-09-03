import 'dart:math';

import 'package:flutter/material.dart';

const transparent = Colors.transparent;
const yellow = Color(0xfffdc52c);
const white = Colors.white;
const grey = Colors.grey;
const green = Color(0xff6abf4a);
const purple = Color(0xffa55a95);
const blue = Color(0xff008fbe);
const colors = [yellow, green, purple, blue];

Color getRandomColor() => colors[Random().nextInt(colors.length)];
