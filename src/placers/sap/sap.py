import os
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import src.util as _u
from math import ceil, sqrt
import random as _r


def sa_placer():
    pass


def create_placement_json(pr_graph: _u.PRGraph, times: int = 2, init_algorithm: _u.AlgTypeEnum = _u.AlgTypeEnum.ZIGZAG):
    # TODO
    """_summary_

    Args:
        prgraph (_u.PRGraph): _description_
        times (int, optional): _description_. Defaults to 1.
        init_algorithm (_u.AlgTypeEnum, optional): _description_. Defaults to _u.AlgTypeEnum.ZIGZAG.
    """

    # FIXME
    # for debug only
    _r.seed(0)

    matrix_len_sqrt = ceil(sqrt(pr_graph.n_nodes))
    matrix_len = matrix_len_sqrt*matrix_len_sqrt
    n_nodes = pr_graph.n_nodes
    nodes = pr_graph.nodes

    placements = [[None for i in range(matrix_len)] for j in range(times)]
    for i in range(times):
        n = nodes.copy()
        c = 0
        while n:
            r = _r.randint(0, len(n)-1)
            placements[i][c] = n[r]
            n.pop(r)
            c += 1
    

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
