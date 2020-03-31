import 'package:flutter/material.dart';

class MyProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
          child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).backgroundColor,
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
          onPressed: () {}),
    );
  }
}
