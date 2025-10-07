import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smride_app/view_model/auth_view_model.dart';

class OtpHome extends StatelessWidget {
  OtpHome({Key? key}) : super(key: key);

  final TextEditingController _phoneController = TextEditingController();
/*
  Future<void> _sendOtp(BuildContext context) async {
    final phone = _phoneController.text.trim();

    if (phone.isEmpty || phone.length != 10) {
      Fluttertoast.showToast(
        msg: "Please enter a valid 10-digit phone number",
        backgroundColor: Colors.red,
      );
      return;
    }
    try {
      final response = await http.post(
        Uri.parse('${AppConstants.userUrl}/${AppConstants.sendOtp}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Navigate to OTP verification screen with the phone number
        Navigator.pushNamed(
          context,
          '/otpscreen',
          arguments: phone, // Pass phone number to next screen
        );
      } else {
        Fluttertoast.showToast(
          msg: responseData['error'] ?? 'Failed to send OTP',
          backgroundColor: Colors.red,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Network error: ${error.toString()}',
        backgroundColor: Colors.red,
      );
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   foregroundColor: Colors.white,
      //   title: const Text('OTP Verification'),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            margin: const EdgeInsets.only(top: 40),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header Section
                Container(
                  padding: EdgeInsets.fromLTRB(15, 30, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Share',
                          style: TextStyle(
                            fontSize: 70,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                      Text('MyRide.',
                          style: TextStyle(
                            fontSize: 70,
                            color: Color(0xFF5eb809),
                            fontWeight: FontWeight.bold,
                            height: .7,
                          )),
                    ],
                  ),
                ),

                // Form Section
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "You'll receive a 4 digit code to verify next",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 30),
                      TextField(
                        onTapOutside: (_) {
                          FocusScope.of(context).unfocus();
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefix: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text('+91'),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                          ),
                        ),
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        controller: _phoneController,
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.zero,
                            foregroundColor: Colors.white,
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.green.shade500,
                                  Colors.green.shade700,
                                  Colors.green.shade900,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'NEXT',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            final phone = _phoneController.text.trim();

                            if (phone.isEmpty || phone.length != 10) {
                              Fluttertoast.showToast(
                                msg:
                                    "Please enter a valid 10-digit phone number",
                                backgroundColor: Colors.red,
                              );
                              return;
                            }
                            Map data = {"phone": phone};
                            Provider.of<AuthViewModel>(context, listen: false)
                                .sendOtp(data, context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Footer (positioned at bottom with minimal space)
                if (MediaQuery.of(context).viewInsets.bottom == 0)
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Text(
                      "©2025 MyRide. All rights reserved.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
              ],
            ),
          )),
    );
  }
}
