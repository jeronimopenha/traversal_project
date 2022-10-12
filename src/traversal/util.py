import networkx as nx
from numpy import empty
import pygraphviz as pgv


class TrGraph:
    def __init__(self, dot: str):
        self.dot = dot
        self.nodes = []
        self.n_nodes = 0
        #self.edges = []
        self.g = None
        self.get_dot_vars()

    def get_dot_vars(self):
        dot = self.dot
        # g = nx.Graph(nx.nx_pydot.read_dot(dot))
        gv = pgv.AGraph(dot, strict=False, directed=True)
        self.g = nx.DiGraph(gv)
        self.nodes = list(self.g.nodes)
        self.n_nodes = len(self.nodes)

    def depth_algorithm(self) -> list():
        temp_edges = list(self.g.edges)
        r_edges = []

        # finding the bottom node (with no successors)
        lower_node = None
        for p in self.g._succ:
            if len(self.g._succ[p]) == 0:
                lower_node = p
                break

        # creating the edges list
        r = lower_node
        q = []
        q.append(r)
        working = True
        while working:
            working = False
            for e in temp_edges:
                if e[1] == r:
                    r_edges.append([e[1], e[0]])
                    temp_edges.remove(e)
                    q.append(e[0])
                    r = e[0]
                    working = True
                    break
            if q and temp_edges and not working:
                q = q[:-1]
                if q:
                    r = q[-1]
                    working = True
                '''elif edges:
                    q.append(edges[0][0])
                    r = edges[0][0]
                    working = True'''
        return r_edges

    def zigzag_algorithm(g):

        OutputList = []
        # get the node inputs
        for n in g.nodes():
            if g.out_degree(n) == 0:
                OutputList.append([n, 'IN'])

        Stack = OutputList.copy()

        EDGES = []

        L_fanin, L_fanout = {}, {}
        for no in g:
            L_fanin[no] = list(g.predecessors(no))
            L_fanout[no] = list(g.successors(no))

        while Stack:
            a, direction = Stack.pop(0)  # get the top1

            fanin = len(L_fanin[a])     # get size fanin
            fanout = len(L_fanout[a])   # get size fanout

            if direction == 'IN':  # direction == 'IN'

                if fanout >= 1:  # Case 3

                    b = L_fanout[a][-1]  # get the element more the right side

                    for i in range(fanin):
                        Stack.insert(0, [a, 'IN'])
                    Stack.insert(0, [b, 'OUT'])  # insert into stack

                    L_fanout[a].remove(b)
                    L_fanin[b].remove(a)

                    EDGES.append([a, b, 0])

                elif fanin >= 1:  # Case 2

                    b = L_fanin[a][-1]      # get the elem more in the right

                    Stack.insert(0, [a, 'IN'])
                    for i in range(fanin):
                        Stack.insert(0, [b, 'IN'])

                    L_fanin[a].remove(b)
                    L_fanout[b].remove(a)

                    EDGES.append([a, b, 1])

            else:  # direction == 'OUT'

                if fanin >= 1:  # Case 3

                    b = L_fanin[a][0]  # get the element more left side

                    for i in range(fanout):
                        Stack.insert(0, [a, 'OUT'])
                    Stack.insert(0, [b, 'IN'])

                    L_fanin[a].remove(b)
                    L_fanout[b].remove(a)

                    EDGES.append([a, b, 1])

                elif fanout >= 1:  # Case 2

                    b = L_fanout[a][0]  # get the element more left side

                    Stack.insert(0, [a, 'OUT'])
                    for i in range(fanout):
                        Stack.insert(0, [b, 'OUT'])

                    L_fanout[a].remove(b)
                    L_fanin[b].remove(a)

                    EDGES.append([a, b, 0])

        return EDGES
