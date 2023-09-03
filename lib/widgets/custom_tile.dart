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
          leading: model.title.startsWith('Eliminar')
              ? const Padding(
                  padding: EdgeInsets.only(right: 0),
                  child: Icon(
                    Icons.credit_card_off,
                    color: white,
                    size: 27,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Icon(
                    model.icon,
                    color: white,
                    size: model.iconSize,
                  ),
                ),
          title: Padding(
            padding: EdgeInsets.only(
                left: model.title.startsWith('Eliminar') ? 0 : 5),
            child: Text(
              model.title,
              style: const TextStyle(color: white, fontSize: 20),
            ),
          ),
          subtitle: model.subTitle == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    model.subTitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: white),
                  ),
                ),
          trailing: model.isFavorite == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(right: 10),
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
