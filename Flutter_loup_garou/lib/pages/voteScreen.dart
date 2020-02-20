import 'package:flutter_loup_garou/animations/fadeInState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loup_garou/api.dart';

class VoteScreen extends StatefulWidget {

  final String role;

  VoteScreen({Key key, this.role}) : super (key : key);

  @override
  _VoteScreenState createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {

  String get role => role;

  @override
  Widget build(BuildContext context){

    Data manager = Data();
    Data.isGettingDialogue = false;
    
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
                            StreamBuilder<List<String>>(
                              stream: manager.joueurList(context),
                              initialData: [],
                              builder: (context,snapshot) {
                                List<String> listeJoueur = snapshot.data;
                                return ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: listeJoueur.length,
                                  itemBuilder: (context, index) {
                                    return FadeInState(
                                      child: Container(
                                        child: InkWell(
                                          onTap: () {
                                            Data.isGettingDialogue = true;
                                            Data.isGettingList = false;
                                            manager.doVote(role, index, context);
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
                                                listeJoueur[index],
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
