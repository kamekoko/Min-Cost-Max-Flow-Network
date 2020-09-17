int[][] capacities ;
int[][] costs ;

void setup() {
  size(500, 500) ;
  background(255) ;
  makeNetwork() ;
  Network network = new Network(capacities, costs, 0, capacities.length - 1) ;
  println("Network\n" + network) ;
  network.findMaxFlow() ;
  println("\nMaxFlow Network\n" + network) ;
  network.minCostFlow() ;
  println("MinCost MaxFlow Network\n" + network) ;
  exit() ;
}

void makeNetwork() {
  int n = 5 ;
  capacities = new int[n + 2][n + 2] ;
  costs = new int[n + 2][n + 2] ;
  int len = capacities.length ;
  for(int i = 0 ; i < len ; i++){
    for(int j = 1 ; j < len ; j++){
      if(i == j || (i == 0 && j == len - 1) || i == len - 1 || capacities[j][i] != 0) continue ;
      if(i == 0 && j != len - 1) {
        capacities[i][j] = (int)random(1,11) ;
        costs[i][j] = (int)random(1, 11) ;
        if(random(1) < 0.2) costs[i][j] *= -1 ;
        continue ;
      }
      if(j == len - 1) {
        capacities[i][j] = (int)random(1,11) ;
        costs[i][j] = (int)random(1, 11) ;
        if(random(1) < 0.2) costs[i][j] *= -1 ;
        continue ;
      }
      if(random(1) > 0.4) {
        capacities[i][j] = (int)random(1,11) ;
        costs[i][j] = (int)random(1, 11) ;
        if(random(1) < 0.2) costs[i][j] *= -1 ;
      }
    }
  }
  prin(capacities, costs) ;
}

void prin(int[][] capa, int[][] costs) {
  println("capacities = ") ;
  for(int i = 0 ; i < capa.length ; i++){
    print("{") ;
    for(int j = 0 ; j < capa.length ; j++){
      print(capa[i][j]) ;
      if(j != capa.length - 1) print(",\t") ;
    }
    println("}") ;
  }
  println("costs = ") ;
  for(int i = 0 ; i < costs.length ; i++){
    print("{") ;
    for(int j = 0 ; j < costs.length ; j++){
      print(costs[i][j]) ;
      if(j != costs.length - 1) print(",\t") ;
    }
    println("}") ;
  }
  println() ;

}
