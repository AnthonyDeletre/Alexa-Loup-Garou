import 'package:flutter_loup_garou/animations/fadeInState.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_loup_garou/api.dart';
import 'package:flutter_loup_garou/pages/gameScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_loup_garou/pages/voteScreen.dart';

class LobbyScreen extends StatefulWidget {
  @override
  _LobbyScreenState createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {

  Data manager = Data();
  
  @override
  Widget build(BuildContext context){
  
  setContext(context);

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
                    padding: EdgeInsets.only(top: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeInState(
                          child: Center(
                          child: Text(
                            "Salon",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0
                              )
                            ),
                          ),
                        ),
                        Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height - 120.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))
                              ),
                              child: ListView(
                                primary: false,
                                children: <Widget>[
                                  SizedBox(height: 20.0),
                                  Stack(
                                    children: <Widget>[
                                      Positioned(
                                      child: Container(
                                        height: MediaQuery.of(context).size.height - 160.0,
                                        padding: EdgeInsets.only(bottom: 60.0),
                                          child: StreamBuilder<List<String>>(
                                            stream: manager.joueurList,
                                            initialData: [],
                                            builder: (context,snapshot) {
                                              List<String> listeJoueur = snapshot.data;
                                              return ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: listeJoueur.length,
                                                itemBuilder: (context, index) {
                                                    return _listItem(context, listeJoueur[index]);            
                                                }
                                              );
                                            }
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                      bottom: 0.0,
                                      left: 70.0,
                                      right: 70.0,
                                        child: Container(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                // MaterialPageRoute(builder: (context) => VoteScreen()),
                                                MaterialPageRoute(builder: (context) => GameScreen()),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                              color: Color.fromRGBO(246, 187, 28, 1.0)
                                              ),
                                              width: 250.0,
                                              height: 50.0,
                                              child: Center(
                                                child: Text(
                                                  '" Alexa ! Lance la partie ! "',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontStyle: FontStyle.italic
                                                  )
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ),
                          ]
                        ),
                      )
                      ],
                    ),
                  ),
                ],
              )
            )
          ],
        )
        ],
      )
    ),
    )
  );
  }

  Widget _listItem(BuildContext context, String listeJoueur){

    return Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
      child: Row(
          children: <Widget>[
            Expanded(flex: 1,
            child: 
              Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInState(
                          child: Center(
                            child: Text(
                              listeJoueur,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ),
                        SizedBox(height: 20.0),
                        Divider(
                          height: 5.0, 
                          color: Color.fromRGBO(56, 36, 131, 1.0),
                          indent: 50.0,
                          endIndent: 50.0,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            ),
          ],
        ),
    );
  }

}
