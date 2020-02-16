import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

List<String> listeJoueur = new List();

class Data {

  Stream<String> get dialogueList async*{

    final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/status');

    if(response.statusCode == 200){ 

      var parsedJson = json.decode(response.body);
      var element = Message.fromJson(parsedJson);
      yield element.message;

    }
    else{ throw Exception('Failed'); }
  }
  
  // Stream<List<String>> get ListJoueur async*{
  //   Timer.periodic(Duration(seconds: 1), (t){
  //     return joueurList;
  //   });
  // }

  Stream<List<String>> get joueurList async*{
    
    // while(true){
    //   final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/listejoueur'); 
    //   if(response.statusCode == 200){
    //     yield listJoueurToString(response.body); 
    //   }
    //   else{ 
    //     throw Exception('Failed'); 
    //   }
    //   sleep(Duration(seconds: 1));
    // }

    final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/listejoueur'); 

    if(response.statusCode == 200){

      // var parsedJson = json.decode(response.body);
      // print(parsedJson);
      // var element = JoueurList.fromJson(parsedJson);
      // print(element);
      // yield element.joueurs;
      yield listJoueurToString(response.body); 
    }
    else{ 
      throw Exception('Failed'); 
    }
  }
}

Future<bool> connect(String username) async{
  
  final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/join/'+ username);
  
  if(response.statusCode == 200){ return true; }
  else{ return false; }
}

class Message {

  String message;
  
  Message({this.message});
  
  Message.fromJson(Map<String, dynamic> data)
      : message = data['message'];
}

// class JoueurList {

//   List<String> joueurs;
  
//   JoueurList({this.joueurs});
  
//   JoueurList.fromJson(Map<String, dynamic> data)
//       : joueurs = data['joueurs'];
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