import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smride_app/data/response/api_response.dart';
import 'package:smride_app/repository/auth_repository.dart';
import 'package:smride_app/utils/routes/routes_name.dart';
import 'package:smride_app/utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  // Saving user info locally using shared preferences
  saveUserInfo(dynamic data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', data['user']['name']);
    await prefs.setString('userPhone', data['user']['phone']);
    await prefs.setString('userBranch', data['user']['branch']);
    await prefs.setString('userYear', data['user']['year']);
    await prefs.setString('token', data['token']);
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('vehicleNo', data['user']['vehicleNo'] ?? '');

    if (data['user']['vehicleNo'] != null &&
        data['user']["vehicleNo"].isNotEmpty)
      await prefs.setBool('carpool', true);
    else
      await prefs.setBool('carpool', false);

    print("stored user details in local storage");
    return;
  }

  Map<String, String> userData = {
    "name": "name",
    "branch": "branch",
    "year": "year",
    "phone": "phone"
  };

  getUserInfo() async {
    if (kDebugMode) print("get user info called");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String name = await pref.getString('userName') ?? "User";
    String branch = await pref.getString('userBranch') ?? "Branch";
    String year = await pref.getString('userYear') ?? "Year";
    String phone = await pref.getString('userPhone') ?? "Phone";

    userData = {"name": name, "branch": branch, "year": year, "phone": phone};
    notifyListeners();
  }

  final _myRepo = AuthRepository();

  // Sending Otp

  ApiResponse _otpResponse = ApiResponse.initial("Otp not called");

  ApiResponse get otpResponse => _otpResponse;

  setOtpResponse(ApiResponse response) {
    _otpResponse = response;
  }

  Future<void> sendOtp(dynamic data, BuildContext context) async {
    setOtpResponse(ApiResponse.loading("Otp calling"));
    await _myRepo.sendOtp(data).then((response) {
      setOtpResponse(ApiResponse.completed(response));
      if (kDebugMode) {
        print(response);
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "OTP : ${response['otp']}",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ));
      Fluttertoast.showToast(
          msg: "OTP : ${response['otp']}",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          gravity: ToastGravity.TOP);
      Navigator.pushNamed(context, RoutesName.otpScreen);
    }).onError(
      (error, stackTrace) {
        setOtpResponse(ApiResponse.error(error.toString()));
        Util.errorToast(error.toString());
      },
    );
  }

  // Verifying Otp
  ApiResponse _verifyOtpResponse = ApiResponse.initial("Verify otp not called");

  ApiResponse get verifyOtpResponse => _verifyOtpResponse;

  setVerifyOtpResponse(ApiResponse response) {
    _verifyOtpResponse = response;
    notifyListeners();
  }

  Future<void> verifyOtp(dynamic data, BuildContext context) async {
    setVerifyOtpResponse(ApiResponse.loading("Verifying otp"));
    await _myRepo.verifyOtp(data).then((responseData) async {
      setVerifyOtpResponse(ApiResponse.completed(responseData));
      if (kDebugMode) {
        print(responseData);
      }
      final isProfileComplete = responseData['isProfileComplete'];

      if (isProfileComplete) {
        print(responseData);
        await saveUserInfo(responseData);
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.home, (route) => false);
      } else {
        Navigator.pushNamed(context, RoutesName.completeProfile);
      }
    }).onError((error, stackTrace) {
      setVerifyOtpResponse(ApiResponse.error(error.toString()));

      Util.errorToast(error.toString());
    });
  }

  // Submitting user details
  ApiResponse _userDetails =
      ApiResponse.initial("Submit Userdetails not called");

  ApiResponse get userDetails => _userDetails;

  setUserDetailsResponse(ApiResponse response) {
    _userDetails = response;
    notifyListeners();
  }

  Future<void> submitUserDetails(dynamic data, BuildContext context) async {
    setUserDetailsResponse(ApiResponse.loading("Submitting user details"));
    sendingAlert(context);
    await _myRepo.submitUserDetails(data).then((response) async {
      setUserDetailsResponse(ApiResponse.completed(response));
      // Saving user info to shared preferences
      saveUserInfo(response);
      Navigator.pushReplacementNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      setUserDetailsResponse(ApiResponse.error(error.toString()));
      Util.errorToast(error.toString());
    });
  }

  void showErrorDialog(String message, BuildContext context) {
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

  void sendingAlert(BuildContext context) {
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
  }

  Future<void> logout(BuildContext context) async {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.otphome,
      (route) => false,
    );
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
