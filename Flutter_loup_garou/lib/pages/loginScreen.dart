import 'package:flutter_loup_garou/animations/fadeInState.dart';
import 'package:flutter_loup_garou/pages/lobbyScreen.dart';
import 'package:flutter_loup_garou/api.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  
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
                      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image(
                            image: AssetImage("assets/images/background.png"),
                            fit: BoxFit.cover
                          ),
                          SizedBox(height: 10.0),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  style: TextStyle(color: Colors.white, fontSize: 15),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 15),
                                    labelText: 'Pseudo',
                                    labelStyle: TextStyle(color: Colors.white),
                                    fillColor: Colors.white,
                                    hoverColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.circular(50.0)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.circular(50.0)
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Veuillez entrer un numéro de partie';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  style: TextStyle(color: Colors.white, fontSize: 15),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 15),
                                    labelText: 'Numéro de partie',
                                    labelStyle: TextStyle(color: Colors.white),
                                    fillColor: Colors.white,
                                    hoverColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.circular(50.0)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.circular(50.0)
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Veuillez entrer un numéro de partie';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 30.0),
                                FadeInState(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color:  Color.fromRGBO(246, 187, 28, 1.0),
                                  ),
                                  height: 50.0,
                                  child: InkWell(
                                    onTap: () {
                                      if (_formKey.currentState.validate()) {
                                        // postRequest();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => LobbyScreen()),
                                        );
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Center(
                                        child: Text(
                                          'Envoyer',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      )
                                    )
                                  )
                                ),
                              ),
                              ],
                            ),
                          ),
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
