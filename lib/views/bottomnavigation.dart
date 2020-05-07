import 'package:flutter/material.dart';

class MyBottomNavigation extends StatefulWidget{
  MyBottomNavigation({Key key, this.currentIndex}) : super(key: key);

  final int currentIndex;

  @override
  _BottomNavigation createState() => _BottomNavigation(currentIndex);
}

class _BottomNavigation extends State<MyBottomNavigation>{

  _BottomNavigation(this._selectedIndex);
  int _selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home')

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