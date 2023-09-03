import 'package:ans_map_project/colors/colors.dart';
import 'package:ans_map_project/models/models.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final Model model;
  final double verticalPadding;
  const CustomTile({super.key, required this.model, this.verticalPadding = 0});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding:
              EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 20),
          minLeadingWidth: 0,
          leading: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Icon(
              model.icon,
              color: white,
              size: model.iconSize,
            ),
          ),
          title: Text(
            model.title,
            style: const TextStyle(color: white, fontSize: 20),
          ),
          subtitle: model.subTitle == null
              ? null
              : Text(
                  model.subTitle!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: white),
                ),
          trailing: model.isFavorite == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(
                    model.isFavorite!
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: white,
                    size: 30,
                  ),
                ),
        ),
        Container(
          height: 2,
          color: white,
        ),
      ],
    );
  }
}
