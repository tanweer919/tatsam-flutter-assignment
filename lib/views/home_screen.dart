import 'package:flutter/material.dart';
import '../commons/bottom_navbar.dart';
class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(),
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}