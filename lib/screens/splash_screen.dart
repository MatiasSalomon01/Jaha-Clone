import 'package:ans_map_project/routes/routes.dart';
import 'package:flutter/material.dart';

import '../services/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Location.isEnabled) {
        Navigator.pushNamed(context, Routes.HOME);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('La ubicacion no esta activado'),
      ),
    );
  }
}
