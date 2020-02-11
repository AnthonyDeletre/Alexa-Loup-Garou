import 'package:flutter_loup_garou/animations/fadeInState.dart';
import 'package:flutter_loup_garou/api.dart';
import 'package:flutter_loup_garou/data.dart';
import 'package:flutter_loup_garou/pages/gameScreen.dart';
import 'package:flutter/material.dart';

class LobbyScreen extends StatefulWidget {
  @override
  _LobbyScreenState createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {

  final _formKey = GlobalKey<FormState>();
  final List<Player> players = getListPlayer();
  
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
                              height: MediaQuery.of(context).size.height - 100.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 20.0),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: players.length,
                                    itemBuilder: (context, index) {
                                        return _listItem(context, index);            
                                    }
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0, bottom: 50.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => GameScreen()),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                          color: Color.fromRGBO(246, 187, 28, 1.0)
                                          ),
                                          height: 50.0,
                                          child: Center(
                                            child: Text(
                                              'Prêt',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              )
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
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
  );
  }

  Widget _listItem(BuildContext context, int index){

    String name = players[index].name; 

    return Padding(
      padding: EdgeInsets.only(top: 20.0),
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
                              name,
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
                          thickness: 1.0, 
                          indent: 60.0,
                          endIndent: 60.0,
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
