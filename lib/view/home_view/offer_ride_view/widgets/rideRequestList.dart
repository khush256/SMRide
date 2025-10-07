import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smride_app/data/response/api_response.dart';
import 'package:smride_app/view/home_view/offer_ride_view/widgets/build_requests_list.dart';
import 'package:smride_app/view_model/home_view_model.dart';

class RideRequestList extends StatefulWidget {
  @override
  _RideRequestListState createState() => _RideRequestListState();
}

class _RideRequestListState extends State<RideRequestList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<HomeViewModel>(context, listen: false).fetchRequests();
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // Provider.of<HomeViewModel>(context, listen: false).fetchRequests();
    // });
  }

/*
  Future<dynamic> fetchRequests() async {
    _isLoading = false;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token') ?? "";

    return http
        .get(Uri.parse("${AppConstants.requestUrl}/$token"))
        .then((response) {
      final List<Request> fetchedRequests = [];
      final List<dynamic> responseData = json.decode(response.body);

      var length = responseData.length;
      for (var i = 0; i < length; i++) {
        final Request request = Request(
          requestId: responseData[i]['userId'],
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
      print(e);
    });
  }
*/
/*
  Widget _buildRequestList(List<Request> requests) {
    return RefreshIndicator(
      onRefresh: homeViewModel.fetchRequests,
      key: _refreshIndicatorKey,
      child: requests.isNotEmpty
          ? ListView.builder(
              itemCount: requests.length,
              itemBuilder: (BuildContext context, int index) {
                return requestCard(context, index, requests);
              },
            )
          : Center(
              child: Text(
                "No Requests",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
    );
  }
*/
  // Cards showing user requests
  /*
  Widget _requestCards(
      BuildContext context, int index, List<Request> requests) {
    return Card(
      elevation: 2,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => AcceptCard(
                  requests[index].destination,
                  requests[index].time,
                  requests[index].requestId)).then((check) {
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
            print(e);
          });
        },
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/accountAvatar.jpg"),
              radius: 25,
            ),
            title: Text(requests[index].destination),
            subtitle: Text("Time: " + requests[index].time),
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
    );
  }
  */
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, value, child) {
        switch (value.requestsList.status) {
          case Status.LOADING:
            return Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            ));
          case Status.COMPLETED:
            return buildRequestList(value.requestsList.data ?? [], context);
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
    );
  }
}
