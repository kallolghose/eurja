import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants/routes_path.dart' as routes;
import 'views/login.dart';
import 'views/signup.dart';
import 'views/googlemap.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.LoginRoute:
      return MaterialPageRoute(builder: (context) => LoginPage(title: "Login",));
    case routes.HomeRoute:
      return MaterialPageRoute(builder: (context) => MapSample());
    case routes.SignUpRoute:
      return MaterialPageRoute(builder: (context) => SignUpPage());
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