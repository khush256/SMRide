import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smride_app/view/home_view/offer_ride_view/widgets/accept_card_bottomSheet.dart';
import 'package:smride_app/model/fetch_request_model.dart';
import 'package:smride_app/utils/utils.dart';
import 'package:smride_app/view_model/home_view_model.dart';

Widget requestCard(
    BuildContext context,
    // int index,
    FetchRequestModel request) {
  return Card(
    elevation: 2,
    child: GestureDetector(
      onTap: () {
        context.read<HomeViewModel>().getUserDetails(request.userId.toString());
        showModalBottomSheet(
            context: context,
            builder: (context) => AcceptCard(
                  request,
                )).then((check) {
          context.read<HomeViewModel>().setPrice = "0.0";
          if (check == "success") {
            //Show Snackbar
            final snack = SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "Notified User!",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              duration: Duration(seconds: 4),
            );
            ScaffoldMessenger.of(context).showSnackBar(snack);
          }
        }).catchError((e) {
          Util.errorToast(e.toString());
        });
      },
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/accountAvatar.jpg"),
              radius: 25,
            ),
            title: Text(request.location ?? ''),
            subtitle: Text("Time: " + (request.time ?? '')),
            trailing:
                // accept == true
                // ?
                Icon(
              Icons.check_circle,
              color: Colors.green,
            )
            // : Icon(
            //     Icons.info,
            //   ),
            ),
      ),
    ),
  );
}
