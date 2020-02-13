import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Data {

  Stream<String> get dialogueList async*{
    
    final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com');

    if(response.statusCode == 200){ yield response.body; }
    else{ throw Exception('Failed'); }
  }

  Stream<String> get joueurList async*{
    
    final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/listejoueur'); 

    if(response.statusCode == 200){
      Item item = Item.fromJson(json.decode(response.body));
      yield item.joueurs; 
    }
    else{ throw Exception('Failed'); }
  }
}

Future<bool> connect(String username) async{
  
  final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/join/'+ username);
  
  if(response.statusCode == 200){ return true; }
  else{ return false; }
}

class Item {
  String joueurs;

  Item({this.joueurs});
  factory Item.fromJson(dynamic json){
    return Item(joueurs: json['joueurs'] as String);
  }
}





