import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smride_app/view/my_ride_view/widgets/build_my_rides.dart';
import 'package:smride_app/data/response/api_response.dart';
import 'package:smride_app/view_model/home_view_model.dart';

class MyRides extends StatefulWidget {
  @override
  _MyRidesState createState() => _MyRidesState();
}

class _MyRidesState extends State<MyRides> {
  // List that contains requests from users
  // List<AcceptedRide> _rides = [];

  // final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  //     GlobalKey<RefreshIndicatorState>();
  // bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().fetchMyRides();
    });
    // fetchRides();
  }

/*
  Future<dynamic> fetchRides() async {
    _isLoading = false;

    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token') ?? "";

    return http
        .get(Uri.parse(
            "${AppConstants.userUrl}/${AppConstants.acceptedRides}/$token"))
        .then((response) {
      final List<AcceptedRide> fetchedRides = [];
      //responseData gives user's accepted rides list
      final responseData = json.decode(response.body);
      final rides = responseData['acceptedRides'];

      var length = responseData['acceptedRides'].length;
      print(responseData['acceptedRides']);
      for (var i = 0; i < length; i++) {
        final AcceptedRide request = AcceptedRide(
          acceptedDriverName: rides[i]['driverName'],
          acceptedDriverNumber: rides[i]['driverPhone'],
          destination: rides[i]['location'],
          time: rides[i]['time'],
          rate: rides[i]['rate'],
        );
        fetchedRides.add(request);
      }

      setState(() {
        _rides.clear();
        _rides.addAll(fetchedRides);
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
  Future<dynamic> _onRefresh() {
    return fetchRides();
  }
*/
/*
  Widget _buildRidesList() {
    return RefreshIndicator(
      onRefresh: context.read<HomeViewModel>().fetchMyRides,
      key: _refreshIndicatorKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _rides.length,
              itemBuilder: (BuildContext context, int index) {
                return _ridesCards(context, index);
              },
            ),
          )
        ],
      ),
    );
  }
*/
/*
  // Cards showing accepted rides
  Widget _ridesCards(BuildContext context, int index) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage("assets/accountAvatar.jpg"),
          radius: 25,
        ),
        title: ListTile(
          title: Text(
            _rides[index].acceptedDriverName,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          subtitle:
              Text(_rides[index].destination + " : " + _rides[index].time),
        ),
        trailing: Container(
          child: Text(
            _rides[index].rate + " Rs",
            style: TextStyle(
              color: Colors.green,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        children: <Widget>[
          ListTile(
              leading: Icon(
                Icons.phone,
                color: Colors.green,
              ),
              title: GestureDetector(
                  child: Text(_rides[index].acceptedDriverNumber)),
              onTap: () => Util.openPhone(_rides[index].acceptedDriverNumber))
        ],
      ),
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Rides"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          switch (value.myRides.status) {
            case Status.LOADING:
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            case Status.COMPLETED:
              return buildMyRidesList(context);
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
                  value.myRides.message ?? "",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
