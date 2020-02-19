import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

int refreshRate = 500; //in ms

class Data {

  static bool isGettingList = true;
  static bool isGettingDialogue = true;
  static int nbJoueur = 0;
  static List<Joueur> detailListJoueur;
  static Joueur joueurCourant;

  Stream<String> get dialogueList async*{

    while(isGettingDialogue){

      final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/status');

      if(response.statusCode == 200){ 

        var parsedJson = jsonDecode(response.body)['message'];
        String message = parsedJson != null ? parsedJson : "";

        yield message;
      }
      else{ throw Exception('Failed'); }

      await Future.delayed(Duration(milliseconds: refreshRate));
    }
  }

  Stream<List<String>> get joueurList async*{

    while(isGettingList){
      
      final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/listejoueur'); 

      if(response.statusCode == 200){

        var parsedJson = jsonDecode(response.body)['joueurs'];
        List<String> joueurs = parsedJson != null ? List.from(parsedJson) : "";
        nbJoueur = joueurs.length;

        yield joueurs;
      }
      else{ throw Exception('Failed'); }

      await Future.delayed(Duration(milliseconds: refreshRate));
    }
  }

  Future<bool> connect(String username) async{
  
    final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/join/'+ username);
    
    if(response.statusCode == 200){ 

      final status = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/status');

      var parsedJson = jsonDecode(status.body)['joueurs'] as List;
      detailListJoueur = parsedJson.map((jsonObj) => Joueur.fromJson(jsonObj)).toList();
      setCurrentUser(username); // Sauvegarde le joueur courant

      return true;
    }
    else{ return false; }
  }

  void setCurrentUser(String username){

    for (Joueur j in detailListJoueur) {
      if(j.nom == username){ joueurCourant = j;}
    }
  }

  Future<bool> isPhaseVote(int role) async{
    bool response = false; 
    while(!response){
      final status = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/status');

      if(status.statusCode == 200){
        
        var parsedJson = jsonDecode(status.body)['etat'] as String;
        print('phase : '+parsedJson);

        switch(parsedJson){
          case 'EtatPartie.OFF' :
            return false;
            break;
            //TODO ajouter les phases de jeu et selon le role, renvoyer si on vote ou pas
        }
      }else{
        throw Exception('Failed'); }
      Future.delayed(Duration(seconds: 2));
    }
    return null;
  }

    Future<String> doVote(int role, int choix) async{//seul la voyante et les loups garous sont à gerer ( voir la sorciere )
      switch(role){ //TODO à changer pour le numéro de role du joueur
        case -1 : //Voyante
          final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/voyante/'+choix.toString());

          if(response.statusCode == 200){
            
            var parsedJson = jsonDecode(response.body)['message'] as String;
            print('phase : '+parsedJson);
            return parsedJson;
          }else{
            throw Exception('Failed'); 
          }
          break;
        case -1:  //loup-garou
          final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/');//TODO get API parce que j'ai oublié l'appel

          if(response.statusCode == 200){

            var parsedJson = jsonDecode(response.body)['message'] as String;
            print('phase : '+parsedJson);
            return parsedJson;

          }else{
            throw Exception('Failed'); 
          }
          break;
        default:
          return null;
          break;
      }
    }
    
}




class Joueur {

  String id;
  String nom;
  String role;
  String vivant;

  Joueur(this.id, this.nom, this.role, this.vivant);

  factory Joueur.fromJson(dynamic json) {
    return Joueur(json['id'] as String, json['nom'] as String, json['role'] as String, json['vivant'] as String);
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.nom}, ${this.role}; ${this.vivant} }';
  }
}

