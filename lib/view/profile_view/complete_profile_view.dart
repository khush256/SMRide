import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smride_app/view_model/auth_view_model.dart';

class CompleteProfile extends StatefulWidget {
  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Form field variables
  String name = "";
  String phone = "";
  String email = "";
  String branch = "CSA";
  String year = '1';
  String vehicleNo = "";
  int carpool = 0;
  ValueNotifier<bool> _isVisible = ValueNotifier<bool>(false);
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  late dynamic userData;

  @override
  void initState() {
    super.initState();

    print("phone :${phoneController.text.isEmpty}");
    userData = context.read<AuthViewModel>().verifyOtpResponse.data;
    phoneController.text = userData['user']['phone'];
  }

/*
  // Submit the user details to database
  void _submitForm(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    // alertbox
    final alertDialog = AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
          SizedBox(
            width: 40.0,
          ),
          Text(
            "Sending Request",
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog,
      barrierDismissible: false,
    );

    try {
      final url =
          '${AppConstants.userUrl}/complete-profile'; // Update with your base URL
      final token = widget.userData['token'] ?? '';

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          'token': token,
          'name': name,
          'branch': branch,
          'year': year,
          'vehicleNo': carpool == 1 ? vehicleNo : null,
        }),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        // Save user info to shared preferences
        await _saveUserInfo(responseData);

        // Navigate to home screen
        Navigator.pushReplacementNamed(context, '/homescreen');
      } else {
        _showErrorDialog(responseData['error'] ?? 'Profile completion failed');
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Network error: ${error.toString()}',
        backgroundColor: Colors.red,
      );
    }
  }
*/
/*
  Future<void> _saveUserInfo(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', data['user']['name']);
    await prefs.setString('userPhone', data['user']['phone']);
    await prefs.setString('userBranch', data['user']['branch']);
    await prefs.setString('userYear', data['user']['year']);
    await prefs.setString('vehicleNo', data['user']['vehicleNo'] ?? '');
    await prefs.setBool('carpool', data['user']['vehicleNo']);
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('token', data['token']);
  }
*/
/*
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('OK'),
          )
        ],
      ),
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Image(
                      width: 320.0,
                      image: AssetImage("assets/signUp.jpg"),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                    // Sign Up container
                    Container(
                      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                      width: 300.0,
                      height: 500.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 15.0),
                              blurRadius: 15.0),
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, -10.0),
                              blurRadius: 10.0)
                        ],
                      ),
                      child: Form(
                        // autovalidateMode: AutovalidateMode.always,
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // UserName
                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                  labelText: "Name",
                                  icon: Icon(Icons.account_circle)),
                              keyboardType: TextInputType.text,
                              style: TextStyle(fontFamily: "Poppins"),
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return "Name field is required";
                                return null;
                              },
                              onChanged: (val) {
                                // setState(() {
                                name = val;
                                // });
                              },
                            ),
                            // Phone
                            TextFormField(
                              enableInteractiveSelection: false,
                              readOnly:
                                  phoneController.text.isEmpty ? false : true,
                              controller: phoneController,
                              decoration: InputDecoration(
                                  labelText: "Phone", icon: Icon(Icons.phone)),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return "Phone no is required";
                                return null;
                              },
                              onChanged: (val) {
                                // setState(() {
                                phone = val;
                                // });
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                            ),
                            // Branch
                            Row(
                              children: <Widget>[
                                Text("Branch: ",
                                    style: TextStyle(fontSize: 17.0)),
                                Padding(padding: EdgeInsets.all(5.0)),
                                DropdownButton<String>(
                                  value: branch,
                                  items: <String>[
                                    'CSA',
                                    'CSB',
                                    'ECA',
                                    'ECB',
                                    'EEE',
                                    'EB'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    // setState(() {
                                    branch = value!;
                                    // });
                                  },
                                ),
                                Padding(padding: EdgeInsets.all(10.0)),
                                // Year
                                Text("Year: ",
                                    style: TextStyle(fontSize: 17.0)),
                                Padding(padding: EdgeInsets.all(5.0)),
                                DropdownButton<String>(
                                  value: year,
                                  items: <String>['1', '2', '3', '4']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    // setState(() {
                                    year = value!;
                                    // });
                                  },
                                )
                              ],
                            ),
                            Padding(padding: EdgeInsets.all(10.0)),
                            // Carpool
                            Row(
                              children: <Widget>[
                                Text(
                                  "Do you have a vehicle to pool?",
                                  style: TextStyle(fontSize: 17.0),
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.all(2.0)),
                            // RadioButton
                            ValueListenableBuilder(
                                valueListenable: _isVisible,
                                builder: (context, value, child) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text("Yes:",
                                              style: TextStyle(fontSize: 17.0)),
                                          Radio(
                                            activeColor: Colors.green,
                                            value: 1,
                                            groupValue: carpool,
                                            onChanged: (int? val) {
                                              // setState(() {
                                              carpool = val ?? 0;
                                              _isVisible.value = true;
                                              // });
                                            },
                                          ),
                                          Text("No:",
                                              style: TextStyle(fontSize: 17.0)),
                                          Radio(
                                            activeColor: Colors.green,
                                            value: 0,
                                            groupValue: carpool,
                                            onChanged: (int? val) {
                                              // setState(() {
                                              carpool = val ?? 0;
                                              _isVisible.value = false;
                                              // });
                                            },
                                          )
                                        ],
                                      ),
                                      // Padding(padding: EdgeInsets.all(10.0)),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, left: 10.0, right: 10.0),
                                      ),
                                      Visibility(
                                        visible: _isVisible.value,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              labelText: "Vehicle No",
                                              icon:
                                                  Icon(Icons.directions_bike)),
                                          keyboardType: TextInputType.text,
                                          style:
                                              TextStyle(fontFamily: "Poppins"),
                                          onChanged: (val) {
                                            // setState(() {
                                            vehicleNo = val;
                                            // });
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                }),

                            SizedBox(
                              height: 10.0,
                            ),
                            // Submit Button
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(10),
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                      ),
                                      child: Text("Register"),
                                      onPressed: () {
                                        // Navigator.pushReplacementNamed(
                                        //     context, '/homescreen');
                                        if (formKey.currentState!.validate()) {
                                          Map data = {
                                            "token": userData['token'],
                                            "name": name,
                                            "branch": branch,
                                            "year": year,
                                            "vehicleNo":
                                                carpool == 1 ? vehicleNo : "",
                                          };
                                          Provider.of<AuthViewModel>(context,
                                                  listen: false)
                                              .submitUserDetails(data, context);
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
