import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/country.dart';
import '../view_models/home_view_model.dart';
import '../view_models/AppProvider.dart';
import 'dart:math' as math;
import '../commons/empty_screen.dart';
import 'country_skelton.dart';

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
    final HomeViewModel initialHomeState =
        Provider.of<HomeViewModel>(context, listen: false);
    final AppProvider initialAppState =
        Provider.of<AppProvider>(context, listen: false);
    //Fetch countries from api when countries list is not initialized
    if (initialHomeState.allCountries == null) {
      initialHomeState
          .loadCountries(initialAppState.favoriteCountries)
          .whenComplete(() {
        _totalNoOfCountries = initialHomeState.allCountries.length;
        //Setup controller to fetch more countries on scrolling to the bottom of the screen
        _setupScrollController(initialHomeState);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child1) => Consumer<HomeViewModel>(
        builder: (context, model, child2) => (model.allCountries != null)
            ? (model.allCountries.length > 0)
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
                            horizontal: 8.0, vertical: 4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          height: 70,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Color(
                                          (math.Random().nextDouble() *
                                                  0xFFFFFF)
                                              .toInt())
                                      .withOpacity(1.0),
                                  child: Text(
                                    country.code,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            country.name,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        Text(
                                          country.region,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                        )
                                      ],
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
                                            Icon(
                                              Icons.check,
                                              size: 25,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2.0),
                                              child: Text(
                                                '${country.name} has been added to favorite',
                                                style:
                                                    TextStyle(fontSize: 15),
                                                overflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ),
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
                                            Icon(
                                              Icons.close,
                                              size: 25,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 2.0),
                                              child: Text(
                                                '${country.name} has been removed from favorite',
                                                style: TextStyle(fontSize: 15),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
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
                                      ? Icon(
                                          Icons.favorite,
                                          color: Theme.of(context).primaryColor,
                                        )
                                      : Icon(Icons.favorite_border),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : EmptyScreen(
                    text: 'No country found',
                  )
            : CountrySkelton(),
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
