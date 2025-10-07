import 'package:flutter/material.dart';
import 'widgets/confirm_request_bottomSheet.dart';

class FindaRide extends StatefulWidget {
  @override
  _FindaRideState createState() => _FindaRideState();
}

class _FindaRideState extends State<FindaRide> {
  // Destination
  String destination = "";

  DateTime pickedTime = DateTime.now();
  final destinationController = TextEditingController();

  // Future<Null> _selectTime(BuildContext context) async {
  //   final TimeOfDay? response = await showTimePicker(
  //     context: context,
  //     initialTime: pickedTime,
  //   );
  //   if (response != pickedTime) {
  //     setState(() {
  //       pickedTime = response!;
  //       print(pickedTime);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Card(
          elevation: 2.0,
          child: Container(
            padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 1.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Starting Location
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(
                      "Silver Oak University",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    subtitle: Text("Gota, Ahmedabad"),
                  ),
                ),
                // Destination
                Container(
                  // padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: ListTile(
                    autofocus: false,
                    leading: Icon(Icons.location_on),
                    title: TextField(
                      controller: destinationController,
                      onTapOutside: (_) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        hintText: "Destination",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                        ),
                      ),
                      onChanged: (String val) {
                        setState(() {
                          destination = val;
                        });
                      },
                    ),
                  ),
                ),
                // Time
                /*  
                SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    child:
                        Text("Select Time", style: TextStyle(fontSize: 16.0)),
                    onPressed: () {
                      // _selectTime(context);
                      print(pickedTime);
                      print(DateFormat('hh:mm a').format(DateTime.now()));
                    },
                  ),
                ),
                */
                // Confirm button
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              ConfirmCard(destination, pickedTime));
                      //     .then((snack) =>
                      // ScaffoldMessenger.of(context).showSnackBar(snack));

                      destinationController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 6.0,
                      padding: EdgeInsets.all(10.0),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      "Find A Ride",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
