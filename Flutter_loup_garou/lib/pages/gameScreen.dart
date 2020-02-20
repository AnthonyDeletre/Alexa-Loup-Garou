import 'package:flutter_loup_garou/animations/fadeInState.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loup_garou/api.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  Data manager = Data();
  
  @override
  Widget build(BuildContext context){

    Data.isGettingList = false;
    // Data.mainContext = context;
    
    return Scaffold(
      backgroundColor: Color.fromRGBO(56, 36, 131, 1.0),
      body: WillPopScope(
      onWillPop: () async {Future.value(false); return;},
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
                                Data.joueurCourant.nom,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16
                                )
                              ),
                            ),
                            Center(
                              child: Text(
                                "Joueur "+ Data.joueurCourant.id,
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
                                        child: Image(image: AssetImage(Joueur.idCarteToChemin("")), fit: BoxFit.cover),
                                    ),
                                    back: Container(
                                      child: Image(
                                        image: AssetImage(
                                           Joueur.idCarteToChemin(Data.joueurCourant.role)
                                        ), 
                                        fit: BoxFit.cover
                                      ),
                                    ),
                                  ),
                                  )
                                ]
                              )
                            ),
                            Container(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
                              child: FadeInState(
                                child: Center(
                                  child: StreamBuilder<String>(
                                    stream: manager.dialogueList(context),
                                    builder: (context,snapshot) {
                                      String message = snapshot.data;
                                      return Text(message != null ? message : '', style: TextStyle(color: Colors.white,fontSize: 16.0));
                                    }
                                  ),
                                )
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
