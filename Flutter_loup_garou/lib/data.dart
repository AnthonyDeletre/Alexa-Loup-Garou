class Player {

  final int id;
  final String name;
  final int card;

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
  
  Player(this.id, this.name, this.card);
}

List<Player> getListPlayer(){

  final List<Player> list = new List();

  list.add(new Player(1, 'Joueur 1', 1));
  list.add(new Player(2, 'Joueur 2', 2));
  list.add(new Player(3, 'Joueur 3', 3));
  list.add(new Player(4, 'Joueur 4', 4));
  list.add(new Player(5, 'Joueur 5', 5));
  list.add(new Player(6, 'Joueur 6', 6));
  list.add(new Player(7, 'Joueur 7', 7));

  return list;
}

