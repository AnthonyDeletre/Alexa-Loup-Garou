import 'package:flutter_loup_garou/animations/fadeInState.dart';
import 'package:flutter_loup_garou/pages/loginScreen.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class WaitingScreen extends StatefulWidget {

  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

//Ecran qui s'affiche à l'attente d'un joueur
class _WaitingScreenState extends State<WaitingScreen> {

  String _animation = "Error";

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
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))
                              ),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 70.0),
                                  Container(
                                    width: 400.0,
                                    height: 250.0,
                                    child: FlareActor(
                                      "assets/images/cross.flr", 
                                      animation: _animation,
                                      alignment: Alignment.center,
                                      fit: BoxFit.contain
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  FadeInState(
                                    child: Center(
                                    child: Text(
                                      "Une partie est déjà en cours",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0
                                        )
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 120.0),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginScreen()),
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
                                          'Revenir à l\'accueil',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          )
                                        ),
                                      ),
                                    )
                                  )
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
  );
  }
}
