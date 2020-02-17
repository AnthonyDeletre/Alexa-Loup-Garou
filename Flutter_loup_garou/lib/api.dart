import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

List<String> listeJoueur = new List();
int refreshRate = 500; //in ms

class Data {

  Stream<String> get dialogueList async*{
    while(true){
      final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/status');

      if(response.statusCode == 200){ 

        var parsedJson = jsonDecode(response.body)['message'];
        String message = parsedJson != null ? parsedJson : "";

        yield message;
      }else{ 
        throw Exception('Failed');
      }
      await Future.delayed(Duration(milliseconds: refreshRate));
    }
  }

  Stream<List<String>> get joueurList async*{
    while(true){
      final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/listejoueur'); 

      if(response.statusCode == 200){

        var parsedJson = jsonDecode(response.body)['joueurs'];
        List<String> joueurs = parsedJson != null ? List.from(parsedJson) : "";

        yield joueurs;
      }else{ 
        throw Exception('Failed'); 
      }
      await Future.delayed(Duration(milliseconds: refreshRate));
    }
  }
}

Future<bool> connect(String username) async{
  
  final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/join/'+ username);
  
  if(response.statusCode == 200){ return true; }
  else{ return false; }
}