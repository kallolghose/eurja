import 'package:flutter/material.dart';
import 'package:eurja/services/navigation_service.dart';
import 'package:eurja/locator.dart';
import 'package:eurja/constants/routes_path.dart' as routes;

class MyBottomNavigation extends StatefulWidget{
  MyBottomNavigation({Key key, this.currentIndex}) : super(key: key);

  final int currentIndex;

  @override
  _BottomNavigation createState() => _BottomNavigation(currentIndex);
}

class _BottomNavigation extends State<MyBottomNavigation>{

  final NavigationService _navigationService = locator<NavigationService>();

  _BottomNavigation(this._selectedIndex);
  int _selectedIndex = 0;

  void _onItemTapped(int index){
    if(_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      switch (_selectedIndex) {
        case 0:
          _navigationService.navigateTo(routes.HomeRoute);
          break;
        case 1:
          _navigationService.navigateTo(routes.CreateBookingsRoute);
          break;
        case 2:
          _navigationService.navigateTo(routes.ProfileRoute);
          break;
        case 3:
          _navigationService.navigateTo(routes.LoginRoute);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          title: Text('Bookings')
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.directions_car),
          title: Text('Vehicles')
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          title: Text('Profile')
      ),
    ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black26,
      onTap: _onItemTapped,
    );
  }
}