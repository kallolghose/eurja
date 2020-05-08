import 'package:flutter/material.dart';
import 'package:eurja/views/bottomnavigation.dart';
import 'package:eurja/constants/routes_path.dart' as routes;
import 'package:eurja/router.dart' as router;
import 'package:eurja/locator.dart';
import 'package:eurja/services/navigation_service.dart';



class EUrjaApp extends StatefulWidget{
  EUrjaApp({Key key}) : super(key: key);

  @override
  _EUrjaApp createState() => _EUrjaApp();

}

class _EUrjaApp extends State<EUrjaApp>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
          child: Navigator(
            key: locator<NavigationService>().navigatorKey,
            initialRoute: routes.HomeRoute,
            onGenerateRoute: router.generateRoute,
          ),
          onWillPop: () async {
            if (locator<NavigationService>().navigatorKey.currentState.canPop()) {
              locator<NavigationService>().navigatorKey.currentState.pop();
              return false;
            }
            return true;
          }
      ),
      bottomNavigationBar: MyBottomNavigation(currentIndex: 0,),
    );
  }
}