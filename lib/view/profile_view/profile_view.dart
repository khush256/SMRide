import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smride_app/view_model/auth_view_model.dart';

class ProfilePage extends StatelessWidget {
  Widget build(BuildContext context) {
    final userData = context.read<AuthViewModel>().userData;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 20),
        child: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          title: Text(
            "My Profile",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          ClipPath(
            child: Container(color: Colors.black.withAlpha(1)),
            clipper: GetClipper(),
          ),
          Positioned(
            width: 350.0,
            left: 5,
            top: MediaQuery.of(context).size.height / 10,
            child: Column(
              children: <Widget>[
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                          image: AssetImage('assets/accountAvatar.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(105.0)),
                      boxShadow: [
                        BoxShadow(blurRadius: 9.0, color: Colors.black)
                      ]),
                ),
                SizedBox(height: 40.0),
                Consumer<AuthViewModel>(
                  builder: (context, value, child) => Column(
                    children: [
                      Container(
                        child: Text(
                          userData['name']!,
                          style: TextStyle(
                            fontSize: 25.0,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        getBranch(userData['branch']!) +
                            " - " +
                            getYear(userData['year']!),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey,
                          // fontStyle: FontStyle.it,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Phone: ' + userData['phone']!,
                        style: TextStyle(
                          fontSize: 20.0,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Image(
                  image: AssetImage("assets/signOut.jpg"),
                  width: 290,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.black),
                    ),
                    onPressed: () async {
                      context.read<AuthViewModel>().logout(context);
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 3.5);
    path.lineTo(size.width + 60500, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

getBranch(String branch) {
  if (branch == 'CSA' || branch == 'CSB') return 'Computer Science';
  if (branch == 'ECA' || branch == 'ECB') return 'Electronics & Communication';
  if (branch == 'EB') return 'Electronics & Biomedical';
  if (branch == 'EEE') return 'Electronics & Electrical';
  return branch;
}

getYear(String year) {
  if (year == "1") return '1st Year';
  if (year == "2") return '2nd Year';
  if (year == "3") return '3rd Year';
  if (year == "4") return '4th Year';
  return year;
}
