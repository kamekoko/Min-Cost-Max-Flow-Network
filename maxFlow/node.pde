class Node {
  int index ;
  EdgeSet inComing ;
  EdgeSet outGoing ;
  Join join ;
  Node() {
  }
  Node(Join j) {
    join = j ;
    index = join.index ;
  }
  void setEdgeSet() {
    inComing = new EdgeSet() ;
    outGoing = new EdgeSet() ;
  }
  
  String toString() {
    return str(index) ;
  }
}


class NodeSet extends ArrayList<Node> {
  NodeSet(){
  }
  NodeSet(JoinSet js) {
    for(Join join : js)
      add(new Node(join)) ;
  }
  void setEdgeSet() {
    for(Node u : this)
      u.setEdgeSet() ;
  }
  
  String toString() {
    String[] stg = new String[size()] ;
    for(int i = 0 ;i < size() ; i++)
      stg[i] = get(i).toString() ;
    return "{" + join(stg, ",") + "}" ;
  }
}
