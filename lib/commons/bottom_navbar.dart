import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/AppProvider.dart';

class BottomNavbar extends StatelessWidget {
  final List<String> routes = ['/home', '/favorites'];
  final List<BottomNavigationBarItem> bottomNavbarItems = [
    new BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.home,
          color: Colors.orange,
        ),
        icon: Icon(
          Icons.home,
        ),
        label: 'Home'),
    new BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.favorite,
          color: Colors.orange,
        ),
        icon: Icon(
          Icons.favorite,
        ),
        label: 'Favourites'),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, model, child) => BottomNavigationBar(
        items: bottomNavbarItems,
        onTap: (int index) {
          model.navbarIndex = index;
          Navigator.of(context).pushReplacementNamed(routes[index]);
        },
        currentIndex: model.navbarIndex,
      ),
    );
  }
}
