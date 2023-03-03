import os
import shutil
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import traceback
import networkx as nx
import random as rnd

if __name__ == '__main__':
    try:
        rnd.seed(0)

        input_file = './bench/test_bench/test_simul/original/test_simul.dot'
        output_path = './bench/test_bench/test_simul/'
        qty = [1, 60, 60, 60]

        for i in range(1, 4, 1):
            path = '%scost_%d/' % (output_path, i)
            if os.path.exists(path):
                shutil.rmtree(path)
            os.mkdir(path)

            for j in range(qty[i]):
                g = nx.DiGraph(nx.nx_pydot.read_dot(input_file))
                nodes = g.nodes()
                while '\\n' in nodes.keys():
                    g.remove_node('\\n')
                edges = list(g.edges)
                choices = []
                total_cost = i
                while total_cost > 0:
                    choice = rnd.choice(edges)
                    cost = rnd.randint(1, i)
                    if total_cost-cost < 0:
                        continue
                    total_cost -= cost
                    choices.append([choice, cost])
                    edges.remove(choice)

                for p in g.edges._adjdict.keys():
                    for s in g.edges._adjdict[p].keys():
                        for c in choices:
                            if p == c[0][0] and s == c[0][1]:
                                g.edges._adjdict[p][s]['w'] = str(c[1])
                                g.edges._adjdict[p][s]['label'] = g.edges._adjdict[p][s]['w']
                                choices.remove(c)
                                break

                nx.nx_pydot.write_dot(g, '%stest_simul_%d.dot' % (path, j))


    except Exception as e:
        print(e)
        traceback.print_exc()
