import 'package:get_it/get_it.dart';
import 'network_status_service.dart';
import 'country_service.dart';
import '../view_models/AppProvider.dart';
import '../view_models/home_view_model.dart';
GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<NetworkStatusService>(() => NetworkStatusService());
  locator.registerLazySingleton<CountryService>(() => CountryService());
  locator.registerFactory<AppProvider>(() => AppProvider(0, []));
  locator.registerFactory<HomeViewModel>(() => HomeViewModel());
}