class Player {

  final int id;
  final String name;

  Player(this.id, this.name);

  static String idCarteToChemin(int role){
    switch(role){
      case 1:
        return "assets/images/cards/villager.png";
        break;
      case 2:
        return "assets/images/cards/wolf.png";
        break;
      case 3:
        return "assets/images/cards/cupidon.png";
        break;
      case 4:
        return "assets/images/cards/girl.png";
        break;
      case 5:
        return "assets/images/cards/hunter.png";
        break;
      case 6:
        return "assets/images/cards/thief.png";
        break;
      case 7:
        return "assets/images/cards/witch.png";
        break;
      case 8:
        return "assets/images/cards/seer.png";
        break;
      default:
        return "assets/images/cards/back.png";
        break;
    }
  }
  
}

List<Player> getListPlayer(){

  final List<Player> list = new List();

  list.add(new Player(1, 'Joueur 1'));


  return list;
}