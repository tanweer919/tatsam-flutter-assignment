import 'dart:async';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:connectivity/connectivity.dart';

enum NetworkStatus { online, offline }

class NetworkStatusService {
  StreamController<NetworkStatus> networkStatusController =
      StreamController<NetworkStatus>();

  NetworkStatusService() {
    Connectivity().onConnectivityChanged.listen((status) async {
      networkStatusController.add(await _getNetworkStatus(status));
    });
  }

  Future<NetworkStatus> _getNetworkStatus(ConnectivityResult status) async {
    final result = await DataConnectionChecker().hasConnection;
    return (status == ConnectivityResult.mobile ||
                status == ConnectivityResult.wifi) &&
            result
        ? NetworkStatus.online
        : NetworkStatus.offline;
  }
}
