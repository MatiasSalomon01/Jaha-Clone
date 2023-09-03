import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../colors/colors.dart';
import '../providers/color_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    return AppBar(
      backgroundColor: colorProvider.appColor,
      elevation: 0,
      centerTitle: true,
      title: Image.asset(
        'assets/jaha-logo.png',
        height: 55,
      ),
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: CircleAvatar(
              backgroundColor: white,
              radius: 14,
              child: Icon(
                Icons.arrow_back,
                color: colorProvider.appColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
