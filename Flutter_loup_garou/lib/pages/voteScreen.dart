import 'package:flutter_loup_garou/animations/fadeInState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loup_garou/api.dart';

class VoteScreen extends StatefulWidget {

  @override
  _VoteScreenState createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {

  @override
  Widget build(BuildContext context){

    Data manager = Data();
    Data.isGettingList = false;
    
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
                                "Qui est votre choix ?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25
                                )
                              ),
                            ),
                            SizedBox(height: 50.0),
                            ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: manager.listMinusSelf(Data.detailListJoueur,Data.joueurCourant).length,
                              itemBuilder: (context, index) {
                                return FadeInState(
                                  child: Container(
                                    child: InkWell(
                                      onTap: () {
                                        manager.doVote(index, context);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left:50.0, right: 50.0, bottom: 30.0),
                                        decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                        color: Color.fromRGBO(246, 187, 28, 1.0)
                                        ),
                                        height: 50.0,
                                        child: Center(
                                          child: Text(
                                            manager.listMinusSelf(Data.detailListJoueur,Data.joueurCourant)[index].nom,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            )
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                );   
                              }
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
