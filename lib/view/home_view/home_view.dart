import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smride_app/utils/routes/routes_name.dart';
import 'package:smride_app/view_model/auth_view_model.dart';
import 'find_ride_view/find_ride_view.dart.dart';
import 'offer_ride_view/offer_ride_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Bottom navigation bar
  int _currentIndex = 0;

  void onTabTapped(int index) {
    if (index == 1) Navigator.pushNamed(context, RoutesName.myRides);
    if (index == 2) Navigator.pushNamed(context, RoutesName.myRequest);
  }

  @override
  void initState() {
    super.initState();
    context.read<AuthViewModel>().getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // AppBar
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(RoutesName.profile);
            },
            child: Padding(
                padding: EdgeInsets.all(12),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/accountAvatar.jpg"),
                )),
          ),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (val) {
                if (val == 1) {
                  //navigate to credits page
                  Navigator.of(context).pushNamed(RoutesName.credits);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text("Credits"),
                )
              ],
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.phone_android,
                  color: Colors.white,
                ),
                text: "Find Ride",
              ),
              Tab(
                icon: Icon(
                  Icons.local_taxi,
                  color: Colors.white,
                ),
                text: "Offer Ride",
              )
            ],
          ),
          title: Text("SM Ride"),
        ),
        body: TabBarView(
          children: <Widget>[
            // Find a Ride
            FindaRide(),
            // Offer Ride
            OfferRide(),
          ],
        ),
        // Bottom Navigation
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          selectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.directions_bike), label: "My Rides"),
            BottomNavigationBarItem(
                icon: Icon(Icons.class_), label: "My Requests"),
          ],
        ),
      ),
    );
  }
}
