class Graph {
  NodeSet nodes ;
  EdgeSet edges ;
  Node source ;
  Node sink ;
  Graph(NodeSet ns, EdgeSet es, int sIndex, int tIndex) {
    nodes = ns ;
    edges = es ;
    source = ns.get(sIndex) ;
    sink = ns.get(tIndex) ;
    setEdgeSet() ;
  }
  void setEdgeSet() {
    nodes.setEdgeSet() ;
    edges.setEdgeSet() ;
  }
  EdgeSet findPath(Edge[] parentEdge) {
    EdgeSet es = new EdgeSet() ;
    Node u = sink ;
    while(u != source) {
      Edge e = parentEdge[u.index] ;
      if(e == null) {
        es.clear() ;
        break ;
      }
      es.add(e) ;
      u = e.minus ;
    }
    return es ;
  }
  EdgeSet leastEdgePath() {
    Edge[] parentEdge = breatheFirstSearch() ;
    return findPath(parentEdge) ;
  }
  EdgeSet largestBottleneckPath() {
    Edge[] parentEdge = modifiedDijkstra() ;
    return findPath(parentEdge) ;
  }
  Edge[] breatheFirstSearch() {
    Edge[] parentEdge = new Edge[nodes.size()] ;
    
    int UNDISCOVERED = 0 ;
    int DISCOVERED = 1 ;
    int EXPLORED = 2 ;
    int[] status = new int[nodes.size()] ;
    for(int i = 0 ; i < status.length ; i++)
      status[i] = UNDISCOVERED ;
      
    NodeSet queue = new NodeSet() ;
    status[source.index] = DISCOVERED ;
    queue.add(source) ;
    
    while(! queue.isEmpty()) {
      Node u = queue.remove(0) ;
      for(Edge e : u.outGoing) {
        Node v = e.plus ;
        if(status[v.index] != UNDISCOVERED) continue ;
        status[v.index] = DISCOVERED ;
        queue.add(v) ;
        parentEdge[v.index] = e ;
      }
      status[u.index] = EXPLORED ;
    }
    return parentEdge ;
  }
  Edge[] modifiedDijkstra() {
    Edge[] parentEdge = new Edge[nodes.size()] ;
    
    int[] d = new int[nodes.size()] ;
    d[source.index] = Integer.MAX_VALUE ;
    NodeSet T = (NodeSet) nodes.clone() ;
    
    while(! T.isEmpty()) {
      Node u = T.get(0) ;
      for(int i = 1 ; i < T.size() ; i++) {
        Node v = T.get(i) ;
        if(d[v.index] > d[u.index]) u = v ;
      }
      T.remove(u) ;
      for(Edge e : u.outGoing) {
        Node v = e.plus ;
        int c = min(d[u.index], e.weight) ;
        if(d[v.index] < c) {
          d[v.index] = c ;
          parentEdge[v.index] = e ;
        }
      }
    }
    return parentEdge ;
  }
  Node bellmanFord(Node s, Edge[] parentEdge) {
    int[] d = new int[nodes.size()];
    for(int i = 0 ; i < d.length ; i++)
      d[i] = Integer.MAX_VALUE ;
    d[s.index] = 0 ;
    for(int i = 1 ; i < nodes.size() ; i++)
      for(Node u : nodes)
        for(Edge e : u.outGoing) {
          Node v = e.plus ;
          if(d[v.index] > d[u.index] + e.weight) {
            d[v.index] = d[u.index] + e.weight ;
            parentEdge[v.index] = e ;
          }
        }
    for(Node u : nodes) {
      for(Edge e : u.outGoing) {
        Node v = e.plus ;
        if(d[v.index] > d[u.index] + e.weight) {
          parentEdge[v.index] = e ;
          return u ;
        }
      }
    }
    return null ;
  }
  EdgeSet findNegativeCycle(Node u, Edge[] parentEdgeEdge) {
    EdgeSet es = new EdgeSet() ;
    EdgeSet es2 = new EdgeSet() ;
    Edge e = parentEdgeEdge[u.index] ;
    es.add(parentEdgeEdge[u.index]) ;
    while(true) {
      e = parentEdgeEdge[e.minus.index] ;
      if(!es.contains(e)) {
        es.add(e) ;
      } else {
        boolean found = false ;
        for(Edge e1 : es) {
          if(e1 == e) found = true ;
          if(found) es2.add(e1) ;
        }
        break ;
      }
    }
  println("NegativeCostCycle = " + es2 + "\n") ;
  return es2 ;
  }
  
  String toString() {
    return nodes.toString() + "\n" + edges.toString() ;
  }
}
