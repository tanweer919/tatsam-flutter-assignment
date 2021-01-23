class Country {
  String name;
  String region;
  String code;
  bool isFavorite;
  Country({this.name, this.region, this.code, this.isFavorite});
  Country.fromJson({String countryCode, Map<String, dynamic> data, bool isFavorite}):
      this.code = countryCode,
      this.name = data["country"],
      this.region = data["region"],
      this.isFavorite = false;
}