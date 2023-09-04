import 'package:ans_map_project/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/color_provider.dart';
import '../widgets/widgets.dart';

class FindLocationScreen extends StatelessWidget {
  const FindLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorProvider.appColor,
      appBar: const CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          SizedBox(
            width: size.width,
            height: 40,
            child: Stack(
              children: const [
                Center(
                  child: Text(
                    '¿Cómo llego?',
                    style: TextStyle(color: white, fontSize: 30),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(FontAwesomeIcons.solidTrashCan, color: white),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Desde:',
              style: TextStyle(color: white, fontSize: 20),
            ),
          ),
          const SizedBox(height: 15),
          const LocationInput(),
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Hasta:',
              style: TextStyle(color: white, fontSize: 20),
            ),
          ),
          const SizedBox(height: 15),
          const LocationInput(),
          const SizedBox(height: 15),
          Container(
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 15)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(width: .5, color: white),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(transparent),
                shadowColor: MaterialStateProperty.all(transparent),
                splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateProperty.all(transparent),
              ),
              onPressed: () {},
              child: const Text(
                'BUSCAR OPCIONES',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ElevatedButton.styleFrom(

//                 padding: EdgeInsets.symmetric(vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 backgroundColor: transparent,
//                 shadowColor: transparent,
//                 splashFactory: NoSplash.splashFactory,
//               ),

class LocationInput extends StatelessWidget {
  const LocationInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        cursorColor: colorProvider.appColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: white,
          prefixIcon: const Icon(
            Icons.my_location,
            color: black,
            size: 28,
          ),
          suffixIcon: const Icon(
            Icons.search,
            color: black,
            size: 30,
          ),
          hintText: 'Dirección, inersección, lugar, etc...',
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
