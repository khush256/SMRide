import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smride_app/utils/routes/routes_name.dart';
import 'package:smride_app/view/auth_view/auth_view.dart';
import 'package:smride_app/view/auth_view/otp_view.dart';
import 'package:smride_app/view/credit_view/credits_view.dart';
import 'package:smride_app/view/home_view/home_view.dart';
import 'package:smride_app/view/my_request_view/my_request_view.dart';
import 'package:smride_app/view/my_ride_view/my_ride_view.dart';
import 'package:smride_app/view/profile_view/complete_profile_view.dart';
import 'package:smride_app/view/profile_view/profile_view.dart';
import 'package:smride_app/view/splash_view/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case RoutesName.myRequest:
        return MaterialPageRoute(builder: (context) => MyRequestList());
      case RoutesName.myRides:
        return MaterialPageRoute(builder: (context) => MyRides());
      case RoutesName.completeProfile:
        return MaterialPageRoute(builder: (context) => CompleteProfile());
      case RoutesName.profile:
        return MaterialPageRoute(builder: (context) => ProfilePage());
      case RoutesName.credits:
        return MaterialPageRoute(builder: (context) => Credits());
      case RoutesName.otpScreen:
        return MaterialPageRoute(builder: (context) => OtpScreen());
      case RoutesName.otphome:
        return MaterialPageRoute(builder: (context) => OtpHome());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
