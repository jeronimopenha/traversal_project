import os
import sys


if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import json
from math import sqrt, ceil
import argparse
import traceback
import random
import time
import st1_th_controller as _st1
import st2_edges as _st2
import st3_n2c as _st3
import st4_choice as _st4
import st5_c2n as _st5
import util as _u


def traversal(tr_graph,
              edges: list(),
              first_node: int,
              n_threads: int = 5,
              matrix_len: int = 16,
              matrix_len_sqrt: int = 4,
              times: int = 1
              ) -> list():
    # 1ª LINE - DIST 1
    # 2º LINE - DIST 2
    # 3º LINE - DIST 3
    # depois trocar para espiral
    choices = [
        [[1, 0], [0, 1], [0, -1], [-1, 0],
         [-1, -1], [1, -1], [-1, 1], [1, 1], [-2, 0], [0, -2], [2, 0], [0, 2],
         [-3, 0], [0, 3], [3, 0], [0, -3]],
        [[0, 1], [0, -1], [1, 0], [-1, 0],
         [-2, 0], [0, -2], [2, 0], [0, 2], [-1, -1], [1, -1], [-1, 1], [1, 1],
         [-2, -1], [2, -1], [-2, 1], [2, 1]],
        [[0, 1], [1, 0], [-1, 0], [0, -1],
         [-1, 1], [1, 1], [-1, -1], [1, -1], [-2, 0], [0, -2], [2, 0], [0, 2],
         [-1, -2], [1, -2], [1, 2], [-1, 2]],
        [[1, 0], [0, -1], [0, 1], [-1, 0],
         [-1, -1], [1, -1], [-1, 1], [1, 1],  [2, 0], [0, 2], [-2, 0], [0, -2],
         [-2, 1], [2, 1], [-1, 2], [1, 2]],
        [[0, 1], [0, -1], [-1, 0], [1, 0],
         [-1, 1], [1, 1], [-2, 0], [0, -2], [-1, -1], [1, -1], [2, 0], [0, 2],
         [-2, 1], [-1, 2], [0, 3], [1, 2]],
        [[1, 0], [0, 1], [0, -1], [-1, 0],
         [-1, -1], [1, 1], [-2, 0], [0, -2], [2, 0], [0, 2], [1, -1], [-1, 1],
         [0, -3], [-1, 2], [0, 3], [1, 2]],
        [[0, 1], [1, 0], [0, -1], [-1, 0],
         [-1, 1], [-1, -1], [1, -1],  [1, 1], [0, -2], [-2, 0],  [2, 0], [0, 2],
         [0, -3], [-1, -2], [1, -2], [0, 3]],
        [[0, 1], [-1, 0], [1, 0], [0, -1],
         [-1, -1],  [-2, 0], [0, -2], [2, 0], [0, 2], [1, -1], [-1, 1], [1, 1],
         [-2, -1], [-1, -2], [1, -2], [2, -1]]
    ]

    # nº arestas 1 2 etc
    # histograma
    # pior aresta (mais longa)
    # número arestas maiores que 1
    # comprimento médio
    # número de passadas por nó em média para SA e YOTO

    results = []
    for i in range(times):
        random.seed(time.clock_gettime_ns(time.CLOCK_REALTIME))
        first_cell = [random.randint(0, matrix_len-1)
                      for r in range(n_threads)]
        # print(first_cell)
        st1 = _st1.St1ThController(n_threads)
        st2 = _st2.St2Edges(n_threads, matrix_len, edges)
        st3 = _st3.St3N2c(n_threads, matrix_len, first_node, first_cell)
        st4 = _st4.St4Choice(n_threads, matrix_len, choices)
        st5 = _st5.St5C2n(n_threads, matrix_len, first_node,
                          first_cell, len(choices))

        while not st1.done:
            st1.execute(st2.output)
            st2.execute(st1.output, st5.output)
            st3.execute(st2.output, st5.output)
            st4.execute(st3.output)
            st5.execute(st4.output, st5.output)

        for t in range(n_threads):
            if st1.threads_done[t] == 1:
                node_dict = {}
                for c in range(matrix_len):
                    if st5.c2n[t][c] is None:
                        continue
                    line = c//matrix_len_sqrt
                    col = c % matrix_len_sqrt
                    node_dict[str(st5.c2n[t][c])] = [line, col]
                results.append([i*5+t, node_dict])
        del st1, st2, st3, st4, st5, t
    return results


def create_placement_json():
    input_path = '/home/jeronimo/Documents/GIT/traversal_project/bench/m_bench/dac/'
    output_path = '/home/jeronimo/Documents/GIT/traversal_project/bench/results/m_bench/simple_traverse/place_1000_tries/'
    files_l = []
    for dir, folder, files in os.walk(input_path):
        for f in files:
            files_l.append(
                [os.path.join(dir, f), f, dir.replace('.', '').replace('/', '_')])

    times = 400  # 100x/5th
    init_algorithm = _u.AlgTypeEnum.ZIGZAG
    #
    results = []
    for dot in files_l:
        tr_graph = _u.PRGraph(dot[0])
        n_threads = 5
        matrix_len_sqrt = ceil(sqrt(tr_graph.n_nodes))
        matrix_len = matrix_len_sqrt*matrix_len_sqrt
        edges = []
        if init_algorithm == _u.AlgTypeEnum.DEPTH:
            edges = tr_graph.get_edges_dfa()
        elif init_algorithm == _u.AlgTypeEnum.ZIGZAG:
            edges = tr_graph.get_edges_zza()
        first_node = int(edges[0][0])

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
            arq.close()

# TODO Future improvement


def create_args():
    parser = argparse.ArgumentParser('create_project -h')
    parser.add_argument('-d', '--dot', help='Dot file', type=str)
    parser.add_argument('-a', '--init_algorithm',
                        help='Algorithm por placer initialization: 0 - depth, 1 - zigzag', type=int, default=1)
    parser.add_argument(
        '-o', '--output', help='Output folder', type=str, default='.')
    return parser.parse_args()


if __name__ == '__main__':
    try:
        create_placement_json()
    except Exception as e:
        print(e)
        traceback.print_exc()
