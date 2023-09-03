import 'package:ans_map_project/screens/screens.dart';
import 'package:flutter/material.dart';

class Routes {
  // ignore: non_constant_identifier_names
  static String HOME = 'home';
  // ignore: non_constant_identifier_names
  static String BUSES = 'buses';
  // ignore: non_constant_identifier_names
  static String CARD = 'card';
  // ignore: non_constant_identifier_names
  static String PERSON = 'person';

  static Map<String, Widget Function(BuildContext)> buildRoutes(
      BuildContext context) {
    return {
      HOME: (context) => const HomeScreen(),
      BUSES: (context) => const BusesScreen(),
      CARD: (context) => const CardScreen(),
      PERSON: (context) => const PersonScreen(),
    };
  }
}
