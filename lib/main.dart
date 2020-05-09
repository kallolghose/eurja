import 'package:flutter/material.dart';
import 'package:eurja/locator.dart';
import 'package:eurja/views/eurjaapp.dart';

void main() {
  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'eUrja',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //navigatorKey: locator<NavigationService>().navigatorKey,
        //onGenerateRoute: router.generateRoute,
        //initialRoute: routes.HomeRoute,
        home: EUrjaApp(),
      );
  }
}

/*

GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          //currentFocus.unfocus();
          currentFocus.requestFocus(new FocusNode());
        }
      },
      child: MaterialApp());
 */