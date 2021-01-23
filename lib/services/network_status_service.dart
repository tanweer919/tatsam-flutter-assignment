import 'dart:async';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:connectivity/connectivity.dart';

enum NetworkStatus { online, offline }

class NetworkStatusService {
  StreamController<NetworkStatus> networkStatusController =
      StreamController<NetworkStatus>();

  NetworkStatusService() {
    //Listen to connectivity change
    Connectivity().onConnectivityChanged.listen((status) async {
      //On change, add current network status to network stream controller
      networkStatusController.add(await _getNetworkStatus(status));
    });
  }

  Future<NetworkStatus> _getNetworkStatus(ConnectivityResult status) async {
    final result = await DataConnectionChecker().hasConnection;
    //Return true when either of mobile or wifi connection is available
    return (status == ConnectivityResult.mobile ||
                status == ConnectivityResult.wifi) &&
            result
        ? NetworkStatus.online
        : NetworkStatus.offline;
  }
}
