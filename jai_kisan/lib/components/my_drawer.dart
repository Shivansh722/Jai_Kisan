import 'package:flutter/material.dart';
import 'package:jai_kisan/pages/form_page.dart';
import 'package:jai_kisan/pages/news_page.dart';
import 'package:jai_kisan/pages/soil_page.dart';
import 'package:jai_kisan/pages/plant_image.dart';
import 'package:jai_kisan/pages/weather_page.dart';
import 'package:jai_kisan/pages/prediction_page.dart';
import 'package:jai_kisan/authentication/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  void logout(BuildContext context) {
    final auth = AuthService();
    auth.signOut();
    // After logging out, you may want to navigate to the login or home screen
    // Example:
    // Replace '/login' with your login screen route
  }

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final currentDateTime = DateTime.now();

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          SizedBox(
            height: 250,
            child: UserAccountsDrawerHeader(
              accountEmail: Text(authService.auth.currentUser?.email ??
                      '' // Set font color to black
                  ),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('lib/assets/farmer.jpg'),
              ),
              accountName: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${currentDateTime.day}/${currentDateTime.month}/${currentDateTime.year}\n${currentDateTime.hour}:${currentDateTime.minute}',
                    style: const TextStyle(fontSize: 8, color: Colors.black),
                  ),
                  const Text(
                    'Zorawar Sayyid Mohammed',
                    style: TextStyle(
                        color: Colors.black), // Set font color to black
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),

          ListTile(
            title: const Text('H O M E'),
            leading: const Icon(Icons.home),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: const Text('P R E D I C T I O N'),
            leading: const Icon(Icons.batch_prediction),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PredictionPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('F E E D B A C K'),
            leading: const Icon(Icons.analytics),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MarketSurveyScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('NEWS'),
            leading: const Icon(Icons.newspaper),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsPage(),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text('LEAF DISEASE DETECTION'),
              leading: const Icon(Icons.energy_savings_leaf),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImagePickerPage(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text('WEATHER'),
              leading: const Icon(Icons.cloud),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WeatherPage(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text('Soil Detection'),
              leading: const Icon(Icons.terrain),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SoilPage(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
              onTap: () {
                Navigator.pop(context);
                logout(context);
              },
            ),
          ),
          // Add more ListTile items here as needed
        ],
      ),
    );
  }
}
