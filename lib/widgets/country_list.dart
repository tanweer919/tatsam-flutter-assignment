import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/country.dart';
import '../view_models/home_view_model.dart';
import '../view_models/AppProvider.dart';

class CountryList extends StatefulWidget {
  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  //Controller to detect scrolling of country list
  ScrollController _scrollController = ScrollController();
  int _totalNoOfCountries;
  @override
  void initState() {
    //Initial state of the home page
    final HomeViewModel initialState =
        Provider.of<HomeViewModel>(context, listen: false);
    //Fetch countries from api when countries list is not initialized
    if (initialState.allCountries == null) {
      initialState.loadCountries().whenComplete(() {
        _totalNoOfCountries = initialState.allCountries.length;
        //Setup controller to fetch more countries on scrolling to the bottom of the screen
        _setupScrollController(initialState);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child1) => Consumer<HomeViewModel>(
        builder: (context, model, child2) => (model.filteredCountries != null)
            ? ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: model.lastRetrievedIndex + 2,
                itemBuilder: (BuildContext context, int index) {
                  if (index == model.lastRetrievedIndex + 1) {
                    return index == _totalNoOfCountries
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: SizedBox(
                              height: 40,
                              child: Chip(
                                elevation: 2,
                                backgroundColor: Colors.white,
                                avatar: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.arrow_upward),
                                ),
                                label: Text(
                                  'Swipe up to load more',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          );
                  }
                  Country country = model.allCountries[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 6.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: Container(
                        color: Colors.white,
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.orange,
                                child: Text(
                                  country.code,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    country.name,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  SnackBar snackBar;
                                  if (!country.isFavorite) {
                                    model.setFavorite(
                                        countryCode: country.code,
                                        isFavorite: true);
                                    country.isFavorite = true;
                                    appProvider.addToFavorites(country);
                                    snackBar = SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(Icons.close,),
                                          Text(
                                              '${country.name} has been added to favorite',),
                                        ],
                                      ),
                                      backgroundColor: Color(0xff5cb85c),
                                      duration: Duration(seconds: 2),
                                    );
                                  } else {
                                    model.setFavorite(
                                        countryCode: country.code,
                                        isFavorite: false);
                                    country.isFavorite = false;
                                    appProvider.removeFromFavorites(country);
                                    snackBar = SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(Icons.check,),
                                          Text(
                                              '${country.name} has been removed from favorite',),
                                        ],
                                      ),
                                      backgroundColor: Color(0xff0275d8),
                                      duration: Duration(seconds: 2),
                                    );
                                  }
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                child: country.isFavorite
                                    ? Icon(Icons.favorite)
                                    : Icon(Icons.favorite_border),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  void _setupScrollController(HomeViewModel model) {
    //If total number of countries in more than 10,
    // display only the first 10 countries
    if (_totalNoOfCountries > 10) {
      model.filteredCountries = model.allCountries.sublist(0, 10);
      model.lastRetrievedIndex = 9;
    }
    //If less than 10, display all the  countries
    else {
      model.filteredCountries = model.allCountries;
      model.lastRetrievedIndex = _totalNoOfCountries - 1;
    }

    //Listening to scroll
    _scrollController.addListener(() {
      if ((_scrollController.position.maxScrollExtent -
                  _scrollController.position.pixels ==
              0.0) &&
          model.lastRetrievedIndex < _totalNoOfCountries - 1) {
        //If scrolled to bottom and
        // last displayed item is less than last index of total country list
        //ie. there is still more countries to displayed, display more countries
        model.getMoreCountries();
      }
    });
  }
}
