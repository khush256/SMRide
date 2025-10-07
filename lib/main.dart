import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smride_app/utils/routes/routes.dart';
import 'package:smride_app/utils/routes/routes_name.dart';

import 'package:smride_app/view/splash_view/splash_view.dart';

import 'package:smride_app/view_model/auth_view_model.dart';
import 'package:smride_app/view_model/home_view_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            textSelectionTheme:
                TextSelectionThemeData(selectionHandleColor: Colors.white)),
        debugShowCheckedModeBanner: false,
        title: 'SMRide',
        home: SplashScreen(),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
