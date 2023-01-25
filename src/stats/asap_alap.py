import os
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import traceback
import networkx as nx


def create_asap_alap(s_dot: str):
    g = nx.DiGraph(nx.nx_pydot.read_dot(s_dot))
    g.remove_node('\\n')
    nodes = g.nodes()
    edges = g.edges()
    q_asap = []
    q_alap = []
    n = {}
    for k in nodes.keys():
        if '\\n' in k:
            continue
        n[k] = {'asap': 0, 'alap': len(edges)+1, 'n_pred': len(g._pred[k]),
                'n_succ': len(g._succ[k]), 'succ': g._succ[k], 'pred': g._pred[k]}
        if len(g._pred[k]) == 0:
            q_asap.append(k)
        if len(g._succ[k]) == 0:
            q_alap.append(k)

    while q_asap:
        root = q_asap.pop(0)
        asap_root = n[root]['asap']
        for succ in n[root]['succ']:
            n[succ]['asap'] = max(asap_root+1, n[succ]['asap'])
            if succ in q_alap:
                n[succ]['alap'] = n[succ]['asap']
            n[succ]['n_pred'] -= 1
            if n[succ]['n_pred'] == 0:
                q_asap.append(succ)
    while q_alap:
        root = q_alap.pop(0)
        alap_root = n[root]['alap']
        for pred in n[root]['pred']:
            n[pred]['alap'] = min(alap_root-1, n[pred]['alap'])
            n[pred]['n_succ'] -= 1
            if n[succ]['n_succ'] == 0:
                q_alap.append(pred)

    for i in n.keys():
        g.nodes[i]['alap'] = n[i]['alap']
        g.nodes[i]['asap'] = n[i]['asap']
    nx.nx_pydot.write_dot(g, s_dot)


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
            create_asap_alap(files_l[i][0])

    except Exception as e:
        print(e)
        traceback.print_exc()
