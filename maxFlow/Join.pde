class Join {
  int index ;
  PipeSet inComing ;
  PipeSet outGoing ;
  Join(int i) {
    index = i ;
  }
  void setPipeSet() {
    inComing = new PipeSet() ;
    outGoing = new PipeSet() ;
  }
  int flowValue() {
    return outGoing.flowValue() - inComing.flowValue() ;
  }
  boolean isConservation() {
    return (flowValue() == 0) ;
  }
  
  String toString() {
    return str(index) ;
  }
}


class JoinSet extends ArrayList<Join> {
  JoinSet(int n) {
    for(int i = 0 ; i < n ; i++)
      add(new Join(i)) ;
  }
  void setPipeSet(){
    for(Join u : this)
      u.setPipeSet() ;
  }
  
  String toString() {
    String[] stg = new String[size()] ;
    for(int i = 0 ; i < size() ; i++)
      stg[i] = get(i).toString() ;
    return "{" + join(stg, ",") + "}" ;
  }
}
