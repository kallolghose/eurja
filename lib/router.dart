import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eurja/constants/routes_path.dart' as routes;
import 'package:eurja/views/profile/login.dart';
import 'package:eurja/views/profile/signup.dart';
import 'package:eurja/views/map/googlemap.dart';
import 'package:eurja/views/booking/booking.dart';
import 'package:eurja/views/errors/notavailable.dart';
import 'package:eurja/views/profile/info.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.LoginRoute:
      return MaterialPageRoute(builder: (context) => LoginPage(title: "Login",));
    case routes.HomeRoute:
      return MaterialPageRoute(builder: (context) => MapSample());
    case routes.SignUpRoute:
      return MaterialPageRoute(builder: (context) => SignUpPage());
    case routes.CreateBookingsRoute:
      var bookingArgs = settings.arguments;
      return MaterialPageRoute(builder: (context) => BookingPage(chargerDetails: bookingArgs,));
    case routes.ProfileRoute:
      return MaterialPageRoute(builder: (context) => InfoPage());
    default:
      return MaterialPageRoute(builder: (context) => SomethingWentWrongPage());
  }
}