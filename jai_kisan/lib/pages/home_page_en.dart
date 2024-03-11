import 'package:flutter/material.dart';
import 'package:jai_kisan/components/graph.dart';
import 'package:jai_kisan/components/live_bar.dart';
import 'package:jai_kisan/components/my_drawer.dart';
import 'package:jai_kisan/components/homepage_card.dart';
import 'package:jai_kisan/authentication/auth_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();

  // Logout function
  void logout() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.growGreen),
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
        centerTitle: true,
        backgroundColor: Colors.green.shade300,
        foregroundColor: Colors.white,
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30,
              color: Colors.green.shade300,
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
              child: Text(
                AppLocalizations.of(context)!.past7DaysData,
                style: const TextStyle(
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