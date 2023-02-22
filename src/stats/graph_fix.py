import os
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import traceback
import networkx as nx


def graph_fix(sdot: str):
    g = nx.DiGraph(nx.nx_pydot.read_dot(sdot))
    # g.remove_node('\\n')
    nodes = g.nodes()
    edges = g.edges()
    port_count = {}
    while '\\n' in nodes.keys():
        g.remove_node('\\n')
    for p in nodes.keys():
        '''if p == '\\n':
            g.remove_node('\\n')
            continue'''
        lb = nodes[p]['label'] = nodes[p]['label'].lower().replace('_', '')

        port_count[p] = 0
        im = len(g._pred[p]) < 2
        # Finding the type of the node
        op = ''
        if 'mul' in lb:
            if im:
                op = 'muli'
            else:
                op = 'mul'
        elif 'add' in lb:
            if im:
                op = 'addi'
            else:
                op = 'add'
        elif 'sub' in lb:
            if im:
                op = 'subi'
            else:
                op = 'sub'
        elif 'reg' in lb or 'lod' in lb or 'load' in lb:
            im = False
            op = 'reg'
        elif 'const' in lb or 'in' in lb:
            im = False
            op = 'in'
        elif 'out' in lb or 'str' in lb or 'store' in lb:
            im = False
            op = 'out'
        else:
            im = False
            op = 'NONE'
        nodes[p]['op'] = op
        if im:
            nodes[p]['value'] = 2
    for p in edges._adjdict.keys():
        for s in edges._adjdict[p].keys():
            edges._adjdict[p][s]['port'] = str(port_count[s])
            edges._adjdict[p][s]['w'] = str(0)
            port_count[s] += 1
    nx.nx_pydot.write_dot(g, sdot)


if __name__ == '__main__':
    try:
        input_path = './bench/test_bench/'
        files_l = []

        for dir, folder, files in os.walk(input_path):
            flag = False
            for f in files:
                flag = True
                files_l.append(
                    [os.path.join(dir, f), f, '%s.dot' % f.split('.')[0]])

        for i in range(len(files_l)):
            graph_fix(files_l[i][0])
        #graph_fix('/home/jeronimo/Documentos/GIT/traversal_project/bench/test_bench/assincrono/collapse_pyr.dot')

    except Exception as e:
        print(e)
        traceback.print_exc()
