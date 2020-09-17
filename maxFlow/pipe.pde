class Pipe {
  Join minus ;
  Join plus ;
  int capacity ;
  int cost ;
  int flow ;
  
  Pipe(Join u, Join v, int ca, int co) {
    minus = u ;
    plus = v ;
    capacity = ca;
    cost = co;
    flow = 0;
  }
  int cost() {
    return flow * cost ;
  }
  boolean isFeasible() {
    return (flow >= 0 && flow <= capacity) ;
  }
  
  String toString() {
    return "(" + minus + "," + plus + "," + capacity + "," + flow + ")" ;
  }
}


class PipeSet extends ArrayList<Pipe> {
  PipeSet() {
  }
  PipeSet(JoinSet js, int[][] capacities, int[][] costs) {
    for(int i = 0 ; i < capacities.length ; i++){
      Join ji = js.get(i) ;
      for(int j = 0 ; j < capacities.length ; j++){
        if(capacities[i][j] > 0){
          Join jj = js.get(j) ;
          add(new Pipe(ji, jj, capacities[i][j], costs[i][j])) ;
        }
      }
    }
  }
  
  void setPipeSet() {
    for(Pipe p : this){
      p.minus.outGoing.add(p) ;
      p.plus.inComing.add(p) ;
    }
  }
  int flowValue() {
    int sum = 0 ;
    for(Pipe p : this){
      sum += p.flow ;
    }
    return sum ;
  }
  int cost() {
    int sum = 0 ;
    for(Pipe p : this)
      sum += p.cost() ;
    return sum ;
  }
  boolean isFeasible() {
    for(Pipe p : this)
      if(! p.isFeasible()) return false ;
    return true ;
  }
  boolean flowIsNotZero(int a, int b) {
    for(Pipe p : this){
      if(p.minus.index == a && p.plus.index == b){
        return p.flow != 0 ; 
      }
    }
    return false ;
  }
  
  String toString(){
    String[] stg = new String[size()] ;
    for(int i = 0 ; i < size() ; i++)
      stg[i] = get(i).toString() ;
    return "{" + join(stg, ",") + "}" ;
  }
}
