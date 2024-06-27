import 'package:flutter/material.dart';
import '../util/font_style.dart';

class MobileFirstView extends StatelessWidget {
  const MobileFirstView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          width: currentWidth,
          height: currentWidth * (768 / 1344),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/scene_of_a_salon.jpg'),
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: IntrinsicHeight(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.black12,
              ),
              padding: const EdgeInsets.all(5),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Let\'s find out',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Scroll down and explore our salon',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.arrow_circle_down_rounded, size: 30,),
                ],
              ),
            ),
          ),
        ),

        // for title and slogan
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          alignment: Alignment.topCenter,
          width: double.maxFinite,
          color: Colors.orange[700],
          child: const Column(children: [
            BigTitle(text: 'SEA SALON'),
            Text('Beauty and Elegance Redefined',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ))
          ]),
        ),
      ],
    );
  }
}
