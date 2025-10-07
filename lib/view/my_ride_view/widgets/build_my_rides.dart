import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smride_app/view/my_ride_view/widgets/my_ride_card.dart';
import 'package:smride_app/model/accepted_ride_model.dart';
import 'package:smride_app/view_model/home_view_model.dart';

Widget buildMyRidesList(BuildContext context) {
  List<AcceptedRide> myRides = context.read<HomeViewModel>().myRides.data;
  return RefreshIndicator(
    onRefresh: context.read<HomeViewModel>().fetchMyRides,
    child: myRides.isNotEmpty
        ? ListView.builder(
            itemCount: myRides.length,
            itemBuilder: (BuildContext context, int index) {
              return myRideCard(context, myRides[index]);
            },
          )
        : ListView(
            physics:
                const AlwaysScrollableScrollPhysics(), // ensures scroll even if no items
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.8, // to center the text vertically
                child: Center(
                  child: Text(
                    "No Requests",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
  );
}
