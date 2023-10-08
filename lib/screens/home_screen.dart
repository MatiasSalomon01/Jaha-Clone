import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/color_provider.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool favorite = false;
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
        actions: [
          PopupMenuButton(
            splashRadius: 40,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.zero,
            offset: const Offset(0, 45),
            tooltip: '',
            child: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.favorite,
                // color: Colors.red,
              ),
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  padding: EdgeInsets.zero,
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return CheckboxListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 15),
                        value: favorite,
                        title: const Text(
                          'Paradas favoritas',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        activeColor: colorProvider.appColor,
                        onChanged: (_) async {
                          setState(() => favorite = !favorite);
                        },
                      );
                    },
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: const CustomMap(),
      floatingActionButton: const CustomFloatingActionButtom(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
