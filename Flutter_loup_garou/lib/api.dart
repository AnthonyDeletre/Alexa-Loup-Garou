import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

class Data {

  Stream<String> get dialogueList async*{
    
    final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com');

    if(response.statusCode == 200){ yield response.body; }
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


List<String> listJoueurToString(String json){
  List<String> ls = new List<String>();
  int i=0;
  while(json[i]!='['){
    i++;
  }
  i++;
  int j=-1;
  while(json[i]!=']'){//tant que pas fini
    if(json[i]=='"'){
      if(json[i+1] != ',' && json[i+1] != ']'){//début mot
        ls.add("");
        j++;
      }//else{//i = '"' && i+1 == ',' Fin du mot}
    }else{ //i != '"'
      if(json[i] != ','){ //i != {']' et '"' et ','}
        ls[j] = ls[j]+json[i];
      }
    }
    i++;
  }
  return ls;
}