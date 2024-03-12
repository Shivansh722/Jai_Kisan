import 'package:flutter/material.dart';
import 'package:jai_kisan/components/graph.dart';
import 'package:jai_kisan/components/my_drawer.dart';
import 'package:jai_kisan/components/homepage_card.dart';
import 'package:jai_kisan/authentication/auth_service.dart';
import 'package:jai_kisan/components/live_bar.dart'; // Replace with the actual path to your LiveRunningBar widget

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Logout function
  void logout() {
    // Implement logout here
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grow Green'),
        actions: [
          // Logout button
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30, // Set the desired height for the header
              color: Theme.of(context).colorScheme.primary, // Change color as needed
              child: const LiveRunningBar(
                price: 60,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Commodity text
                  const Text(
                    'Commodities',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // First row of circular images with names
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildCircularImage('wheat.jpg', 'Wheat'),
                      buildCircularImage('paddy.jpg', 'Paddy'),
                      buildCircularImage('ragi.jpg', 'Ragi'),
                      buildCircularImage('tomato.jpg', 'Tomato'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // Second row of circular images with names
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildCircularImage('potato.jpg', 'Potato'),
                      buildCircularImage('millet.jpg', 'Millet'),
                      buildCircularImage('mustered seexc.jpg', 'Mustered'),
                      buildCircularImage('wheat.jpg', 'Wheat'),
                    ],
                  ),
                  SizedBox(height: 15),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Show More",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  // Pressable text field with icons
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to another page
                        // Add your navigation logic here
                      },
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          const SizedBox(width: 8),
                          Text(
                            "Current Day Price",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.filter_list),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Center(
                    child: CardWidget(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Past 7 days data: ",
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
          ],
        ),
      ),
    );
  }

  Widget buildCircularImage(String assetName, String commodityName) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('lib/assets/$assetName'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          commodityName,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
