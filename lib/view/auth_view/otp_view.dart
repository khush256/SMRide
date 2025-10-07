import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pinput/pinput.dart';
import 'package:smride_app/view_model/auth_view_model.dart';

class OtpScreen extends StatefulWidget {
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
/*
  void saveUserInfo(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', data['user']['name']);
    prefs.setString('userPhone', data['user']['phone']);
    prefs.setString('userBranch', data['user']['branch']);
    prefs.setString('userYear', data['user']['year']);
    prefs.setString('token', data['token']);
    prefs.setBool('isLoggedIn', true);
    if (data['user']['vehicleNo'] != null)
      prefs.setBool('carpool', true);
    else
      prefs.setBool('carpool', false);

    print("stored user details in local storage");
  }
*/
/*
  Future<void> _verifyOtp(String otp) async {
    if (otp.length != 5) {
      Fluttertoast.showToast(
        msg: "Please enter a valid 5-digit OTP",
        backgroundColor: Colors.red,
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("${AppConstants.userUrl}/${AppConstants.veifyOtp}"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone': widget.phone,
          'otp': otp,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final isProfileComplete = responseData['isProfileComplete'];
        final token = responseData['token'];
        debugPrint("user data :${token}");
        if (isProfileComplete) {
          saveUserInfo(responseData);
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/homescreen',
            (route) => false,
          );
        } else {
          Navigator.pushNamed(
            context,
            '/completeProfile',
            arguments: responseData,
          );
        }
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        backgroundColor: Colors.red,
      );
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    final phone = context.read<AuthViewModel>().otpResponse.data['phone'];
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('OTP Verification'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          margin: const EdgeInsets.only(top: 40),
          width: double.infinity,
          child: Column(
            children: [
              const Text(
                "ShareMyRide.",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5eb809),
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Enter the 5-digit code sent to",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "+91${phone}",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              // Container(
              //   margin: const EdgeInsets.symmetric(vertical: 40),
              //   child: const Text(
              //     "Enter the code sent to your number",
              //     style: TextStyle(
              //       fontSize: 18,
              //       color: Colors.grey,
              //     ),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              // Container(
              //   margin: const EdgeInsets.only(bottom: 40),
              //   child: const Text(
              //     "+917574013380",
              //     style: TextStyle(
              //       fontSize: 18,
              //       color: Colors.black,
              //     ),
              //   ),
              // ),
              Pinput(
                length: 5,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.green),
                    color: Colors.grey.withValues(alpha: 0.2),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: Colors.green.withValues(alpha: 0.2),
                  ),
                ),
                showCursor: true,
                onCompleted: (pin) {
                  Map data = {
                    'phone': phone,
                    'otp': pin,
                  };
                  Provider.of<AuthViewModel>(context, listen: false)
                      .verifyOtp(data, context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
