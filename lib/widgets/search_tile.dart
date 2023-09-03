import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../colors/colors.dart';

class SearchTile extends StatelessWidget {
  const SearchTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      leading: const Icon(
        FontAwesomeIcons.magnifyingGlass,
        color: white,
        size: 22,
      ),
      title: TextFormField(
        style: const TextStyle(color: white, fontSize: 22),
        cursorColor: grey,
        decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: transparent),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: transparent),
          ),
          hintText: 'Filtrar por empresa',
          hintStyle: TextStyle(color: white, fontSize: 22),
        ),
      ),
    );
  }
}
