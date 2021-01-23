import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/network_status_service.dart';
import '../commons/bottom_navbar.dart';
class NetworkAwareWidget extends StatelessWidget {
  final Widget child;
  NetworkAwareWidget({this.child});
  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkStatus>(
      builder: (context, model, oldChild) {
        return (model == NetworkStatus.offline) ? Scaffold(
          bottomNavigationBar: BottomNavbar(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.6,
                    child: Image.asset('assets/images/nointernet.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0, bottom: 4.0),
                  child: Text(
                    "No internet available",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(bottom: 8.0, left: 14.0, right: 14.0),
                  child: Text(
                    "Please check your connectivity.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
        ) : child;
      }
    );
  }
}