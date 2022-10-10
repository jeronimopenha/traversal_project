import networkx as nx
from numpy import empty
import pygraphviz as pgv


class TrGraph:
    def __init__(self, dot: str):
        self.dot = dot
        self.nodes = []
        self.n_nodes = 0
        self.edges = []
        self.get_dot_vars()

    def get_dot_vars(self):
        dot = self.dot
        # g = nx.Graph(nx.nx_pydot.read_dot(dot))
        gv = pgv.AGraph(dot, strict=False, directed=True)
        g = nx.DiGraph(gv)
        self.nodes = list(g.nodes)
        self.n_nodes = len(self.nodes)
        edges = list(g.edges)

        # finding the bottom node (with no successors)
        lower_node = None
        for p in g._succ:
            if len(g._succ[p]) == 0:
                lower_node = p
                break

        '''# finding the longest path from the top nodes
        first_node = None
        for n in lower_node.keys():
            su = g.successors(n)
            counter = 0
            while True:
                try:
                    s = su.__next__()
                    counter += 1
                    su = g.successors(s)
                except:
                    lower_node[n] = counter
                    if first_node is None:
                        first_node = n
                    elif lower_node[first_node] < lower_node[n]:
                        first_node = n
                    break'''

        # creating the edges list
        r = lower_node
        q = []
        q.append(r)
        working = True
        while working:
            working = False
            for e in edges:
                if e[1] == r:
                    self.edges.append((e[1], e[0]))
                    edges.remove(e)
                    q.append(e[0])
                    r = e[0]
                    working = True
                    break
            if q and edges and not working:
                q = q[:-1]
                if q:
                    r = q[-1]
                    working = True
                '''elif edges:
                    q.append(edges[0][0])
                    r = edges[0][0]
                    working = True'''
