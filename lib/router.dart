import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eurja/constants/routes_path.dart' as routes;
import 'package:eurja/views/profile/login.dart';
import 'package:eurja/views/profile/signup.dart';
import 'package:eurja/views/map/googlemap.dart';
import 'package:eurja/views/booking/booking.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.LoginRoute:
      return MaterialPageRoute(builder: (context) => LoginPage(title: "Login",));
    case routes.HomeRoute:
      return MaterialPageRoute(builder: (context) => MapSample());
    case routes.SignUpRoute:
      return MaterialPageRoute(builder: (context) => SignUpPage());
    case routes.CreateBookingsRoute:
      return MaterialPageRoute(builder: (context) => BookingPage());
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}