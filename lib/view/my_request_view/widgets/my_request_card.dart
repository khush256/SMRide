import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smride_app/model/fetch_request_model.dart';
import 'package:smride_app/view_model/home_view_model.dart';

Widget myRequestCard(BuildContext context, FetchRequestModel request) {
  return Dismissible(
    key: Key(UniqueKey().toString()),
    direction: DismissDirection.startToEnd,
    background: Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Icon(Icons.delete, color: Colors.white),
        ],
      ),
    ),
    child: Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/accountAvatar.jpg"),
              radius: 25,
            ),
            title: Text(request.location ?? ''),
            subtitle: Text("Time: " + (request.time ?? "")),
            trailing:
                // accept == true
                //     ?
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
    confirmDismiss: (DismissDirection direction) async {
      final bool res = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 10,
              title: Text(
                "Confirm Deletion",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[700],
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    size: 50,
                    color: Colors.orange[700],
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Are you sure you want to delete this request?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "This action cannot be undone.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.spaceAround,
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    backgroundColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    backgroundColor: Colors.red[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    context
                        .read<HomeViewModel>()
                        .deleteRequest(request.requestID ?? "", context);
                    Navigator.of(context).pop(true);
                    context.read<HomeViewModel>().fetchMyRequests();
                  },
                ),
              ],
            );
          });
      return res;
    },
    onDismissed: (direction) {
      //send a delete request
      String requestId = request.requestID ?? "";
      context.read<HomeViewModel>().deleteRequest(requestId, context);
      // deleteRequest(requestId, index);
    },
  );
}
