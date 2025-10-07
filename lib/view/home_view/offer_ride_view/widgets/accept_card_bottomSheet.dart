import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smride_app/data/response/api_response.dart';
import 'package:smride_app/model/fetch_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smride_app/view/home_view/offer_ride_view/widgets/setPrice.dart';
import 'package:smride_app/view_model/home_view_model.dart';

// ignore: must_be_immutable
class AcceptCard extends StatelessWidget {
  // final String destination;
  // final String time;
  // final String requestedUserId;
  AcceptCard(this.request
      // this.destination,
      // this.time,
      // this.requestedUserId
      );
  final FetchRequestModel request;

  String username = "";
  String branch = "";
  String year = "";

/*
  _getUserDetails() {
    http
        .get(
            Uri.parse("${AppConstants.userUrl}/info/${widget.requestedUserId}"))
        .then((response) {
      print(response.body);
      final Map<String, dynamic> user = json.decode(response.body);

      setState(() {
        username = user["name"];
        branch = user["branch"];
        year = user["year"];
      });
    }).catchError((e) {
      print(e);
    });
  }
  */
/*
  _offerRide(BuildContext context) {
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
            "Notifying user",
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

    _postOfferRequest();
  }
  */
/*
  _postOfferRequest() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // String token = pref.getString('token') ?? "";
    String url = "${AppConstants.userUrl}/${widget.request.requestID}";
    Map<String, String> offerRequest = {
      'driverName': pref.getString('userName') ?? "",
      'driverPhone': pref.getString('userPhone') ?? "",
      'location': widget.request.location ?? "",
      'time': widget.request.time ?? '',
      'rate': price
    };

    //test code
    http
        .patch(Uri.parse(url),
            headers: {"Content-Type": "application/json"},
            body: json.encode(offerRequest))
        .then((response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);

      Timer(Duration(seconds: 3), () {
        Navigator.of(context).pop();
        Navigator.of(context).pop("success");
      });
    }).catchError((e) {
      print(e);
    });
  }
*/

  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context);
    dynamic userDetails = homeViewModel.userDetails.data;
    if (userDetails != null) {
      username = userDetails['name'];
      branch = userDetails['branch'];
      year = userDetails['year'];
    }
    return Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height / 2,
      padding: EdgeInsets.all(20),
      child: homeViewModel.userDetails.status == Status.LOADING
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : homeViewModel.userDetails.status == Status.COMPLETED
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    // User details
                    Container(
                      // color: Colors.blueAccent,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/accountAvatar.jpg"),
                        ),
                        title: Text(
                          "Name: " + username,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Row(
                          children: <Widget>[
                            Text(
                              "Branch: " + branch,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Year: " + year,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Ride Details -- Destination and Time
                    Container(
                      // color: Colors.cyan,
                      child: ListTile(
                        leading: Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        title: Text(
                          request.location ?? "",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          "Time : " + (request.time ?? ""),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    //Set Price
                    Container(
                      // color: Colors.greenAccent,
                      child: ListTile(
                        leading: Icon(
                          Icons.monetization_on,
                          color: Colors.white,
                        ),
                        title:
                            // Consumer<HomeViewModel>(
                            //   builder: (context, value, child) {
                            //     return
                            Text(
                          homeViewModel.price + " Rs",
                          style: TextStyle(color: Colors.white),
                        ),
                        //   },
                        // ),
                        trailing: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          child: Text("Set Price"),
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => SetPrice(context));
                            //     .then((newPrice) {
                            //   homeViewModel.setPrice = newPrice;
                            // });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10),
                            elevation: 3,
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            "Offer Ride",
                            style: TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();

                            Map data = {
                              'driverName': pref.getString('userName') ?? "",
                              'driverPhone': pref.getString('userPhone') ?? "",
                              'location': request.location ?? "",
                              'time': request.time ?? '',
                              'rate': homeViewModel.price,
                            };
                            homeViewModel.offerRide(
                                context, data, request.userId.toString());
                          }),
                    )
                  ],
                )
              : Center(
                  child: Text(
                    "Something went wrong...",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
    );
  }
}
