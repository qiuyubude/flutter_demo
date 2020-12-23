import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class My extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> {
  @override
  Widget build(BuildContext context) {
    // return Container();
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.black);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    return Scaffold(
      body: Center(
        child: Text('我的'),
      ),
    );
  }
}
