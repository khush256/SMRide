import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smride_app/view_model/home_view_model.dart';

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
