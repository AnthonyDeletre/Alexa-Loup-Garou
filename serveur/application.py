from flask import Flask
from datetime import datetime
# from flask_socketio import SocketIO, emit
# from flask_socketio import join_room, leave_room
from enum import Enum
from markupsafe import escape
import random

application = Flask(__name__)


# Constantes
class TypeCarte(Enum):
    VILLAGEOIS = 1
    LOUP = 2
    CUPIDON = 3
    FILLE = 4
    CHASSEUR = 5
    VOLEUR = 6
    SORCIERE = 7
    VOYANTE = 8


class EtatPartie(Enum):
    OFF = 0
    JOUR = 1
    VOYANTE = 2
    LOUPS = 3
    SORCIERE = 4
    VICTOIRE_VILLAGEOIS = 98
    VICTOIRE_LOUPS = 99


# Code Loup Garou
class Joueur:
    def __init__(self, nom):
        self.nom = nom
        self.vivant = True
        self.role = None


class Partie:
    def __init__(self):
        self.joueurs = []
        self.partieStatus = EtatPartie.OFF
        self.loupsVotes = {}
        self.villageoisVotes = {}  # Non utilisé...
        self.victimes = []

        self.messageSorciere = "Il ne se passe rien."
        self.sorVie = True
        self.sorMort = True

    def reset(self):
        self.joueurs.clear()
        self.loupsVotes.clear()
        self.villageoisVotes.clear()
        self.victimes.clear()
        self.messageSorciere = "Il ne se passe rien."
        self.sorVie = True
        self.sorMort = True
        self.partieStatus = EtatPartie.OFF

    def etatPartie(self):
        res = "<h1>Loup Garou - Alexa</h1>"
        res += "<h2>Etat de la partie: {}</h2>".format(self.partieStatus.name)
        res += "<h2>Joueurs</h2>"
        res += "<ul>"
        for x in self.joueurs:
            res += "<li>{}</li>".format(x.nom)
        res += "</ul>"
        return res

    def joueursVivants(self):
        res = []
        for x in self.joueurs:
            if x.vivant == True:
                res.append(x.nom)
        return res

    def jsonEtatPartie(self):
        res = {"etat": str(self.partieStatus), "joueursVivants": self.joueursVivants()}
        return res

    def listeJoueurs(self):
        res = {"joueurs": []}
        for x in self.joueurs:
            res["joueurs"].append(x.nom)
        return res

    def ajtJoueur(self, nomJoueur):
        nomJoueur = escape(nomJoueur)
        print(nomJoueur)
        if not self.joueurDansPartie(nomJoueur):
            self.joueurs.append(Joueur(nomJoueur))
            return {"response": "200", "message": "Joueur {} ajouté".format(nomJoueur)}
        else:
            return {"response": "403", "message": "Joueur {} déjà dans la partie".format(nomJoueur)}

    def joueurDansPartie(self, pseudo):
        for x in self.joueurs:
            if x.nom == pseudo:
                return True
            else:
                return False

    def debutPartie(self, nbLoups=1, voyante=True, chasseur=False):
        if len(self.joueurs) < 4:
            return {"response": "403",
                    "message": "Pas assez de joueurs. Il manque {} joueurs".format(4 - len(self.joueurs))}
        elif self.partieStatus != 0:
            return {"response": "403", "message": "Partie déjà commencée"}
        else:
            # Attribution des roles
            loups = 0
            while loups != nbLoups:
                x = random.randint()
                if self.joueurs[x].role is None:
                    self.joueurs[x].role = TypeCarte.LOUP
                    loups += 1
            if voyante:
                x = random.randint()
                if self.joueurs[x].role is None:
                    self.joueurs[x].role = TypeCarte.VOYANTE
            if chasseur:
                x = random.randint()
                if self.joueurs[x].role is None:
                    self.joueurs[x].role = TypeCarte.CHASSEUR
            for x in self.joueurs:
                if x.role is None:
                    x.role = TypeCarte.VILLAGEOIS

            # Debut Partie
            self.partieStatus = EtatPartie.VOYANTE
            return {"response": "200", "message": "La partie commence."}

    def etapeSuivante(self):
        if self.partieStatus == EtatPartie.JOUR:
            # Création liste vote loup
            self.victimes = []
            # Generation de la liste
            self.loupsVotes = {}
            for x in self.joueursVivants():
                if x.role == TypeCarte.LOUP and x.vivant == True:
                    self.loupsVotes[x.nom] = None

            # Si il y a une voyante:
            for x in self.joueurs:
                if x.vivant == True and x.role == TypeCarte.VOYANTE:
                    self.partieStatus = EtatPartie.VOYANTE
                    return
            self.partieStatus = EtatPartie.LOUPS
            return

        if self.partieStatus == EtatPartie.VOYANTE:
            self.partieStatus = EtatPartie.LOUPS
            return

        if self.partieStatus == EtatPartie.LOUPS:
            # Si il y a une sorcière
            for x in self.joueurs:
                if x.vivant == True and x.role == TypeCarte.SORCIERE:
                    self.partieStatus = EtatPartie.SORCIERE
                    return
            # Jour: On tue les victimes
            for x in self.victimes:
                for y in self.joueurs:
                    if y.nom == x:
                        y.vivant = False
            # Creation liste vote villageois
            # Generation de la liste
            self.villageoisVotes = {}
            for x in self.joueursVivants():
                if x.vivant == True:
                    self.villageoisVotes[x.nom] = None
            self.partieStatus = EtatPartie.JOUR
            return

        if self.partieStatus == EtatPartie.SORCIERE:
            for x in self.victimes:
                for y in self.joueurs:
                    if y.nom == x:
                        y.vivant = False
            self.partieStatus = EtatPartie.JOUR
            return

    def voyanteVision(self, joueur):
        # Si la voyante est vivante
        for x in self.joueurs:
            if x.role == TypeCarte.VOYANTE and x.vivant == True:
                if self.partieStatus == EtatPartie.VOYANTE:
                    for y in self.joueurs:
                        if y.nom == joueur:
                            if y.vivant == False:
                                return {"response": "403", "message": "Ce joueur est mort."}
                            else:
                                # Passage a la partie des Loups
                                self.etapeSuivante()

                                return {"response": "200", "joueur": joueur, "role": y.role.name,
                                        "message": "Le joueur {} est {}".format(y.nom, y.role.name)}
                else:
                    return {"response": "403", "message": "Ce n'est pas le moment de regarder la carte de quelqu'un."}

    def loupsVoter(self, loup, victime):
        if self.partieStatus == EtatPartie.LOUPS:
            if loup in self.loupsVotes:
                if victime in self.joueursVivants():
                    self.loupsVotes[loup] = victime
                    # Test pour voir si tous les loups ont voté
                    for x in self.loupsVotes:
                        if self.loupsVotes[x] is None:
                            return {"response": "200",
                                    "message": "Vote enregistré. D'autres loups sont encore en train de réfléchir."}
                    # Si tout le monde a voté: (202: Continue)
                    self.etapeSuivante()
                    res = list(self.loupsVotes.values())
                    if len(set(res)) == 1:
                        self.victimes.append(res[0])
                    else:
                        # Si il y a une égalité dans le nombre de votes, au hasard
                        if len(set(res)) == len(res):
                            self.victimes.append(random.choice(res))
                    return {"response": "202", "message": "Vote enregistré. Tous les loups ont voté."}
                else:
                    return {"response": "404", "message": "Ce joueur n'existe pas."}
            else:
                return {"response": "403", "message": "Vous ne pouvez pas voter."}
        else:
            return {"response": "403", "message": "Ce n'est pas le moment de manger quelqu'un."}

    def generationMsgSorciere(self):
        res = ""
        if self.sorVie:
            if len(self.victimes) == 0:
                res += "Il n'y a eu aucune victime cette nuit. "
            elif len(self.victimes) == 1:
                res += "Cette nuit, {} a été attaqué. ".format(self.victimes[0])
        else:
            res += "Vous n'avez plus de potion de vie. "

        if self.sorMort:
            res += "Vous avez une potion de mort. "
        else:
            res += "Vous n'avez plus de potion de mort"
        return {"response": "200", "vie": self.sorVie, "mort": self.sorMort, "message": res}

    def sorciere(self, vie=False, mort=None):
        # La sorcière peut sauver le villageois victime des loups, et / ou en tuer un de son choix.
        # Une fois par partie.
        if self.partieStatus == EtatPartie.SORCIERE:
            if self.sorVie == False and self.sorMort == False:
                # Passer directement a la suite.
                self.etapeSuivante()
            else:
                if vie is not None:
                    if self.sorVie:
                        # Sauve quelqu'un
                        self.victimes.clear()
                        self.sorVie = False
                    else:
                        return {"response": "403", "message": "Vous ne pouvez pas utiliser de potion de vie"}
                if mort is not None:
                    if self.sorMort:
                        # Tue quelqu'un
                        if mort in self.joueursVivants():
                            self.victimes.append(mort)
                            self.sorMort = False
                    else:
                        return {"response": "403", "message": "Vous ne pouvez pas utiliser de potion de mort"}
            # Si tout est bon:
            self.etapeSuivante()
            return {"response": "200", "message": "Fin du tour de la sorcière."}
        else:
            return {"response": '403', "message": "Ce n'est pas le moment d'utiliser des potions."}

    def generationMsgJour(self):
        if len(self.victimes) == 0:
            res = "Le jour se lève, et personne n'est mort."
        elif len(self.victimes) == 1:
            res = "Le jour se lève, sans {}.".format(self.victimes[0])
        else:
            res = "Le jour se lève, sans {}, ni {}".format(self.victimes[0], self.victimes[1])
        return res

    def countLoup(self):
        counter = 0
        for x in self.joueurs:
            if x.role == TypeCarte.LOUP and x.vivant == True:
                counter += 1
        # Condition de victoire: Les villagois gagnent si le compteur est à 0
        if counter == 0:
            self.partieStatus = EtatPartie.VICTOIRE_VILLAGEOIS
        return counter

    def countVillageois(self):
        counter = 0
        for x in self.joueurs:
            if x.role == TypeCarte.VILLAGEOIS and x.vivant == True:
                counter += 1
        # Condition de victoire: Les loups gagnent si le compteur est à 0 (techniquement, 1, mais bon)
        if counter == 0:
            self.partieStatus = EtatPartie.VICTOIRE_LOUPS
        return counter

    def villageoisVoteAlexa(self, victime):
        # A coder. A coder aussi, le remplacement du changement d'étape.
        if self.partieStatus == EtatPartie.JOUR:
            for x in self.joueurs:
                if x.nom == victime and x.vivant == True:
                    self.etapeSuivante()
                    return {"response": "200", "message": "Le village a décidé d'éliminer {}, qui était {}.".format(victime, x.role.name)}
                else:
                    return {"response": "403", "message": "Erreur. Le joueur {} n'existe pas ou est déjà mort.".format(victime)}
        else:
            return {"response": "403", "message": "Les villageois dorment, ce n'est pas le moment de voter."}


@application.route('/')
def hello_world():
    return partie.etatPartie()


@application.route('/demarrerpartie')
def demarrerpartie():
    # heure = datetime.now()
    return partie.debutPartie()


@application.route("/join/<pseudo>")
def join(pseudo):
    return partie.ajtJoueur(pseudo)


@application.route("/listejoueur")
def listejoueur():
    return partie.listeJoueurs()


@application.route("/status")
def status():
    return partie.jsonEtatPartie()


@application.route("/reset")
def reset():
    partie.reset()
    return {"response": "200", "message": "La partie a été réinitialisée."}


partie = Partie()

if __name__ == '__main__':
    application.debug = True
    application.run()
    # print("- - - SERVEUR - - -")
    # socketio.run(app)
