import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_loup_garou/pages/voteScreen.dart';
import 'package:flutter_loup_garou/pages/deathScreen.dart';
import 'package:flutter_loup_garou/pages/gameScreen.dart';
import 'package:flutter_loup_garou/pages/finishScreen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:http/http.dart' as http;

int refreshRate = 500; //in ms

class Data {

  static bool isGettingList = true;
  static bool isGettingDialogue = true;
  static bool isGettingVote = true;
  static int nbJoueur = 0;
  static List<Joueur> detailListJoueur;
  static Joueur joueurCourant = new Joueur(null, null, null, null);

  Stream<String> dialogueList(BuildContext context) async*{

    while(isGettingDialogue){

      final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/status');

      if(response.statusCode == 200){ 

        var parsedJson = jsonDecode(response.body)['message'];
        String message = parsedJson != null ? parsedJson : "";
        String messageConvert = message.replaceAll(new RegExp('<[^>]+>'),'');

        yield messageConvert;

        await updateCurrentUser(); // Met à jour les détails du joueur
        
        if(joueurCourant.vivant == "True"){
          
          var etat = jsonDecode(response.body)['etat'];

          if(etat == "EtatPartie.VOYANTE" && joueurCourant.role == "VOYANTE"){
            isGettingDialogue = false;
            await Future.delayed(Duration(seconds: 15)); // Attend avant le vote

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VoteScreen()),
            );
          }    
          if(etat == "EtatPartie.LOUPS" && joueurCourant.role == "LOUP"){
            isGettingDialogue = false;
            await Future.delayed(Duration(seconds: 15)); // Attend avant le vote

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VoteScreen()),
            );
          } 
          if(etat == "EtatPartie.VICTOIRE_VILLAGEOIS"){
            isGettingDialogue = false;
            String value = "Villageois";
            await Future.delayed(Duration(seconds: 1)); // Attend avant le vote

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FinishScreen(value: value)),
            );
          }
          if(etat == "EtatPartie.VICTOIRE_LOUPS"){
            isGettingDialogue = false;
            String value = "Loups";
            await Future.delayed(Duration(seconds: 1)); // Attend avant le vote

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FinishScreen(value: value)),
            );
          }
        }
        else{
          isGettingDialogue = false;

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DeathScreen()),
          );
        }
      }
      else{ throw Exception('Failed'); }

      await Future.delayed(Duration(milliseconds: refreshRate));
    }
  }

  Stream<List<String>> joueurList(BuildContext context) async*{

    bool countNotif = false;

    while(isGettingList){

      final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/listejoueur'); 

      if(response.statusCode == 200){

        var parsedJson = jsonDecode(response.body)['joueurs'];
        List<String> joueurs = parsedJson != null ? List.from(parsedJson) : "";
        nbJoueur = joueurs.length;

        yield joueurs;
      }

      final status = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/status');

        if(status.statusCode == 200){
        
          var etat = jsonDecode(status.body)['etat'] as String;   
          
          if(etat == 'EtatPartie.OFF'){
            countNotif = true;
            while(etat == 'EtatPartie.OFF'){

              final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/listejoueur'); 

              if(response.statusCode == 200){

                var parsedJson = jsonDecode(response.body)['joueurs'];
                List<String> joueurs = parsedJson != null ? List.from(parsedJson) : "";
                nbJoueur = joueurs.length;

                yield joueurs;
              }

              final status = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/status');

              if(status.statusCode == 200){
        
                etat = jsonDecode(status.body)['etat'] as String;   
              }
              await Future.delayed(Duration(milliseconds: refreshRate));
            }

            await updateCurrentUser(); // Mise a jour des informations du joueur courant

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GameScreen()),
            );
          }
          else if(!countNotif){
              countNotif = true;
              showNotification('Une partie est déja en cours !');
          }
        }
    }
  }

  Future<bool> connect(String username) async{
  
    final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/join/'+ username);
    
    if(response.statusCode == 200){ 
      setCurrentUsername(username); // Sauvegarde le nom du joueur
      return true; 
    }
    else{ return false; }
  }

  Future updateCurrentUser() async{
  
    final status = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/status');

    var parsedJson = jsonDecode(status.body)['joueurs'] as List;
    detailListJoueur = parsedJson.map((jsonObj) => Joueur.fromJson(jsonObj)).toList();

    for (Joueur j in detailListJoueur) {
      if(j.nom == joueurCourant.nom){ 
        joueurCourant = j; 
      }
    }
    detailListJoueur.remove(joueurCourant.id);
  }

  void setCurrentUsername(String username){
    joueurCourant.nom = username;
  }

  Future doVote(int choix, BuildContext context) async{

    switch(joueurCourant.role){

      case "VOYANTE" :
        final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/voyante/'+ 
          
        listMinusSelf(Data.detailListJoueur,Data.joueurCourant)[choix].id.toString());

        if(response.statusCode == 200){
          
          var parsedJson = jsonDecode(response.body)['message'] as String;
          print('phase : '+ parsedJson);

          showNotification("Vous avez choisi " + listMinusSelf(Data.detailListJoueur,Data.joueurCourant)[choix].nom + ", il est " + listMinusSelf(Data.detailListJoueur,Data.joueurCourant)[choix].role);

          isGettingDialogue = true;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GameScreen()),
          );
        }
        else{ throw Exception('Failed'); }
        break;

      case "LOUP": 
        final response = await http.get('http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/loupsvote/' + joueurCourant.id + "/" + listMinusSelf(Data.detailListJoueur,Data.joueurCourant)[choix].id);

        print(response.body);
        if(response.statusCode == 200){

          var parsedJson = jsonDecode(response.body)['message'] as String;
          print('phase : '+ parsedJson);

          // showNotification("Les loups ont voté ! " + listMinusSelf(Data.detailListJoueur,Data.joueurCourant)[choix].nom + "est mort !");

          detailListJoueur.remove(detailListJoueur[choix].id);
          
          isGettingDialogue = true;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GameScreen()),
          );
        }
        else{ throw Exception('Failed'); }
        break;

      default:
        return null;
        break;
    }
  }

  List<Joueur> listMinusSelf(List<Joueur> lP, Joueur self){

    List<Joueur> lJ = List<Joueur>();

    for(int i=0;i<lP.length;i++){

      if(lP[i].nom != joueurCourant.nom){
        lJ.add(lP[i]);
      }
    }
    return lJ;
  }
}

void showNotification(String text){

  showOverlayNotification((context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: SafeArea(
        child: ListTile(
          leading: SizedBox.fromSize(
          size: const Size(50, 50),
          child: Icon(
              Icons.notifications_active,
              color: Color.fromRGBO(56, 36, 131, 1.0),
              size: 25,
            ),
          ),
          title: Text('Notificaton'),
          subtitle: Text(text, style: TextStyle(fontSize: 16)),
          trailing: InkWell(
            onTap: (){
              OverlaySupportEntry.of(context).dismiss();
            },
            child: Container(
              width: 50.0,
              height: 50.0,
              child: FlareActor(
                "assets/images/cross.flr", 
                animation: "Error",
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ),
          )
        ),
      ),
    );
  }, duration: Duration(seconds: 30));
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

  static String idCarteToChemin(String role){

    switch(role){
      case "VILLAGEOIS":
        return "assets/images/cards/villager.png";
        break;
      case "LOUP":
        return "assets/images/cards/wolf.png";
        break;
      case "CUPIDON":
        return "assets/images/cards/cupidon.png";
        break;
      case "FILLE":
        return "assets/images/cards/girl.png";
        break;
      case "CHASSEUR":
        return "assets/images/cards/hunter.png";
        break;
      case "VOLEUR":
        return "assets/images/cards/thief.png";
        break;
      case "SORCIERE":
        return "assets/images/cards/witch.png";
        break;
      case "VOYANTE":
        return "assets/images/cards/seer.png";
        break;
      default:
        return "assets/images/cards/back.png";
        break;
    }
  }
}



