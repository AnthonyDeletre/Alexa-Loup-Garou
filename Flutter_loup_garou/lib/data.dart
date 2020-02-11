class Player {

  final int id;
  final String name;

  Player(this.id, this.name);
}

List<Player> getListPlayer(){

  final List<Player> list = new List();

  list.add(new Player(1, 'Joueur 1'));


  return list;
}