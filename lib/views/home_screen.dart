import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../commons/bottom_navbar.dart';
import '../widgets/network_aware_widget.dart';
import '../view_models/home_view_model.dart';
import '../services/service_locator.dart';
import '../widgets/country_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _homeViewModel = locator<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _homeViewModel,
      child: NetworkAwareWidget(
        child: SafeArea(
          child: Scaffold(
            bottomNavigationBar: BottomNavbar(),
            backgroundColor: Color(0xfff1f1f1),
            body: CountryList(),
          ),
        ),
      ),
    );
  }
}
