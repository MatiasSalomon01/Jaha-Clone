import 'package:ans_map_project/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../colors/colors.dart';
import '../providers/bus_provider.dart';
import '../providers/color_provider.dart';
import '../providers/sale_points_provider.dart';
import 'functions/pop_up_options.dart';
import 'widgets.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final size = MediaQuery.of(context).size;
    final busProvider = Provider.of<BusProvider>(context);
    final salePointsProvider = Provider.of<SalePointsProvider>(context);
    bool buses = busProvider.isActive;
    bool ventas = salePointsProvider.isActive;
    bool nearYou = busProvider.nearYou;
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: transparent,
        highlightColor: white.withOpacity(.2),
      ),
      child: BottomNavigationBar(
        backgroundColor: colorProvider.appColor,
        type: BottomNavigationBarType.fixed,
        enableFeedback: false,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: white,
        selectedItemColor: white,
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
            case 1:
              popUpOptions(
                context,
                size,
                colorProvider,
                nearYou,
                busProvider,
                buses,
                ventas,
                salePointsProvider,
              );
              break;
            case 2:
              Navigator.pushNamed(context, Routes.LOCATION);
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
