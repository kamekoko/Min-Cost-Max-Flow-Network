class Network {
  JoinSet joins ;
  PipeSet pipes ;
  Join source ;
  Join sink ;

  Network(int[][] capacities, int[][] costs, int sIndex, int tIndex) {
    joins = new JoinSet(capacities.length) ;
    pipes = new PipeSet(joins, capacities, costs) ;
    source = joins.get(sIndex) ;
    sink = joins.get(tIndex) ;
    setPipeSet() ;
  }
  void setPipeSet() {
    joins.setPipeSet() ;
    pipes.setPipeSet() ;
  }

  boolean isAdmissible() {
    return isFeasible() && isConservation() ;
  }
  boolean isFeasible() {
    return pipes.isFeasible() ;
  }
  boolean isConservation() {
    for (Join u : joins) {
      if (u == source || u == sink) continue ;
      if (!u.isConservation()) return false ;
    }
    return true ;
  }
  int flowValue() {
    return source.flowValue() ;
  }
  int cost() {
    return pipes.cost() ;
  }

  Graph residualGraph() {
    NodeSet ns = new NodeSet(joins) ;
    EdgeSet es = new EdgeSet() ;
    for (Pipe p : pipes) {
      int w = p.capacity - p.flow ;
      if (w > 0) es.add(new Edge(ns, p, true, w)) ;
      w = p.flow ;
      if (w > 0) es.add(new Edge(ns, p, false, w)) ;
    }
    return new Graph(ns, es, source.index, sink.index) ;
  }
  void findMaxFlow() {
    while (true) {
      Graph graph = residualGraph() ;
      EdgeSet path = graph.largestBottleneckPath() ;
      if (path.isEmpty()) break ;
      path.augment() ;
    }
  }
  Graph costGraph() {
    NodeSet ns = new NodeSet(joins) ;
    EdgeSet es = new EdgeSet() ;
    for (Pipe p : pipes) {
      int w = p.capacity - p.flow ;
      if (w > 0) es.add(new Edge(ns, p, false, p.cost)) ;
      w = p.flow ;
      if (w > 0) es.add(new Edge(ns, p, true, -p.cost)) ;
    }
    return new Graph(ns, es, source.index, sink.index) ;
  }
  void minCostFlow() {
    while (true) {
      Graph graph = costGraph() ;
      Edge[] parentEdge = new Edge[joins.size()] ;
      Node u = new Node() ;
      for (Node v : graph.nodes)
        if (v.join.index == source.index) {
          u = graph.bellmanFord(v, parentEdge) ;
          break ;
        }
      if (u == null) {
        println() ;
        break ;
      }
      EdgeSet es = graph.findNegativeCycle(u, parentEdge) ;
      Graph res = residualGraph() ;
      EdgeSet es2 = new EdgeSet() ;
      for (Edge e : es)
        for (Edge e2 : res.edges)
          if (e.minus.index == e2.plus.index && e.plus.index == e2.minus.index) es2.add(e2) ;
      es2.augment() ;
    }
  }
  String toString() {
    String str = new String() ;
    //str += joins.toString() + "\n" + pipes.toString() + "\n" ;
    return str + "Flow Value : " + flowValue() + "\n" + "Cost : " + cost() + "\n" ;
  }
}
