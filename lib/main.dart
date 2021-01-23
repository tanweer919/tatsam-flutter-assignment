import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tatsam_assignment/services/network_status_service.dart';
import 'view_models/AppProvider.dart';
import 'services/service_locator.dart';
import 'views/home_screen.dart';
import 'views/favorite_screen.dart';
void main() {
  final ThemeData theme = ThemeData(
      primaryColor: Colors.orange,
      primaryColorDark: Color(0X88000000),
      brightness: Brightness.light);
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  final AppProvider appProvider = locator<AppProvider>();
  final NetworkStatusService networkStatusService = locator<NetworkStatusService>();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => appProvider,
        ),
        StreamProvider(
            create: (context) => networkStatusService.networkStatusController.stream,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: HomeScreen(),
        routes: {
          '/home': (context) => HomeScreen(),
          '/favorites': (context) => FavoriteScreen()
        }, //Setting up routes
      ),
    )
  );
}
