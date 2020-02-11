class Player {

  final int id;
  final String name;

  Player(this.id, this.name);
}

List<Player> getListPlayer(){

  final List<Player> list = new List();

  list.add(new Player(1, 'Joueur 1'));
  list.add(new Player(2, 'Joueur 2'));
  list.add(new Player(3, 'Joueur 3'));
  list.add(new Player(4, 'Joueur 4'));
  list.add(new Player(5, 'Joueur 5'));
  list.add(new Player(6, 'Joueur 6'));
  list.add(new Player(7, 'Joueur 7'));

  return list;
}