import 'package:flutter/material.dart';
import 'package:flutter_loup_garou/pages/loginScreen.dart';
import 'package:flutter_loup_garou/pages/finishScreen.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Montserrat'),
        // home: LoginScreen()
        home: FinishScreen()
    );
  }
}

