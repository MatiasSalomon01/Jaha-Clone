import 'package:flutter/material.dart';

class MarkerWindow extends StatelessWidget {
  const MarkerWindow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Línea 23'),
                Text('Línea 30 azul'),
                Text('Línea 30 amarillo'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
