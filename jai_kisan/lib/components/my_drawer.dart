import 'package:flutter/material.dart';
import 'package:jai_kisan/components/image_picker.dart';
import 'package:jai_kisan/pages/form_page.dart';
import 'package:jai_kisan/pages/settings_page.dart';
import 'package:jai_kisan/pages/prediction_page.dart';
import 'package:jai_kisan/authentication/auth_service.dart';
import 'package:jai_kisan/pages/weather_page.dart';

class MyDrawer extends StatelessWidget {
  void logout(BuildContext context) {
    final _auth = AuthService();
    _auth.signOut();
    // After logging out, you may want to navigate to the login or home screen
    // Example:
    // Replace '/login' with your login screen route
  }

  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          const DrawerHeader(
            child: Center(
              child: Icon(
                Icons.person,
                size: 60,
              ),
              // Your user profile content goes here
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text('H O M E'),
              leading: const Icon(Icons.home),
              onTap: () => Navigator.pop(context),
            ),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text('LEAF DISEASE DETECTION'),
              leading: const Icon(Icons.energy_savings_leaf),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text('WEATHER'),
              leading: const Icon(Icons.cloud),
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
        ],
      ),
    );
  }
}
