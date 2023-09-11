import 'package:ans_map_project/colors/colors.dart';
import 'package:ans_map_project/providers/providers.dart';
import 'package:ans_map_project/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var isEnabled = await Location.getUserPosition();
  runApp(AppState(isEnabled: isEnabled));
}

class AppState extends StatelessWidget {
  final bool isEnabled;
  const AppState({super.key, required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    final color = getRandomColor();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ColorProvider(appColor: color),
        ),
        ChangeNotifierProvider(create: (context) => BusProvider()),
        ChangeNotifierProvider(create: (context) => SalePointsProvider())
      ],
      child: MainApp(isEnabled: isEnabled),
    );
  }
}

class MainApp extends StatelessWidget {
  final bool isEnabled;
  const MainApp({super.key, required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: Routes.buildRoutes(context),
      initialRoute: Routes.SPLASH,
    );
  }
}
