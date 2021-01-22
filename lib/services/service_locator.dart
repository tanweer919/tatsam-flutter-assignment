import 'package:get_it/get_it.dart';
import 'network_status_service.dart';
import '../view_models/AppProvider.dart';
GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<NetworkStatusService>(() => NetworkStatusService());
  locator.registerFactory<AppProvider>(() => AppProvider(0));
}