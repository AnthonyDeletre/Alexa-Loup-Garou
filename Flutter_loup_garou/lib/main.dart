import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_loup_garou/pages/loginScreen.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Montserrat'),
          home: LoginScreen()
      ),
    );
  }
}

