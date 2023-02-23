import os
import sys


if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import json
import csv
import wother.pr_graph as _u


input_path = '/home/jeronimo/Documents/GIT/traversal_project/bench/results/m_bench/simple_traverse/place_1000_tries/'
output_path = '/home/jeronimo/Documents/GIT/traversal_project/bench/results/m_bench/simple_traverse/place_1000_tries/'
files_l = []

stats = {}

for dir, folder, files in os.walk(input_path):
    flag = False
    for f in files:
        flag = True
        files_l.append(
            [os.path.join(dir, f), f, '%s.dot' % f.split('.')[0]])
    if flag:
        stat = {
            'n_placements': 0,
            'n_routes_valids': 0,
            'ideal_cost': 0,
            'place_min_cost': None,
            'place_max_cost': 0,
            'histogram': {}
        }
        stats['%s.dot' % f.split('.')[0]] = stat

for pl in files_l:
    f = open(pl[0])
    js_in_d = json.load(f)
    f.close()
    f_name = js_in_d['name']
    stats[f_name]['n_placements'] += 1
    if stats[f_name]['ideal_cost'] == 0:
        stats[f_name]['ideal_cost'] = js_in_d['ideal_cost']
    if js_in_d['total_cost'] > stats[f_name]['place_max_cost']:
        stats[f_name]['place_max_cost'] = js_in_d['total_cost']
    if stats[f_name]['place_min_cost'] is None:
        stats[f_name]['place_min_cost'] = js_in_d['total_cost']
    elif stats[f_name]['place_min_cost'] > js_in_d['total_cost']:
        stats[f_name]['place_min_cost'] = js_in_d['total_cost']
    edges = []
    aux = []
    for r in js_in_d['edges_costs']:
        aux.append(r)
    c = 1
    while aux:
        rmv = []
        for i in range(len(aux)):
            if aux[i][1] == c:
                edges.append(aux[i][0])
                rmv.append(aux[i])
        for i in rmv:
            aux.remove(i)
        c += 1
    place = js_in_d['placement']
    if 'mults' in f_name:
        a = 1
    done, route, dic_path = _u.routing_mesh(edges, js_in_d['grid_size'], place)
    if done:
        stats[f_name]['n_routes_valids'] += 1
        cost = 0
        for dp in dic_path.keys():
            cost += len(dic_path[dp])
        if str(cost) in stats[f_name]['histogram'].keys():
            stats[f_name]['histogram'][str(cost)] += 1
        else:
            stats[f_name]['histogram'][str(cost)] = 1
f = open('/home/jeronimo/Documents/GIT/traversal_project/bench/results/m_bench/simple_traverse/route/maze/stats.csv', 'w')
writer = csv.writer(f)
header = ['bench',
          'n_placements',
          'n_routes_valids',
          'ideal_cost',
          'place_min_cost',
          'place_max_cost',
          'histogram'
          ]

writer.writerow(header)
row = []
for b in stats.keys():
    row.append(b)
    row.append(stats[b]['n_placements'])
    row.append(stats[b]['n_routes_valids'])
    row.append(stats[b]['ideal_cost'])
    row.append(stats[b]['place_min_cost'])
    row.append(stats[b]['place_max_cost'])
    row.append(stats[b]['histogram'])
    writer.writerow(row)
    row.clear()
f.close()
