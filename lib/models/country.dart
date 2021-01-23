import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
class Country {
  String name;
  String region;
  String code;
  Color backgroundColor;
  bool isFavorite;
  Country({this.name, this.region, this.code, this.isFavorite, this.backgroundColor});
  Country.fromJson({String countryCode, Map<String, dynamic> data}):
      this.code = countryCode,
      this.name = data["country"],
      this.region = data["region"],
      this.backgroundColor = Color(
          (math.Random().nextDouble() *
              0xFFFFFF)
              .toInt())
          .withOpacity(1.0);
}