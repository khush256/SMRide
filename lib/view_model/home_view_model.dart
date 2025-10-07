import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smride_app/data/response/api_response.dart';
import 'package:smride_app/repository/home_repository.dart';
import 'package:smride_app/utils/utils.dart';

class HomeViewModel with ChangeNotifier {
  final _myRepo = HomeRepository();

  // Request Ride

  ApiResponse _requestRideResponse = ApiResponse.initial("Ride not requested");
  ApiResponse get requestRideResponse => _requestRideResponse;
  setRequestRideResponse(ApiResponse response) {
    _requestRideResponse = response;
  }

  Future<void> requestRide(
      dynamic data, SnackBar snackBar, BuildContext context) async {
    setRequestRideResponse(ApiResponse.loading("Requesting a ride"));

    _myRepo.requestRide(data).then((response) {
      setRequestRideResponse(ApiResponse.completed(response));
      if (kDebugMode) {
        print(response);
      }

      Timer(Duration(seconds: 3), () {
        Navigator.pop(context);
        Navigator.pop(context, snackBar);
      });
    }).onError((error, stackTrace) {
      setRequestRideResponse(ApiResponse.error(error.toString()));
      Util.errorToast(error.toString());
    });
  }

  void confirmRide(String location, DateTime time, BuildContext context) async {
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
    final snackBar = SnackBar(
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
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map data = {
      'userId': pref.getString('token') ?? "",
      // "63f6950b-bc65-4d93-be53-f52fdf977034",
      'location': location,
      // 'time': widget.time.toString(),
      'time': DateFormat('hh:mm a').format(time),
    };
    await requestRide(data, snackBar, context);
  }

  void handleBadRequest(BuildContext context) {
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

  // fetch all ride requests
  ApiResponse _requestsList = ApiResponse.initial("Not fetching requests");
  ApiResponse get requestsList => _requestsList;
  setRequestsResponse(ApiResponse response) {
    _requestsList = response;
    notifyListeners();
  }

  Future<void> fetchRequests() async {
    setRequestsResponse(ApiResponse.loading("Fetching requests list"));
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token') ?? "";
    _myRepo.fetchRideRequests(token).then((response) {
      setRequestsResponse(ApiResponse.completed(response));
    }).onError((error, stackTrace) {
      setRequestsResponse(ApiResponse.error(error.toString()));
      Util.errorToast(error.toString());
    });
  }

  // get user details
  ApiResponse _userDetails = ApiResponse.initial("Not fetching user details");
  ApiResponse get userDetails => _userDetails;
  setUserDetails(ApiResponse response) {
    _userDetails = response;
    notifyListeners();
  }

  Future<void> getUserDetails(String userId) async {
    setUserDetails(ApiResponse.loading("Fetching user details"));
    _myRepo.getUserDetails(userId).then((response) {
      setUserDetails(ApiResponse.completed(response));
    }).catchError((error, stackTrace) {
      setUserDetails(ApiResponse.error(error.toString()));
      Util.errorToast(error.toString());
    });
  }

  // offer ride to requester

  String _price = "0.0";

  set setPrice(String price) {
    _price = price;
  }

  String get price => _price;

  ApiResponse _offerRideResponse = ApiResponse.initial("Ride not offered");
  ApiResponse get offerRideResponse => _offerRideResponse;
  setOfferRideResponse(ApiResponse response) {
    _offerRideResponse = response;
    notifyListeners();
  }

  Future<void> postOfferRequest(
      dynamic data, String requesterID, BuildContext context) async {
    setOfferRideResponse(ApiResponse.loading("Offering a ride"));
    _myRepo.postOfferRequest(data, requesterID).then((response) {
      setOfferRideResponse(ApiResponse.completed(response));
      if (kDebugMode) {
        print(response);
      }

      Timer(Duration(seconds: 3), () {
        Navigator.pop(context);
        Navigator.pop(context, "success");
      });
    }).onError((error, stackTrace) {
      Util.errorToast(error.toString());
    });
  }

  void offerRide(BuildContext context, dynamic data, String requesterID) async {
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

    await postOfferRequest(data, requesterID, context);
  }

  // Fetching my requests
  ApiResponse _myRequests = ApiResponse.initial("Not fetching my requests");
  ApiResponse get myRequests => _myRequests;
  setMyRequestResponse(ApiResponse response) {
    _myRequests = response;
    notifyListeners();
  }

  Future<void> fetchMyRequests() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('token') ?? "";

    setMyRequestResponse(ApiResponse.loading("Fetching my requests"));
    _myRepo.fetchMyRequests(userId).then((response) {
      setMyRequestResponse(ApiResponse.completed(response));
      if (kDebugMode) {
        print(response);
      }
    }).onError((error, stackTrace) {
      setMyRequestResponse(ApiResponse.error(error.toString()));
      Util.errorToast(error.toString());
    });
  }

  // deleting request
  ApiResponse _deleteRequestResponse =
      ApiResponse.initial("Not deleting request");
  ApiResponse get deleteRequestResponse => _deleteRequestResponse;
  setDeleteRequestResponse(ApiResponse response) {
    _deleteRequestResponse = response;
    notifyListeners();
  }

  Future<void> deleteRequest(String requestId, BuildContext context) async {
    setDeleteRequestResponse(ApiResponse.loading("Deleting request"));
    _myRepo.deleteRequest(requestId).then((response) {
      setDeleteRequestResponse(ApiResponse.completed(response));
      Util.successToast("Request deleted");
    }).onError((error, stackTrace) {
      setDeleteRequestResponse(ApiResponse.error(error.toString()));
      Util.errorToast(error.toString());
    });
  }

  //Fetching my rides
  ApiResponse _myRides = ApiResponse.initial("Not fetching my rides");
  ApiResponse get myRides => _myRides;
  setMyRidesResponse(ApiResponse response) {
    _myRides = response;
    notifyListeners();
  }

  Future<void> fetchMyRides() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('token') ?? "";
    setMyRidesResponse(ApiResponse.loading("Fetching my rides"));
    _myRepo.fetchMyRides(userId).then((response) {
      setMyRidesResponse(ApiResponse.completed(response));
      if (kDebugMode) {
        print("Rides: ${response}");
      }
    }).onError((error, stackTrace) {
      setMyRidesResponse(ApiResponse.error(error.toString()));
      Util.errorToast(error.toString());
    });
  }

  // Car registered or not
  bool carRegistered = false;

  isCarRegistered() async {
    SharedPreferences.getInstance().then((pref) {
      carRegistered = pref.getBool('carpool') ?? false;
      print(carRegistered);
      notifyListeners();
    }).onError((error, stackTrace) {
      Util.errorToast(error.toString());
    });
  }

  setVehicleNo(String vehicleNo, BuildContext context) async {
    SharedPreferences.getInstance().then((pref) {
      pref.setBool("carpool", true);
      pref.setString("vehicleNo", vehicleNo);
      if (context.mounted) Navigator.of(context).pop();
    }).onError((error, stackTrace) {
      Util.errorToast(error.toString());
    });
  }

// update vehicle info
  ApiResponse _vehicleResponse =
      ApiResponse.initial("Not updating vehicle info");
  ApiResponse get vehicleResponse => _vehicleResponse;
  setVehicleResponse(ApiResponse response) {
    _vehicleResponse = response;
    notifyListeners();
  }

  Future updateVehicleNumber(dynamic data, BuildContext context) async {
    setVehicleResponse(ApiResponse.loading("Updating vehicle info"));
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    await _myRepo.updateVehicleNumber(token!, data).then((response) async {
      if (kDebugMode) {
        print(response);
      }
      setVehicleResponse(ApiResponse.completed(data));
      await setVehicleNo(data['vehicleNo'], context);
      carRegistered = true;
      notifyListeners();
      Util.successToast("Vechicle No. updated");
    }).onError((error, stackTrace) {
      setVehicleResponse(ApiResponse.error(error.toString()));
      Util.errorToast(error.toString());
    });
  }
}
