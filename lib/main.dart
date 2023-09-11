import 'package:ans_map_project/colors/colors.dart';
import 'package:ans_map_project/providers/providers.dart';
import 'package:ans_map_project/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Location.getUserPosition();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

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
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: Routes.buildRoutes(context),
      initialRoute: Routes.HOME,
    );
  }
}
