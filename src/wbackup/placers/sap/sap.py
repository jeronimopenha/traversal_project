import os
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import traceback
import random as _r
import json
import time
from math import ceil, sqrt, exp
import multiprocessing as mp
import networkx as nx


def thread_function(id: int, n_threads: int, n_placements: int, return_dict: mp.Manager().dict(),
                    placements: dict(),
                    matrix_len: int,
                    matrix_len_sqrt: int
                    ):
    result = []
    for idx in range(id, n_placements, n_threads):
        if (idx < n_placements):
            print("Running placer %d" % idx)
            sa_placer(placements[str(idx)], matrix_len, matrix_len_sqrt)
            result.append([str(idx), placements[str(idx)]])
    return_dict[str(id)] = result


def sa_placer(initial_placement: dict(),
              matrix_len: int,
              matrix_len_sqrt: int
              ):
    placement = initial_placement['placement']
    edges = initial_placement['edges']
    # total_cost = initial_placement['initial_cost']
    total_swaps = 0

    # SA implementation
    t = 100
    while t >= 0.00001:
        if t < 1.2:
            a = 1
        for i in range(matrix_len):
            for j in range(matrix_len):
                if i == j:
                    continue
                if placement[i] is None and placement[j] is None:
                    continue
                initial_placement['total_tries'] += 1
                # Current costs for a and b
                a = placement[i]
                b = placement[j]
                curr_cost_a = 0
                curr_cost_b = 0
                edges_a_keys = []
                edges_b_keys = []
                for e in edges.keys():
                    if a is not None:
                        if edges[e]['a'] == a:
                            edges_a_keys.append(e)
                            curr_cost_a += edges[e]['final_cost']
                    if b is not None:
                        if edges[e]['a'] == b:
                            edges_b_keys.append(e)
                            curr_cost_b += edges[e]['final_cost']
                current_cost = curr_cost_a + curr_cost_b

                # New costs for a and b
                # for new 'a' position
                new_cost_a = 0
                edges_a_new_costs = []
                if a is not None:
                    n1 = j
                    for e in edges_a_keys:
                        v = edges[e]['b']
                        n2 = placement.index(v, 0, matrix_len)
                        if n2 == n1:
                            n2 = i
                        l1 = n1//matrix_len_sqrt
                        c1 = n1 % matrix_len_sqrt
                        l2 = n2//matrix_len_sqrt
                        c2 = n2 % matrix_len_sqrt
                        edge_cost = abs(l1-l2) + abs(c1-c2)
                        new_cost_a += edge_cost
                        edges_a_new_costs.append(edge_cost)
                        del n2, l1, l2, c1, c2, edge_cost, v
                    del n1

                # for new 'b' position
                new_cost_b = 0
                edges_b_new_costs = []
                if b is not None:
                    n1 = i
                    for e in edges_b_keys:
                        v = edges[e]['b']
                        n2 = placement.index(v, 0, matrix_len)
                        if n2 == n1:
                            n2 = j
                        l1 = n1//matrix_len_sqrt
                        c1 = n1 % matrix_len_sqrt
                        l2 = n2//matrix_len_sqrt
                        c2 = n2 % matrix_len_sqrt
                        edge_cost = abs(l1-l2) + abs(c1-c2)
                        new_cost_b += edge_cost
                        edges_b_new_costs.append(edge_cost)
                        del n2, l1, l2, c1, c2, edge_cost, v
                    del n1

                new_cost = new_cost_a + new_cost_b
                try:
                    valor = exp(-1*(new_cost-current_cost)/t)
                except Exception as e:
                    valor = 0
                rand = _r.random()
                if rand <= valor:
                    a = 1
                if new_cost < current_cost or rand <= valor:
                    placement[i], placement[j] = placement[j], placement[i]
                    initial_placement['total_cost'] += new_cost-current_cost
                    initial_placement['total_swaps'] += 1
                    for e in range(len(edges_a_keys)):
                        edges[edges_a_keys[e]]['final_cost'] = edges_a_new_costs[e]
                    for e in range(len(edges_b_keys)):
                        edges[edges_b_keys[e]]['final_cost'] = edges_b_new_costs[e]

                del a, b, curr_cost_a, curr_cost_b, edges_a_keys, edges_b_keys, e
                del new_cost_a, edges_a_new_costs, current_cost, new_cost, valor, rand
                del new_cost_b, edges_b_new_costs
                if initial_placement['total_cost'] == initial_placement['min_cost']:
                    return
            t *= 0.999
    return


def create_placement(g: nx.DiGraph,
                     n_placements: int = 1
                     ):
    # TODO
    # docstring

    # FIXME
    # for debug only
    _r.seed(0)

    nodes = list(g.nodes)
    n_nodes = len(nodes)
    matrix_len_sqrt = ceil(sqrt(n_nodes))
    matrix_len = matrix_len_sqrt*matrix_len_sqrt

    edges = list(g.edges)
    n_edges = len(edges)

    placements = {}
    # initialize the placements randomly
    for i in range(n_placements):
        n = nodes.copy()
        c = 0
        placements[str(i)] = {'min_cost': n_edges,
                              'initial_cost': 0,
                              'total_cost': 0,
                              'total_tries': 0,
                              'total_swaps': 0,
                              'placement': [],
                              'initial_placement': [None for j in range(matrix_len)],
                              'edges': {}
                              }
        while n:
            r = _r.randint(0, len(n)-1)
            placements[str(i)]['initial_placement'][c] = n[r]
            n.pop(r)
            c += 1
        placements[str(i)]['placement'] = placements[str(i)
                                                     ]['initial_placement'].copy()
    del i, c, n, r
    # calculating the total cost for every initial placement
    for i in range(n_placements):
        cost = 0
        for e in edges:
            # finding the positions for each node of the edge
            n1 = placements[str(i)]['initial_placement'].index(
                e[0], 0, matrix_len)
            n2 = placements[str(i)]['initial_placement'].index(
                e[1], 0, matrix_len)
            l1 = n1//matrix_len_sqrt
            c1 = n1 % matrix_len_sqrt
            l2 = n2//matrix_len_sqrt
            c2 = n2 % matrix_len_sqrt
            edge_cost = abs(l1-l2) + abs(c1-c2)
            placements[str(i)]['initial_cost'] += edge_cost
            placements[str(i)]['edges']['%s_%s' % (e[0], e[1])] = {}
            placements[str(i)]['edges']['%s_%s' % (e[0], e[1])]['a'] = e[0]
            placements[str(i)]['edges']['%s_%s' % (e[0], e[1])]['b'] = e[1]
            placements[str(i)]['edges']['%s_%s' %
                                        (e[0], e[1])]['initial_cost'] = edge_cost
            placements[str(i)]['edges']['%s_%s' %
                                        (e[0], e[1])]['final_cost'] = edge_cost
        placements[str(i)]['total_cost'] = placements[str(i)]['initial_cost']
    del i, e, n1, n2, l1, l2, c1, c2, edge_cost

    # executing the SA algorithm in multithreads
    threads = list()
    n_threads = os.cpu_count()
    manager = mp.Manager()
    return_dict = manager.dict()
    for i in range(min(n_threads, n_placements)):
        x = mp.Process(target=thread_function, args=(i,
                                                     n_threads,
                                                     n_placements,
                                                     return_dict,
                                                     placements,
                                                     matrix_len,
                                                     matrix_len_sqrt,
                                                     ))
        print("SA Main    : creating and starting %s." % x.name)
        threads.append(x)
        x.start()

    for th in threads:
        th.join()
        print("SA Main    : %s done." % th.name)

    for v in return_dict.values():
        for d in v:
            placements[d[0]] = d[1]
    return placements


if __name__ == '__main__':
    try:
        input_path = './bench/test_bench/'
        output_path = './exp_results/placements/sa/'
        n_exec = 1000
        files_l = []

        for dir, folder, files in os.walk(input_path):
            flag = False
            for f in files:
                flag = True
                files_l.append(
                    [os.path.join(dir, f), f, '%s.dot' % f.split('.')[0]])

        for i in range(len(files_l)):
            g = nx.DiGraph(nx.nx_pydot.read_dot(files_l[i][0]))
            ret = create_placement(g, n_exec)
            for j in range(len(ret)):
                # placement
                r_folder = '%s%s/' % (output_path,
                                      files_l[i][2].replace('.dot', ''))
                if not os.path.exists(r_folder):
                    os.mkdir(r_folder)
                pl_folder = '%spl/' % (r_folder)
                if not os.path.exists(pl_folder):
                    os.mkdir(pl_folder)
                with open('%s%s_%d.json' % (pl_folder, files_l[i][2], j), 'w') as json_file:
                    json.dump(ret[str(j)], json_file, indent=4)

                '''# dot with weighted edges
                dot_folder = '%sdot/' % (r_folder)
                if not os.path.exists(dot_folder):
                    os.mkdir(dot_folder)
                for k in ret.keys():
                    edges = ret[k]['edges']
                    for e in edges.keys():
                        p = edges[e]['a']
                        s = edges[e]['b']
                        w = str(edges[e]['final_cost']-1)
                        pr_graph.g.edges._adjdict[p][s]['w'] = w
                pr_graph.save_dot('%s%s_%d.dot' %
                                  (dot_folder, files_l[i][2], j))'''

    except Exception as e:
        print(e)
        traceback.print_exc()
