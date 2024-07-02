import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final db = FirebaseFirestore.instance;

  String? userID;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userID = ModalRoute.of(context)?.settings.arguments as String?;
  }

  Future<String>? _futureUserName;

  Future<String> fetchUserName() async {
    try {
      final user = await db.collection('Users').doc(userID).get().then((querySnapshot) => querySnapshot.data());
      return user!['fullName'];
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userID = ModalRoute.of(context)?.settings.arguments as String?;

    _futureUserName = fetchUserName();

    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.orange[800],
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('User Dashboard'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                // the user's name
                if (_futureUserName != null)
                  FutureBuilder<String>(
                    future: _futureUserName,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final userName = snapshot.data!;

                        return Text('Halo, $userName', style: const TextStyle(color: Colors.black, fontSize: 20),);
                      } else {
                        return const Center(child: Text('No user found'));
                      }
                    },
                  ),

                // button to go to home page
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home_page');
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.home, color: Colors.black,),
                      Text('Go to Home Page', style: TextStyle(color: Colors.black, fontSize: 20),),
                    ],
                  ),
                ),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // section for user to book a service
                const SizedBox(height: 20,),
                const Text('Book a service below', style: TextStyle(fontSize: 20),),
                const SizedBox(height: 5,),
                SizedBox(
                  width: 100,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/reservation_page');
                    },
                    child: const Row(children: [Icon(Icons.paste, color: Colors.black,), Text('Here', style: TextStyle(color: Colors.black),)],),
                  ),
                ),

                // section for user to see their reservation histories
                const SizedBox(height: 20,),
                const Text('History of your services', style: TextStyle(fontSize: 20),),
                const SizedBox(height: 10,),
                FutureBuilder(
                    future: db.collection('Users').doc(userID).collection('Services').get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                      } else if (snapshot.hasData) {
                        if (snapshot.data!.size > 0) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: snapshot.data!.docs.map((service) {
                              String time = (service.data()['date'] as Timestamp).toDate().toString();
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black, style: BorderStyle.solid),
                                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(service.data()['service'], style: const TextStyle(fontSize: 20),),
                                      const SizedBox(height: 5,),
                                      Text(time.substring(0, time.length-4), style: const TextStyle(fontSize: 20),),
                                      const SizedBox(height: 10,),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        } else {
                          return const Text('Haven\t made reservation');
                        }
                      } else {
                        return const Text('Haven\t made reservation');
                      }
                      return const SizedBox(height: 0,);
                    }
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
