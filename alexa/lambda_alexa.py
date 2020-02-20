# -*- coding: utf-8 -*-

# This sample demonstrates handling intents from an Alexa skill using the Alexa Skills Kit SDK for Python.
# Please visit https://alexa.design/cookbook for additional examples on implementing slots, dialog management,
# session persistence, api calls, and more.
# This sample is built using the handler classes approach in skill builder.
import logging
import ask_sdk_core.utils as ask_utils
import requests
from ask_sdk_core.skill_builder import SkillBuilder
from ask_sdk_core.dispatch_components import AbstractRequestHandler
from ask_sdk_core.dispatch_components import AbstractExceptionHandler
from ask_sdk_core.handler_input import HandlerInput

from ask_sdk_model import Response

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)



class LaunchRequestHandler(AbstractRequestHandler):
    """Handler for Skill Launch."""
    def can_handle(self, handler_input):
        # type: (HandlerInput) -> bool

        return ask_utils.is_request_type("LaunchRequest")(handler_input)

    def handle(self, handler_input):
        # type: (HandlerInput) -> Response
        speak_output = "Jeu Loup Garou"

        return (
            handler_input.response_builder
                .speak(speak_output)
                .ask(speak_output)
                .response
        )

# http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/


class TestRequests:

    @staticmethod
    def commencerLaPartie():
        url = "http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/demarrerpartie"
        try:
            response = requests.get(url)
        except Exception as err:
            print(f'Other error occurred: {err}')  # Python 3.6
        else:
            dicto = response.json()
            return dicto["message"]
        return None
        
    @staticmethod
    def finDeLaPartie():
        url = "http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/reset"
        try:
            response = requests.get(url)
        except Exception as err:
            print(f'Other error occurred: {err}')  # Python 3.6
        # else:
        #     dicto = response.json()
        #     return dicto["message"]
        # return None
            
    @staticmethod
    def voteVillageois(numeroJoueur):
        url = "http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/villageoisvote/"+numeroJoueur
        try:
            response = requests.get(url)
        except Exception as err:
            print(f'Other error occurred: {err}')  # Python 3.6
        else:
            dicto = response.json()
            return dicto["message"]
        return None
    
    @staticmethod
    def choixChasseur(numeroJoueur):
        url = "http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/chasseur/"+numeroJoueur
        try:
            response = requests.get(url)
        except Exception as err:
            print(f'Other error occurred: {err}')  # Python 3.6
        else:
            dicto = response.json()
            return dicto["message"]
        return None


    @staticmethod
    def getEtatPartie():
        url = "http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/status"
        try:
            response = requests.get(url)
        except Exception as err:
            print(f'Other error occurred: {err}')  # Python 3.6
        else:
            dicto = response.json()
            return dicto["message"]
        return None


class CommencerLaPartieIntentHandler(AbstractRequestHandler):
    # Debut de partie 
    def can_handle(self, handler_input):
        return ask_utils.is_intent_name("CommencerLaPartieIntent")(handler_input)
    
    def handle(self, handler_input):
        
        request = handler_input.request_envelope.request
        intent = request.intent
        
        speak_output = "MESSAGE PAR DEFAUT"
        
        if(intent.confirmation_status.__str__() == "IntentConfirmationStatus.CONFIRMED"):
            speak_output = TestRequests.commencerLaPartie() 
            if speak_output == None:
                speak_output = "Erreur lors du demarrage de la partie"
        
        
        if(intent.confirmation_status.__str__() == "IntentConfirmationStatus.DENIED"):
            speak_output = "Ok pas de problème. Dites-moi quand vous êtes pret"
        
        return (
            handler_input.response_builder.speak(speak_output)
            # .ask(speak_output)
            .response
        )


class EtatPartieIntentHandler(AbstractRequestHandler):
    # Recupere etat de la partie et dit des phrases 
    def can_handle(self, handler_input):
        return ask_utils.is_intent_name("EtatPartieIntent")(handler_input)
    
    def handle(self, handler_input):
        speak_output = TestRequests.getEtatPartie() 
        if speak_output == None:
            speak_output = "Erreur lors du demarrage de la partie"
        return (
            handler_input.response_builder.speak(speak_output)
            # .ask(speak_output)
            .response
        )



class ChasseurChoixHandler(AbstractRequestHandler):
    # Handler pour le choix du chasseur lorsqu'il est elimine
    def can_handle(self, handler_input):
        return ask_utils.is_intent_name("ChasseurChoixIntent")(handler_input)

    def handle(self, handler_input):
        request = handler_input.request_envelope.request
        intent = request.intent
        
        slots = intent.slots
        numeroJoueur = slots['NumeroJoueur']
        
        speak_output = "MESSAGE PAR DEFAUT"
        
        if(intent.confirmation_status.__str__() == "IntentConfirmationStatus.CONFIRMED"):
            if numeroJoueur.value is None or numeroJoueur.value == "?":
                speak_output = "Je n'ai pas compris ce que vous avez dit"
            else: # ca marche pas
                # speak_output = numeroJoueur.value
                speak_output = TestRequests.choixChasseur(numeroJoueur.value)
                if speak_output == None:
                    speak_output = "Erreur lors de l'elimination du joueur"
            
        if(intent.confirmation_status.__str__() == "IntentConfirmationStatus.DENIED"):
            speak_output = "Ok, pas de problème"
        
        return (
            handler_input.response_builder.speak(speak_output)
            # .ask(speak_output)
            .response
        )
        
        
            
    

class VillageoisVoteHandler(AbstractRequestHandler):
    # Handler pour le vote des villageois le jour 
    def can_handle(self, handler_input):
        return ask_utils.is_intent_name("VillageoisVoteIntent")(handler_input)

    def handle(self, handler_input):
        request = handler_input.request_envelope.request
        intent = request.intent
        
        slots = intent.slots
        numeroJoueur = slots['NumeroJoueur']
        
        speak_output = "MESSAGE PAR DEFAUT"
        
        if(intent.confirmation_status.__str__() == "IntentConfirmationStatus.CONFIRMED"):
            if numeroJoueur.value is None or numeroJoueur.value == "?":
                speak_output = "Je n'ai pas compris ce que vous avez dit"
            else: # ca marche pas
                # speak_output = numeroJoueur.value
                speak_output = TestRequests.voteVillageois(numeroJoueur.value)
                if speak_output == None:
                    speak_output = "Erreur lors du choix"
            
        if(intent.confirmation_status.__str__() == "IntentConfirmationStatus.DENIED"):
            speak_output = "Ok, pas de problème"
        
        return (
            handler_input.response_builder.speak(speak_output)
            # .ask(speak_output)
            .response
        )
        
    

# class TestRecupererMotHandler(AbstractRequestHandler):
#     # Handler pour recupere le nom d'un joueur 
#     def can_handle(self, handler_input):
#         return ask_utils.is_intent_name("TestRecupererMotIntent")(handler_input)
#     def handle(self, handler_input):
#         # .reprompt(repromptSpeechOutput)
# 		#   .getResponse();
#         # return (
#         #     handler_input.response_builder.speak("testttt").ask("yoo").response
#         # )
#         slots = handler_input.request_envelope.request.intent.slots
#         numeroJoueur = slots['NumeroJoueur']
#         if numeroJoueur.value:
#             speak_output = numeroJoueur.value
#         else: # ca marche pas
#             speak_output = "Je n'ai pas compris ce que vous avez dit"
#         if(handler_input.request_envelope.request == "DENIED"):
#             return handler_input.response_builder.speak("Vous avez annulé votre choix.").ask("Vous avez annulé votre choix.").response
#         return ( handler_input.response_builder.speak(speak_output).ask(speak_output).response)

    



# class HelloWorldIntentHandler(AbstractRequestHandler):
#     """Handler for Hello World Intent."""
#     def can_handle(self, handler_input):
#         # type: (HandlerInput) -> bool
#         return ask_utils.is_intent_name("HelloWorldIntent")(handler_input)
#     def handle(self, handler_input):
#         # type: (HandlerInput) -> Response
#         speak_output = "Hello World!"
#         return (
#             handler_input.response_builder
#                 .speak(speak_output)
#                 # .ask("add a reprompt if you want to keep the session open for the user to respond")
#                 .response
#         )

# class HeureIntentHandler(AbstractRequestHandler):
#     # Handler pour l'heure 
#     def can_handle(self, handler_input):
#         return ask_utils.is_intent_name("HeureIntent")(handler_input)
#     def handle(self, handler_input):
#         # TEST: Récupère l'heure depuis un serveur Flask, hosté sur EBS
#         res = requests.get("http://loupgarouserveur-env.5p6f8pdp73.us-east-1.elasticbeanstalk.com/heure").json()
#         speak_output = "Il est {} heure {}.".format(res["heure"], res["minute"])
#         return (
#             handler_input.response_builder.speak(speak_output).ask(speak_output).response
#         )


# class PremierPhraseTestIntent(AbstractRequestHandler):
#     # Debut de partie 
#     def can_handle(self, handler_input):
#         return ask_utils.is_intent_name("DebutPartieIntent")(handler_input)

#     def handle(self, handler_input):
#         speak_output = "La nuit tombe et tout le village s'endort. Dans ce calme plat, la voyante se réveille et scrupte les pensées d'un villageois."

#         return (
#             handler_input.response_builder.speak(speak_output).ask(speak_output).response
#         )

class HelpIntentHandler(AbstractRequestHandler):
    """Handler for Help Intent."""
    def can_handle(self, handler_input):
        # type: (HandlerInput) -> bool
        return ask_utils.is_intent_name("AMAZON.HelpIntent")(handler_input)

    def handle(self, handler_input):
        # type: (HandlerInput) -> Response
        speak_output = "You can say hello to me! How can I help?"

        return (
            handler_input.response_builder
                .speak(speak_output)
                .ask(speak_output)
                .response
        )

class CancelOrStopIntentHandler(AbstractRequestHandler):
    """Single handler for Cancel and Stop Intent."""
    def can_handle(self, handler_input):
        # type: (HandlerInput) -> bool
        return (ask_utils.is_intent_name("AMAZON.CancelIntent")(handler_input) or
                ask_utils.is_intent_name("AMAZON.StopIntent")(handler_input))

    def handle(self, handler_input):
        # type: (HandlerInput) -> Response
        speak_output = "Fin de la partie."
        TestRequests.finDeLaPartie()
        return (
            handler_input.response_builder
                .speak(speak_output)
                .response
        )


class SessionEndedRequestHandler(AbstractRequestHandler):
    """Handler for Session End."""
    def can_handle(self, handler_input):
        # type: (HandlerInput) -> bool
        return ask_utils.is_request_type("SessionEndedRequest")(handler_input)

    def handle(self, handler_input):
        # type: (HandlerInput) -> Response

        # Any cleanup logic goes here.

        return handler_input.response_builder.response


class IntentReflectorHandler(AbstractRequestHandler):
    """The intent reflector is used for interaction model testing and debugging.
    It will simply repeat the intent the user said. You can create custom handlers
    for your intents by defining them above, then also adding them to the request
    handler chain below.
    """
    def can_handle(self, handler_input):
        # type: (HandlerInput) -> bool
        return ask_utils.is_request_type("IntentRequest")(handler_input)

    def handle(self, handler_input):
        # type: (HandlerInput) -> Response
        intent_name = ask_utils.get_intent_name(handler_input)
        speak_output = "You just triggered " + intent_name + "."

        return (
            handler_input.response_builder
                .speak(speak_output)
                # .ask("add a reprompt if you want to keep the session open for the user to respond")
                .response
        )


class CatchAllExceptionHandler(AbstractExceptionHandler):
    """Generic error handling to capture any syntax or routing errors. If you receive an error
    stating the request handler chain is not found, you have not implemented a handler for
    the intent being invoked or included it in the skill builder below.
    """
    def can_handle(self, handler_input, exception):
        # type: (HandlerInput, Exception) -> bool
        return True

    def handle(self, handler_input, exception):
        # type: (HandlerInput, Exception) -> Response
        logger.error(exception, exc_info=True)

        speak_output = "Sorry, I had trouble doing what you asked. Please try again."

        return (
            handler_input.response_builder
                .speak(speak_output)
                .ask(speak_output)
                .response
        )

# The SkillBuilder object acts as the entry point for your skill, routing all request and response
# payloads to the handlers above. Make sure any new handlers or interceptors you've
# defined are included below. The order matters - they're processed top to bottom.


sb = SkillBuilder()

sb.add_request_handler(LaunchRequestHandler())
sb.add_request_handler(CommencerLaPartieIntentHandler())
sb.add_request_handler(EtatPartieIntentHandler())
sb.add_request_handler(VillageoisVoteHandler())
sb.add_request_handler(ChasseurChoixHandler())


#sb.add_request_handler(CreerJoueurHandler())
# sb.add_request_handler(TestRecupererMotHandler())
#sb.add_request_handler(RecupererNewMotHandler())
#sb.add_request_handler(HelloWorldIntentHandler())
# sb.add_request_handler(PremierPhraseTestIntent())
#sb.add_request_handler(HeureIntentHandler())
sb.add_request_handler(HelpIntentHandler())
sb.add_request_handler(CancelOrStopIntentHandler())
sb.add_request_handler(SessionEndedRequestHandler())
sb.add_request_handler(IntentReflectorHandler()) # make sure IntentReflectorHandler is last so it doesn't override your custom intent handlers

sb.add_exception_handler(CatchAllExceptionHandler())

lambda_handler = sb.lambda_handler()