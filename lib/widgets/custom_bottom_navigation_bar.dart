import 'package:ans_map_project/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../colors/colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: transparent,
        highlightColor: white.withOpacity(.2),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        enableFeedback: false,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: white,
        selectedItemColor: white,
        backgroundColor: yellow,
        currentIndex: 0,
        iconSize: 22,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.bus),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.store),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.mapLocationDot),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidCreditCard),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userCheck),
            label: '',
          ),
        ],
        onTap: (value) {
          switch (value) {
            case 0:
              Navigator.pushNamed(context, Routes.BUSES);
              break;
            case 3:
              Navigator.pushNamed(context, Routes.CARD);
              break;
            case 4:
              Navigator.pushNamed(context, Routes.PERSON);
              break;
            default:
          }
        },
      ),
    );
  }
}
