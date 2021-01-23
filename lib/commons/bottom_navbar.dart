import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/AppProvider.dart';

class BottomNavbar extends StatelessWidget {
  //Defined routes for each navbar item
  final List<String> routes = ['/home', '/favorites'];

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> bottomNavbarItems = [
      new BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.home,
            color: Theme.of(context).primaryColor,
          ),
          icon: Icon(
            Icons.home,
          ),
          label: 'Home'),
      new BottomNavigationBarItem(
          activeIcon: Icon(
            Icons.favorite,
            color: Theme.of(context).primaryColor,
          ),
          icon: Icon(
            Icons.favorite,
          ),
          label: 'Favourites'),
    ];
    return Consumer<AppProvider>(
      builder: (context, model, child) => BottomNavigationBar(
        items: bottomNavbarItems,
        onTap: (int index) {
          //Change navbar index and navigate to the screen
          model.navbarIndex = index;
          Navigator.of(context).pushReplacementNamed(routes[index]);
        },
        currentIndex: model.navbarIndex,
      ),
    );
  }
}
