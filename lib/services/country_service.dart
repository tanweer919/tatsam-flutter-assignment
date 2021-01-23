import 'package:dio/dio.dart';
import '../models/country.dart';

class CountryService {
  Future<List<Country>> fetchCountries() async {
    final Dio dio = Dio();
    List<Country> countries = [];
    try {
      final response = await dio.get("https://api.first.org/data/v1/countries");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data["data"];
        for (MapEntry entry in data.entries) {
          countries
              .add(Country.fromJson(countryCode: entry.key, data: entry.value));
        }
      }
      return countries;
    } on DioError catch (e) {
      return null;
    }
  }
}
