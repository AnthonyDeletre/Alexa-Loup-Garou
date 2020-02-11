
import 'package:flutter/material.dart';

import '../data.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  
  final _formKey = GlobalKey<FormState>();
  bool imageVisible = false;
  int role = 7;//TODO
  int numeroJoueur = 1;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromRGBO(56, 36, 131, 1.0),
      body: Container(
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Text(
                                "Joueur "+ numeroJoueur.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35
                                )
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  InkWell(
                                    child: Image(
                                      image:(imageVisible ? AssetImage(Player.idCarteToChemin(role)) :AssetImage(Player.idCarteToChemin(0))) ,
                                      fit: BoxFit.cover
                                      ),
                                      onTap: (){
                                        setState(() {
                                          imageVisible = !imageVisible;
                                        });
                                      }
                                    )
                                  ]
                                )
                              )
                            ]
                          )
                        )
                      ],
                    )
                  )
                ],
              )
            ]
          )
        )
    );
  }


}
