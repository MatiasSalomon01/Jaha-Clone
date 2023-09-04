import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../colors/colors.dart';
import '../providers/color_provider.dart';

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
