import 'package:flutter/material.dart';
import 'package:jai_kisan/components/graph.dart';
import 'package:jai_kisan/components/my_drawer.dart';
import 'package:jai_kisan/components/homepage_card.dart';
import 'package:jai_kisan/authentication/auth_service.dart';
import 'package:jai_kisan/components/live_bar.dart'; // Replace with the actual path to your LiveRunningBar widget

class HomePageHi extends StatefulWidget {
  const HomePageHi({Key? key}) : super(key: key);

  @override
  _HomePageHiState createState() => _HomePageHiState();
}

class _HomePageHiState extends State<HomePageHi> {
  // logout function
  void logout() {
    // implement logout here
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('हरित क्रांति'),

        actions: [
          // logout button
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        foregroundColor: Theme.of(context).colorScheme.background,
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30,
              color: Theme.of(context).colorScheme.primary,
              child: const LiveRunningBar(
                price: 60,
              ),
            ),
            const Center(
              child: CardWidget(),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                "पिछले 7 दिनों का डेटा: ",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              color: Colors.black12,
              width: MediaQuery.of(context).size.width,
              child: const LineChartWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
