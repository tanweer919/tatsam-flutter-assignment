import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final String text;
  EmptyScreen({this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.6,
                child: Image.asset('assets/images/empty.png'),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(top: 8.0, left: 14.0, right: 14.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}