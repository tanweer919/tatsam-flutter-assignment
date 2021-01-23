import 'package:flutter/material.dart';
import '../models/country.dart';

class AppProvider extends ChangeNotifier {
  int _navbarIndex;
  List<Country> _favoriteCountries;
  AppProvider(this._navbarIndex, this._favoriteCountries);

  int get navbarIndex => _navbarIndex;
  List<Country> get favoriteCountries => _favoriteCountries;

  void set navbarIndex(int index) {
    _navbarIndex = index;
    notifyListeners();
  }

  void addToFavorites(Country country) {
    this._favoriteCountries.add(country);
    notifyListeners();
  }

  void removeFromFavorites(Country country) {
    this._favoriteCountries.removeWhere((element) => element.code == country.code);
    notifyListeners();
  }
}