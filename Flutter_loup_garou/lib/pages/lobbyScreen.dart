import 'package:flutter_loup_garou/animations/fadeInState.dart';
import 'package:flutter_loup_garou/api.dart';
import 'package:flutter_loup_garou/data.dart';
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
                    padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                        child: Text(
                          "Salon",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0
                            )
                          ),
                        ),
                        Padding(
                        padding: EdgeInsets.only(top: 50.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height - 300.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0))
                              ),
                              child:ListView.builder(
                                shrinkWrap: true,
                                itemCount: players.length,
                                itemBuilder: (context, index) {
                                    return _listItem(context, index);            
                                }
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(top: 3, bottom: 3),
                                child: InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => FormScreen()),
                                    // );
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
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(flex: 6,
            child: 
              Container(
              child: Row(
                children: [
                  Expanded(flex: 1,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
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
