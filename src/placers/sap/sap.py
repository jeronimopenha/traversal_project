import os
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import src.util as _u
from math import ceil, sqrt
import random as _r


def sa_placer(initial_placement: dict(),
              matrix_len: int,
              matrix_len_sqrt: int,
              exec_times: int
              ):
    placement = initial_placement['initial_placement'].copy()
    edges = initial_placement['edges']
    total_cost = initial_placement['initial_cost']
    r_total_swaps = 0

    # SA implementation
    t = 100
    while t >= 0.00001:
        for i in range(matrix_len_sqrt):
            for j in range(matrix_len_sqrt):
                if i == j:
                    continue
                if placement[i] is None and placement[j] is None:
                    continue
                # Current costs for a and b
                a = placement[i]
                b = placement[j]
                curr_cost_a = 0
                curr_cost_b = 0
                edges_a_keys = []
                edges_b_keys = []
                for e in edges.keys():
                    if a is not None:
                        if edges[e]['n1'] == a:
                            edges_a_keys.append(e)
                            curr_cost_a += edges[e]['final_cost']
                    if b is not None:
                        if edges[e]['n1'] == b:
                            edges_b_keys.append(e)
                            curr_cost_b += edges[e]['final_cost']
                current_cost = curr_cost_a + curr_cost_b

                # New costs for a and b
                # for new 'a' position
                new_cost_a = 0
                if a is not None:
                    n1 = j
                    for e in edges_a_keys:
                        n2 = placement.index(edges[e]['n2'], 0, matrix_len)
                        l1 = n1//matrix_len_sqrt
                        c1 = n1 % matrix_len_sqrt
                        l2 = n2//matrix_len_sqrt
                        c2 = n2 % matrix_len_sqrt
                        edge_cost = abs(l1-l2) + abs(c1-c2)
                # for new 'b' position
                new_cost_b = 0
                if b is not None:
                    n1 = i
                    for e in edges_b_keys:
                        n2 = placement.index(edges[e]['n2'], 0, matrix_len)
                        l1 = n1//matrix_len_sqrt
                        c1 = n1 % matrix_len_sqrt
                        l2 = n2//matrix_len_sqrt
                        c2 = n2 % matrix_len_sqrt
                        edge_cost = abs(l1-l2) + abs(c1-c2)

                nai = j
                nbj = i
                new_cost_b = 0

                n1 = placements[str(i)]['initial_placement'].index(
                    e[0], 0, matrix_len)
                n2 = placements[str(i)]['initial_placement'].index(
                    e[1], 0, matrix_len)


def create_placement_json(pr_graph: _u.PRGraph,
                          n_placements: int = 2,
                          exec_times: int = 2
                          ):
    # TODO
    # docstring

    # FIXME
    # for debug only
    _r.seed(0)

    matrix_len_sqrt = ceil(sqrt(pr_graph.n_nodes))
    matrix_len = matrix_len_sqrt*matrix_len_sqrt
    n_nodes = pr_graph.n_nodes
    nodes = pr_graph.nodes
    edges = pr_graph.get_edges()
    n_edges = len(edges)
    min_cost = n_edges

    placements = {}
    # initialize the placements randomly
    for i in range(n_placements):
        n = nodes.copy()
        c = 0
        placements[str(i)] = {'placement': [],
                              'initial_placement': [None for j in range(matrix_len)],
                              'edges': {},
                              'max_cost': n_edges,
                              'initial_cost': 0,
                              'total_cost': 0,
                              'total_swaps': 0
                              }
        while n:
            r = _r.randint(0, len(n)-1)
            placements[str(i)]['initial_placement'][c] = n[r]
            n.pop(r)
            c += 1
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
            placements[str(i)]['edges']['%s_%s' % (e[0], e[1])]['n1'] = e[0]
            placements[str(i)]['edges']['%s_%s' % (e[0], e[1])]['n2'] = e[1]
            placements[str(i)]['edges']['%s_%s' %
                                        (e[0], e[1])]['initial_cost'] = edge_cost
            placements[str(i)]['edges']['%s_%s' %
                                        (e[0], e[1])]['final_cost'] = edge_cost
        placements[str(i)]['total_cost'] = placements[str(i)]['initial_cost']
    del i, e, n1, n2, l1, l2, c1, c2, edge_cost
    # executing the SA algorithm
    for i in range(n_placements):
        r_placement, r_total_cost, r_total_swaps = sa_placer(
            placements[str(i)], matrix_len, matrix_len_sqrt, exec_times)

        placements[str(i)]['placement'] = r_placement
        placements[str(i)]['total_cost'] = r_total_cost
        placements[str(i)]['total_swaps'] = r_total_swaps
    del r_placement, r_total_cost, r_total_swaps

    '''first_node = int(edges[0][0])
    res = traversal(tr_graph=tr_graph,
                        edges=edges,
                        first_node=first_node,
                        n_threads=n_threads,
                        matrix_len=matrix_len,
                        matrix_len_sqrt=matrix_len_sqrt,
                        times=times
                        )
        # edges costs
        for r_c in range(len(res)):
            r_id = res[r_c][0]
            r_dict = res[r_c][1]
            total_cost = 0
            edges_costs = []
            for edge in edges:
                ca = r_dict[edge[0]]
                cb = r_dict[edge[1]]
                cost = abs(ca[0]-cb[0]) + abs(ca[1]-cb[1])
                total_cost += cost
                edges_costs.append([edge, cost])
            res[r_c].append({'edges_costs': edges_costs, 'ideal_cost': len(
                edges), 'total_cost': total_cost})

        results.append(
            {'name': dot[1], 'grid_size': matrix_len, 'placements': res})
    for r in results:
        r_name = r['name']
        r_placements = r['placements']
        r_grid_size = r['grid_size']
        for r_p in r_placements:
            data = {}
            data['name'] = r_name
            data['iteration_id'] = r_p[0]
            data['ideal_cost'] = r_p[2]['ideal_cost']
            data['total_cost'] = r_p[2]['total_cost']
            data['grid_size'] = r_grid_size
            data['edges_costs'] = r_p[2]['edges_costs']
            data['placement'] = r_p[1]
            json_d = json.dumps(data)
            arq = open('%s%s/%s_it_%d_placement.json' %
                       (output_path, r_name, r_name, r_p[0]), 'w')
            arq.write(json_d)
            arq.close()'''
