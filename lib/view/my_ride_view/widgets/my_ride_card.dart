import 'package:flutter/material.dart';
import 'package:smride_app/model/accepted_ride_model.dart';
import 'package:smride_app/utils/utils.dart';

Widget myRideCard(BuildContext context, AcceptedRide ride) {
  return Card(
    elevation: 2,
    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    child: ExpansionTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage("assets/accountAvatar.jpg"),
        radius: 25,
      ),
      title: ListTile(
        title: Text(
          ride.acceptedDriverName,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        subtitle: Text(ride.destination + " : " + ride.time),
      ),
      trailing: Container(
        child: Text(
          ride.rate + " Rs",
          style: TextStyle(
            color: Colors.green,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      children: <Widget>[
        ListTile(
            leading: Icon(
              Icons.phone,
              color: Colors.green,
            ),
            title: GestureDetector(child: Text(ride.acceptedDriverNumber)),
            onTap: () => Util.openPhone(ride.acceptedDriverNumber))
      ],
    ),
  );
}
