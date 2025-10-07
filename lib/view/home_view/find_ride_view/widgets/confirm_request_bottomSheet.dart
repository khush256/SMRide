import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smride_app/utils/utils.dart';
import 'package:smride_app/view_model/home_view_model.dart';

class ConfirmCard extends StatelessWidget {
  final String location;
  final DateTime time;

  ConfirmCard(this.location, this.time);

  //send ride request to server
/*
  void postData(SnackBar snack) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getString('token'));

    String url = AppConstants.requestUrl;
    Map<String, String> rideRequest = {
      'userId': pref.getString('token') ?? "",
      // "63f6950b-bc65-4d93-be53-f52fdf977034",
      'location': widget.location,
      // 'time': widget.time.toString(),
      'time': DateFormat('hh:mm a').format(widget.time),
    };
    debugPrint(json.encode(rideRequest));

    http
        .post(Uri.parse(url),
            headers: {"Content-Type": "application/json"},
            body: json.encode(rideRequest))
        .then((response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);

      //revert back once response is obtained
      Timer(Duration(seconds: 3), () {
        Navigator.pop(context);
        Navigator.pop(context, snack);
      });
    }).catchError((e) {
      print(e);
    });
  }
*/
/*
  void _confirmRide(BuildContext context) {
    // alertbox
    final alertDialog = AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
          SizedBox(
            width: 40.0,
          ),
          Text(
            "Sending Request",
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog,
      barrierDismissible: false,
    );

    // Snackbar
    final snack = SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        "Request has been successfully sent!",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      duration: Duration(seconds: 4),
    );

    //send request to server
    postData(snack);
  }
*/
  //handle bad request
/*
  void handleBadRequest() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Oops! Please try again"),
            content:
                Text("Please select a destination before confirming ride."),
            actions: <Widget>[
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
*/
  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context);
    return Container(
      height: MediaQuery.of(context).size.height / 1,
      padding: EdgeInsets.all(10.0),
      color: Colors.black,
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 50.0),
          // From
          ListTile(
            leading: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            title: Text(
              "Silver Oak University",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              "Gota, Ahmedabad",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Divider())),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Container(
          //       width: MediaQuery.of(context).size.width / 3,
          //       color: Color(0xFF808080),
          //       height: 2.0,
          //     ),
          //   ],
          // ),
          // Destination
          ListTile(
            leading: Icon(
              Icons.location_on,
              color: Colors.white,
            ),
            title: location == ""
                ? Text(
                    "Destination not selected",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    location,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
            subtitle: Text(
              "Time : " + Util.convertTime(time),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          // Confirm Ride button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextButton(
                  onPressed: location == ""
                      ? () => homeViewModel.handleBadRequest(context)
                      : () =>
                          homeViewModel.confirmRide(location, time, context),
                  child: Center(
                    child: Text(
                      "Confirm Ride",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.all(12.0),
                  ),
                ),
              )
            ],
          ),
        ],
      )),
    );
  }
}
