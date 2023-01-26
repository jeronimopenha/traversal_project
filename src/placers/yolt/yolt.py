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


def yolt_placer(initial_placement: dict(),
                matrix_len: int,
                matrix_len_sqrt: int,
                distance_matrix: list(list()),
                nodes_positions: list()
                ):
    # FIXME Corrigir zigzag
    edges = initial_placement['edges']
    placement = initial_placement['placement']
    total_cost = 0
    for e in edges.keys():
        a = edges[e]['a']
        b = edges[e]['b']
        if nodes_positions[b] is None:
            while True:
                choice = _r.randint(0, matrix_len-1)
                if placement[choice] is None:
                    nodes_positions[b] = choice
                    placement[choice] = b
                    break
        d = 0
        positioned = False
        for dm_line in distance_matrix:
            d = d+1
            pl = nodes_positions[b]//matrix_len_sqrt
            pc = nodes_positions[b] % matrix_len_sqrt
            for dm_column in dm_line:
                nl = pl+dm_column[0]
                nc = pc+dm_column[1]
                if nl > matrix_len_sqrt-1 or \
                        nc > matrix_len_sqrt-1 or \
                        nl < 0 or nc < 0:
                    continue
                cell = nl*matrix_len_sqrt + nc
                if placement[cell] is None:
                    nodes_positions[a] = cell
                    placement[cell] = a
                    edges[e]['final_cost'] = d
                    total_cost += d
                    positioned = True
                    break
            if positioned:
                break


def get_edges_depth_first(g: nx.DiGraph()) -> list(list()):
    # FIXME Acertar o algoritmo para grafos não conectados
    # FIXME docstring
    """_summary_
        Returns a list of edges according
        with the depth first algorithm

    Args:
        self (_type_): _description_

    Returns:
        _type_: _description_
    """
    temp_edges = list(g.edges)
    r_edges = []

    # finding the bottom node (with no successors)
    lower_node = None
    for p in g._succ:
        if len(g._succ[p]) == 0:
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


def get_edges_zigzag(g: nx.DiGraph()) -> list(list()):
    # FIXME docstring
    """_summary_
        Returns a list of edges according
        with the zig zag algorithm
    Returns:
        _type_: _description_
    """

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

                # EDGES.append([a, b, 0])
                # EDGES.append([a, b, 'OUT'])
                EDGES.append([b, a])

            elif fanin >= 1:  # Case 2

                b = L_fanin[a][-1]      # get the elem more in the right

                Stack.insert(0, [a, 'IN'])
                for i in range(fanin):
                    Stack.insert(0, [b, 'IN'])

                L_fanin[a].remove(b)
                L_fanout[b].remove(a)

                # EDGES.append([a, b, 1])
                # EDGES.append([a, b, 'IN'])
                EDGES.append([b, a])

        else:  # direction == 'OUT'

            if fanin >= 1:  # Case 3

                b = L_fanin[a][0]  # get the element more left side

                for i in range(fanout):
                    Stack.insert(0, [a, 'OUT'])
                Stack.insert(0, [b, 'IN'])

                L_fanin[a].remove(b)
                L_fanout[b].remove(a)

                # EDGES.append([a, b, 1])
                # EDGES.append([a, b, 'IN'])
                EDGES.append([a, b])

            elif fanout >= 1:  # Case 2

                b = L_fanout[a][0]  # get the element more left side

                Stack.insert(0, [a, 'OUT'])
                for i in range(fanout):
                    Stack.insert(0, [b, 'OUT'])

                L_fanout[a].remove(b)
                L_fanin[b].remove(a)

                # EDGES.append([a, b, 0])
                # EDGES.append([a, b, 'OUT'])
                EDGES.append([a, b])

    return EDGES


def create_placement(g: nx.DiGraph(),
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
    # call zigzag function
    edges = get_edges_zigzag(g)
    n_edges = len(edges)

    # distance matrix construction
    distance_matrix = [[]for i in range((matrix_len_sqrt-1)*2)]
    for i in range(matrix_len_sqrt):
        for j in range(matrix_len_sqrt):
            if j == i == 0:
                continue
            d = i+j
            if [i, j] not in distance_matrix[d-1]:
                distance_matrix[d-1].append([i, j])
            if [i, -j] not in distance_matrix[d-1]:
                distance_matrix[d-1].append([i, -j])
            if [-i, -j] not in distance_matrix[d-1]:
                distance_matrix[d-1].append([-i, -j])
            if [-i, j] not in distance_matrix[d-1]:
                distance_matrix[d-1].append([-i, j])
    del i, j, d

    nodes_positions = {}
    for n in nodes:
        nodes_positions[n] = None
    del n

    edges_dict = {}
    for e in edges:
        edges_dict['%s_%s' % (e[0], e[1])] = {
            'a': e[0],
            'b': e[1],
            'initial_cost': None,
            'final_cost': None
        }
    del e

    placements = {}
    # initialize the data dictionary
    for i in range(n_placements):
        placements[str(i)] = {'min_cost': n_edges,
                              'initial_cost': 0,
                              'total_cost': 0,
                              'total_tries': 0,
                              'total_swaps': 0,
                              'placement': [None for j in range(matrix_len)],
                              'initial_placement': None,
                              'edges': edges_dict.copy()
                              }
    del i, edges_dict

    # executing the YOLT algorithm in multithreads
    for i in range(n_placements):
        ret = yolt_placer(placements[str(i)],
                          matrix_len,
                          matrix_len_sqrt,
                          distance_matrix,
                          nodes_positions
                          )

    '''
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
    return placements'''


if __name__ == '__main__':
    try:
        input_path = './bench/test_bench/'
        output_path = './exp_results/placements/yolt/'
        n_exec = 1
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
