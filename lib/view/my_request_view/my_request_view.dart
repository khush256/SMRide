import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smride_app/view/my_request_view/widgets/build_myrequests_list.dart';
import 'package:smride_app/data/response/api_response.dart';
import 'package:smride_app/view_model/home_view_model.dart';

class MyRequestList extends StatefulWidget {
  @override
  _MyRequestListState createState() => _MyRequestListState();
}

class _MyRequestListState extends State<MyRequestList> {
  bool accept = true;

  // List that contains requests from users
  // List<FetchRequestModel> _requests = [];

  // final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  //     GlobalKey<RefreshIndicatorState>();
  // bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().fetchMyRequests();
    });
  }

/*
  Future<dynamic> fetchRequests() async {
    _isLoading = false;

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userId = pref.getString('token');

    return http
        .get(Uri.parse("${AppConstants.requestUrl}/myrequest/${userId}"))
        .then((response) {
      final List<Request> fetchedRequests = [];
      final List<dynamic> responseData = json.decode(response.body);

      var length = responseData.length;
      for (var i = 0; i < length; i++) {
        final Request request = Request(
          requestId: responseData[i]['requestID'].toString(),
          destination: responseData[i]['location'],
          time: responseData[i]['time'],
        );
        fetchedRequests.add(request);
      }

      setState(() {
        _requests.clear();
        _requests.addAll(fetchedRequests);
        _isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        _isLoading = false;
        print(e);
      });
    });
  }
*/
/*
  deleteRequest(String id, int index) {
    http.delete(Uri.parse("${AppConstants.requestUrl}/${id}")).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          _requests.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Request deleted"),
          backgroundColor: Colors.black,
        ));
      }
      print(response.body);
    }).catchError((e) {
      print(e);
    });
  }
*/

  // Future<dynamic> _onRefresh() {
  //   return fetchRequests();
  // }
/*
  Widget _buildRequestList() {
    return RefreshIndicator(
      onRefresh: context.read<HomeViewModel>().fetchMyRequests,
      key: _refreshIndicatorKey,
      child: ListView.builder(
        itemCount: context.read<HomeViewModel>().myRequests.data.length,
        itemBuilder: (BuildContext context, int index) {
          return _requestCards(context, index);
        },
      ),
    );
  }
*/
  // Cards showing user requests
/*
  Widget _requestCards(BuildContext context, int index) {
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
            title: Text(re.destination),
            subtitle: Text("Time: " + _requests[index].time),
            trailing: accept == true
                ? Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : Icon(
                    Icons.info,
                  ),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 12),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 12),
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
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              );
            });
        return res;
      },
      onDismissed: (direction) {
        //send a delete request
        String requestId = _requests[index].requestId;
        context.read<HomeViewModel>().deleteRequest(requestId, context);
        // deleteRequest(requestId, index);
      },
    );
  }
*/

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text("My Requests"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body:
          //  Column(
          //   children: <Widget>[
          Consumer<HomeViewModel>(
        builder: (context, value, child) {
          switch (value.myRequests.status) {
            case Status.LOADING:
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            case Status.COMPLETED:
              return buildMyRequestList(context);
            case Status.ERROR:
              return Center(
                child: Text(
                  "Something went wrong...",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              );
            default:
              return Center(
                child: Text(
                  value.myRequests.message ?? "",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              );
          }
        },

        // child: Expanded(
        //   child: _isLoading
        //       ? Center(child: CircularProgressIndicator())
        //       : buildMyRequestList(context),
        // ),
      ),
      //   ],
      // )
    );
  }
}
