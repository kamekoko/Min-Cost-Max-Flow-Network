class Edge {
  Node minus ;
  Node plus ;
  int weight ;
  Pipe pipe ;
  Edge(NodeSet nodes, Pipe p , boolean isForward, int w) {
    minus = nodes.get(p.minus.index) ;
    plus = nodes.get(p.plus.index) ;
    if(! isForward) {
      Node u = minus ;
      minus = plus ;
      plus = u ;
    }
    weight = w ;
    pipe = p ;
  }
  void augment(int d) {
    if(pipe.plus.index != plus.index) d*= -1 ;
    pipe.flow += d ;
  }
  String toString() {
    return "(" + minus + "," + plus + "," + weight + ")" ;
  }
}


class EdgeSet extends ArrayList<Edge> {
  EdgeSet() {
  }
  void setEdgeSet() {
    for(Edge e : this) {
      e.minus.outGoing.add(e) ;
      e.plus.inComing.add(e) ;
    }
  }
  int bottleneck() {
    if(isEmpty()) return 0 ;
    int d = get(0).weight ;
    for(Edge e : this)
      d = min(d, e.weight) ;
    return d ;
  }
  void augment() {
    int d = bottleneck() ;
    for(Edge e : this)
      e.augment(d) ;
  }
  String toString() {
    String[] stg = new String[size()] ;
    for(int i = 0 ; i < size() ; i++)
      stg[i] = get(i).toString() ;
    return "{" + join(stg, ",") + "}\t" + bottleneck() ;
  }
}
