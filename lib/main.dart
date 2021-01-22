import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tatsam_assignment/services/network_status_service.dart';
import 'view_models/AppProvider.dart';
import 'services/service_locator.dart';
import 'commons/network_aware_widget.dart';
import 'views/home_screen.dart';
void main() {
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
      child: NetworkAwareWidget(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
          routes: {
            '/home': (context) => HomeScreen(),
          },
        ),
      ),
    )
  );
}
