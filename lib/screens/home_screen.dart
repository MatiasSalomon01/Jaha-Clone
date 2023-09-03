import 'package:flutter/material.dart';
import '../colors/colors.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellow,
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
