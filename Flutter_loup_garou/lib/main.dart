import 'package:flutter/material.dart';
import 'package:flutter_loup_garou/pages/loginScreen.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  
  // final ProduitData _model = ProduitData();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Montserrat'),
        home: LoginScreen()
    );
  }
}

