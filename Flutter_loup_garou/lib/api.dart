import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

List<String> listeJoueur = new List();

class Data {

  Stream<String> get dialogueList async*{

    
    final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/');
    // final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/status');

    if(response.statusCode == 200){ yield response.body; /*yield Item.fromJson(response.body);*/ }
    else{ throw Exception('Failed'); }
  }

  Stream<List<String>> get joueurList async*{
    
    while(true){
      final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/listejoueur'); 
      if(response.statusCode == 200){
        yield listJoueurToString(response.body); 
      }
      else{ 
        throw Exception('Failed'); 
      }
      sleep(Duration(seconds: 1));
    }
  }
}

Future<bool> connect(String username) async{
  
  final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/join/'+ username);
  
  if(response.statusCode == 200){ return true; }
  else{ return false; }
}

// class Item {

//   String message;
  
//   Item({this.message});
  
//   factory Item.fromJson(dynamic json){
//     return Item(message: json['message'] as String);
//   }
// }

List<String> listJoueurToString(String json){

  List<String> ls = new List<String>();
  int i=0;
  int j=-1;

  while(json[i]!='['){
    i++;
  }
  i++;
  
  while(json[i]!=']'){

    if(json[i]=='"'){
      if(json[i+1] != ',' && json[i+1] != ']'){
        ls.add("");
        j++;
      }
    }else if(json[i] != ','){
      ls[j] = ls[j]+json[i];
    }
    i++;
  }
  
  return ls;
}