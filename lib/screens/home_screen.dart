import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/color_provider.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorProvider.appColor,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/jaha-logo.png',
          height: 55,
        ),
      ),
      body: const CustomMap(),
      floatingActionButton: const CustomFloatingActionButtom(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
