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
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
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
                        child:
                            Icon(FontAwesomeIcons.solidTrashCan, color: white),
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
