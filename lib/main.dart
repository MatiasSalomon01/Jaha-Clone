import 'package:ans_map_project/colors/colors.dart';
import 'package:ans_map_project/providers/color_provider.dart';
import 'package:ans_map_project/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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
        )
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