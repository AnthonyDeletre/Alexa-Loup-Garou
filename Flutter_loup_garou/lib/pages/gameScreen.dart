
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromRGBO(56, 36, 131, 1.0),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child:TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Joueur X',
                ),
                
              )
            )
          ],
        ),

        /*child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image(
                              image: AssetImage("asset/images/cards/back.png"),
                              fit: BoxFit.cover
                            ),
                            SizedBox(height: 50.0)
                          ]
                        )
                      )
                    ]
                  )
                )
              ]
            )
          ]
        )*/
      )
    );
  }


}
