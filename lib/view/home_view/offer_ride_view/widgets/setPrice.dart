import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smride_app/view_model/home_view_model.dart';

Widget SetPrice(BuildContext context) {
  return AlertDialog(
    backgroundColor: Colors.black,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(style: BorderStyle.solid, color: Colors.white38)),
    title: Text("Enter Price", style: TextStyle(color: Colors.white)),
    content: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        onChanged: (value) {
          context.read<HomeViewModel>().setPrice = value;
        },
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusColor: Colors.white,
          hintStyle: TextStyle(color: Colors.white),
          hintText: "Price",
          // icon: Icon(Icons.monetization_on),
        ),
      ),
    ),
    actions: <Widget>[
      TextButton(
        child: Text("Set price", style: TextStyle(color: Colors.green)),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        child: Text(
          "cancel",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
    ],
  );
}
