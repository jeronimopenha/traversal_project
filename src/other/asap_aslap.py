import networkx as nx


g = nx.DiGraph(nx.nx_pydot.read_dot(
    '/home/jeronimo/Documents/GIT/traversal_project/bench/m_bench/dac/ewf.dot'))
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
nx.nx_pydot.write_dot(g,'./teste.dot')
    #print(i, ': ', n[i]['asap'], ' ', n[i]['alap'])
