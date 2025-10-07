import 'package:flutter/material.dart';
import 'package:smride_app/view/home_view/offer_ride_view/widgets/register_car.dart';

class NotRegistered extends StatelessWidget {
/*
  // API to update vehicle number
  Future<bool> updateVehicleNumber(String vehicleNo) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref
          .getString('token'); // Assuming you store token in SharedPreferences

      if (token == null) {
        return false;
      }

      final response = await http.patch(
        Uri.parse(
            '${AppConstants.userUrl}/$token'), // Replace with your API base URL
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'vehicleNo': vehicleNo,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error updating vehicle number: $e');
      return false;
    }
  }
*/

/*
  registerCar(BuildContext context) {
    TextEditingController vehicleNoController = TextEditingController();

    // alertbox
    final alertDialog = AlertDialog(
      title: Text(
        "Register vehicle",
        style: TextStyle(color: Color(0xff474949)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Would you like to pool your Car/Bike?",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 10),
          TextField(
            controller: vehicleNoController,
            decoration: InputDecoration(
              labelText: 'Enter Vehicle Number',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text("Register"),
          onPressed: () async {
            if (vehicleNoController.text.isNotEmpty) {
              // bool success =
              //     await updateVehicleNumber(vehicleNoController.text);
              dynamic data = {'vehicleNo': vehicleNoController.text};
              context.read<HomeViewModel>().updateVehicleNumber(data, context);
              // if (success) {
              //   changeSharedPreference(vehicleNoController.text);
              // } else {
              //   // Show error message
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(content: Text('Failed to update vehicle number')),
              //   );
              // }
            } else {
              // Show validation error
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter vehicle number')),
              );
            }
          },
        ),
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog,
      barrierDismissible: false,
    );
  }
*/
/*
  //change the value in SP and make a callback to parent to reload widget
  changeSharedPreference(String vehicleNo) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('carpool', true);
    pref.setString('vehicleNo', vehicleNo); // Set the vehicle number
    Navigator.of(context).pop();
    widget.callback(true);
  }
*/
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Image(
              width: MediaQuery.of(context).size.width * 0.7,
              image: AssetImage("assets/carRegister.jpg"),
              // fit: BoxFit.contain,
            ),
            Text(
              "Oops! You have no Car/Bike registred",
              style: TextStyle(color: Colors.grey, fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ElevatedButton(
                onPressed: () => registerCar(context),
                style: ElevatedButton.styleFrom(
                  splashFactory: InkRipple.splashFactory,
                  padding: EdgeInsets.all(5.0),
                  backgroundColor: Colors.black,
                  elevation: 4.0,
                  foregroundColor: Colors.white,
                ),
                child: Center(
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
