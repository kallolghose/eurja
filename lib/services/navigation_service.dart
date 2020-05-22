import 'package:flutter/widgets.dart';

class NavigationService{
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName){
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateToWithData(String routeName, dynamic obj){
    return navigatorKey.currentState.pushNamed(routeName, arguments: obj);
  }

  void goBack(){
    return navigatorKey.currentState.pop();
  }
}