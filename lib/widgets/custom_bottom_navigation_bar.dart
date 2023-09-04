import 'package:ans_map_project/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../colors/colors.dart';
import '../providers/color_provider.dart';
import 'widgets.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
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
            icon: PopUpOptions(),
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
            // case 1:
            //   _showOptionsDialog(context);
            //   break;
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

  // void _showOptionsDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierColor: transparent,
  //     builder: (BuildContext context) {
  //       return Padding(
  //         padding: const EdgeInsets.only(bottom: 30),
  //         child: AlertDialog(
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //           insetPadding: EdgeInsets.zero,
  //           contentPadding: EdgeInsets.zero,
  //           alignment: Alignment.bottomRight,
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               CheckboxListTile(
  //                 value: true,
  //                 title: const Text('Paradas de buses'),
  //                 onChanged: (value) {},
  //               ),
  //               CheckboxListTile(
  //                 value: true,
  //                 title: const Text('Paradas de buses'),
  //                 onChanged: (value) {},
  //               ),
  //               CheckboxListTile(
  //                 value: true,
  //                 title: const Text('Paradas de buses'),
  //                 onChanged: (value) {},
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
