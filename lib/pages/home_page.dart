import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:salon_app/responsive/responsive_layout.dart';
import 'package:salon_app/util/pop_up.dart';
import '../responsive/desktop_first_view.dart';
import '../responsive/mobile_first_view.dart';
import '../util/section.dart';
import '../util/font_style.dart';
import '../util/var.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myController = TextEditingController();
  int starRating = 0;
  String review = '';
  int initialRatingValue = 0;

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void resetRating() {
    setState(() {
      starRating = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    // final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.orange,
        body: ListView(
          children: [
            // the immediate view of the page
            const ResponsiveLayout(
                mobileFirstView: MobileFirstView(),
                desktopFirstView: DesktopFirstView()),

            // for services
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              child: Column(
                children: [
                  const SectionTitle(text: 'Services'),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    direction: Axis.vertical,
                    spacing: 10,
                    children: [
                      ServiceCard(
                          desc: servicesDescription[0],
                          serviceName: services[0],
                          image: 'images/styling_hair_salon.jpg'),
                      ServiceCard(
                          desc: servicesDescription[1],
                          serviceName: services[1],
                          image: 'images/manicure_salon.jpg'),
                      ServiceCard(
                          desc: servicesDescription[2],
                          serviceName: services[2],
                          image: 'images/facial_treatment_salon.jpg'),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            const Divider(indent: 80, endIndent: 80, color: Colors.black, thickness: 1.3,),

            // section for directing user to reservation page
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                child: Column(
                  children: [
                    const Text(
                      'Ready to book our service?',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {Navigator.pushNamed(context, '/reservation_page');},
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.orangeAccent[100]),
                        padding: WidgetStateProperty.all(const EdgeInsets.all(15)),
                      ),
                      child: const Text(
                        'Click here to book',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ]
                ),
              ),
            ),

            const Divider(indent: 80, endIndent: 80, color: Colors.black, thickness: 1.3,),

            const SizedBox(
              height: 10,
            ),

            // for review
            Column(
              children: [
                const SectionTitle(text: 'Review'),
                const Text(
                  'What do you think about our salon?',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RatingBar.builder(
                    initialRating: double.parse('$starRating'),
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.black,
                        ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        starRating = int.parse('$rating');
                      });
                    }
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: currentWidth / 7,
                  width: currentWidth / 1.9,
                  child: TextField(
                    controller: myController,
                    expands: true,
                    minLines: null,
                    maxLines: null,
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.white60,
                      filled: true,
                      labelText: 'State your review here ...',
                    ),
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Colors.orangeAccent[100]),
                  ),
                  onPressed: () {
                    review = myController.text;
                    if (review != '' && starRating != 0) {
                      showPopUpSubmittedReview(context, starRating);
                      final dataReview = <String, dynamic> {
                        'review': review,
                        'starRating': starRating,
                      };
                      db.collection('Reviews').add(dataReview);
                      resetRating();
                      myController.clear();
                    } else {
                      showPopUpSubmittedReview(context, 0);
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            // for footer/contact
            Container(
              padding: const EdgeInsets.all(25),
              width: double.maxFinite,
              color: Colors.orange[900],
              alignment: Alignment.bottomRight,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('For more information: '),
                  Text('08123456789 (Thomas)'),
                  Text('08164829372 (Sekar)')
                ],
              ),
            ),
          ],
        ));
  }
}
