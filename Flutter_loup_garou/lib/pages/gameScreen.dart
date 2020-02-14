import 'package:flutter_loup_garou/animations/fadeInState.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loup_garou/data.dart';
import 'package:flutter_loup_garou/api.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  
  // final _formKey = GlobalKey<FormState>();
  int role = 7; //TODO
  int numeroJoueur = 1;
  Data manager = Data();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromRGBO(56, 36, 131, 1.0),
      body: WillPopScope(
      onWillPop: () async {Future.value(false);},
      child: Container(
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
                                  fontSize: 25
                                )
                              ),
                            ),
                            Container(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                InkWell(
                                  child: FlipCard(
                                    direction: FlipDirection.HORIZONTAL,
                                    front: Container(
                                        child: Image(image: AssetImage(Player.idCarteToChemin(0)), fit: BoxFit.cover),
                                    ),
                                    back: Container(
                                        child: Image(image: AssetImage(Player.idCarteToChemin(role)), fit: BoxFit.cover),
                                    ),
                                  ),
                                  )
                                ]
                              )
                            ),
                            Container(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
                              child: FadeInState(
                                child: StreamBuilder<String>(
                                  stream: manager.dialogueList,
                                  builder: (context,snapshot) {
                                    String text = snapshot.data;
                                    return Text(text != null ? text : '', style: TextStyle(color: Colors.white,fontSize: 16.0));
                                  }
                                ),
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
      )
    );
  }
}
