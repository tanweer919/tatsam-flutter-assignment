import 'package:flutter/material.dart';
import '../models/country.dart';
import '../services/country_service.dart';
import '../services/service_locator.dart';
class HomeViewModel extends ChangeNotifier{
  List<Country> _allCountries; // list containing all the fetched countries
  List<Country> _filteredCountries; //list containing only the filtered countries
  int _lastRetrievedIndex; //index of last displayed country
  
  final CountryService _countryService = locator<CountryService>();
  
  //Getters
  List<Country> get allCountries => _allCountries;
  List<Country> get filteredCountries => _filteredCountries;
  int get lastRetrievedIndex => _lastRetrievedIndex;
  
  //Setters
  void set filteredCountries(List<Country> countries) {
    _filteredCountries = countries;
    notifyListeners();
  }
  
  void set lastRetrievedIndex(int index) {
    _lastRetrievedIndex = index;
    notifyListeners();
  }

  Future<void> loadCountries() async{
    _allCountries = await _countryService.fetchCountries();
    notifyListeners();
  }

  void getMoreCountries() {
      // last displayed item is less than last index total country list - 10
      //ie. there is still more than 10 countries left to be displayed,
      //display only the next 10
      if (_lastRetrievedIndex < (_allCountries.length - 11)) {
        //add next 10 country to the displayed list
        _filteredCountries.addAll(_allCountries.sublist(
            _lastRetrievedIndex + 1, _lastRetrievedIndex + 11));
        //increment last retrieved index by 10
        _lastRetrievedIndex += 10;
      }
      //else diaply the remaining countries
      else {
        //add remaining country to the displayed list
        _filteredCountries.addAll(_allCountries.sublist(_lastRetrievedIndex + 1));
        //set last retrieved index to last index of the list
        _lastRetrievedIndex = _allCountries.length - 1;
      }
      notifyListeners();
  }

  void setFavorite({String countryCode, bool isFavorite}) {
    int index = _allCountries.indexWhere((country) => country.code == countryCode);
    _allCountries[index].isFavorite = isFavorite;
    _filteredCountries[index].isFavorite = isFavorite;
    notifyListeners();
  }
}