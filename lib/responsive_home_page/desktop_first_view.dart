import 'package:flutter/material.dart';
import 'package:salon_app/util/font_style.dart';
// import '../util/font_style.dart';

class DesktopFirstView extends StatelessWidget {
  const DesktopFirstView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentHeight = MediaQuery.of(context).size.height;

    return Container(
      height: currentHeight,
      alignment: Alignment.bottomRight,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/scene_of_a_salon.jpg'),
      )),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
        ),
        width: 300,
        height: 150,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigTitle(text: 'SEA SALON'),
            Text('Beauty and Elegance Redefined',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ))
          ],
        ),
      ),
    );
  }
}
