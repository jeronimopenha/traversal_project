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


# colocar no zigzag: encontrar ciclo
# colocar no zigzag: liberdade
# placer:
# primeiro olhar ciclo:
# se tiver ciclo, tentar colocar nas posições corretas,
# caso contrário aumentar uma das anotações, outra, etc até achar uma casa
# segundo: olhar liberdade
# tentar colocar a célula em uma casa que tenha a liberdade marcada
# terceiro: yolt


def yott_placer(initial_placement: dict(),
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
        if nodes_positions[a] is None:
            while True:
                choice = _r.randint(0, matrix_len-1)
                if placement[choice] is None:
                    nodes_positions[a] = choice
                    placement[choice] = a
                    break
        pl = nodes_positions[a]//matrix_len_sqrt
        pc = nodes_positions[a] % matrix_len_sqrt
        d = 0
        if nodes_positions[b] is not None:
            nl = nodes_positions[b]//matrix_len_sqrt
            nc = nodes_positions[b] % matrix_len_sqrt
            d = abs(pl-nl)+abs(pc-nc)
            edges[e]['final_cost'] = d
            total_cost += d
            continue
        positioned = False
        for dm_line in distance_matrix:
            initial_placement['total_tries'] += 1
            d = d+1
            for dm_column in dm_line:
                nl = pl+dm_column[0]
                nc = pc+dm_column[1]
                if nl > matrix_len_sqrt-1 or \
                        nc > matrix_len_sqrt-1 or \
                        nl < 0 or nc < 0:
                    continue
                cell = nl*matrix_len_sqrt + nc
                if placement[cell] is None:
                    initial_placement['total_swaps'] += 1
                    nodes_positions[b] = cell
                    placement[cell] = b
                    edges[e]['final_cost'] = d
                    total_cost += d
                    positioned = True
                    break
            if positioned:
                break
    initial_placement['total_cost'] = total_cost


def get_edges_yott(g: nx.DiGraph()) -> list(list()):
    # FIXME docstring
    """_summary_
        Returns a list of edges according
        with the zig zag algorithm
    Returns:
        _type_: _description_
    """

    first = True
    visited = []
    nodes_pairs = {}
    OutputList = []
    # get the node inputs
    for n in g.nodes():
        if g.out_degree(n) == 0:
            OutputList.append([n, 'IN'])
        nodes_pairs[n] = {
            'liberty_degree': 
        }

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
                EDGES.append([a, b, 0])

            elif fanin >= 1:  # Case 2

                b = L_fanin[a][-1]      # get the elem more in the right

                Stack.insert(0, [a, 'IN'])
                for i in range(fanin):
                    Stack.insert(0, [b, 'IN'])

                L_fanin[a].remove(b)
                L_fanout[b].remove(a)

                # EDGES.append([a, b, 1])
                # EDGES.append([a, b, 'IN'])
                EDGES.append([a, b, 1])

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
                EDGES.append([a, b, 1])

            elif fanout >= 1:  # Case 2

                b = L_fanout[a][0]  # get the element more left side

                Stack.insert(0, [a, 'OUT'])
                for i in range(fanout):
                    Stack.insert(0, [b, 'OUT'])

                L_fanout[a].remove(b)
                L_fanin[b].remove(a)

                # EDGES.append([a, b, 0])
                # EDGES.append([a, b, 'OUT'])
                EDGES.append([a, b, 0])

    return EDGES


def create_placement(g: nx.DiGraph(),
                     n_placements: int = 1
                     ):
    # TODO
    # docstring

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

    edges_dict_vec = []
    for i in range(n_placements):
        edges_dict = {}
        for e in edges:
            edges_dict['%s_%s' % (e[0], e[1])] = {
                'a': e[0],
                'b': e[1],
                'initial_cost': None,
                'final_cost': None
            }
        edges_dict_vec.append(edges_dict)
    del e, i

    placements = {}
    # initialize the data dictionary
    for i in range(n_placements):
        placements[str(i)] = {'min_cost': n_edges,
                              'initial_cost': None,
                              'total_cost': 0,
                              'total_tries': 0,
                              'total_swaps': 0,
                              'placement': [None for j in range(matrix_len)],
                              'initial_placement': None,
                              'edges': edges_dict_vec[i]
                              }
    del i

    # executing the YOLT algorithm in multithreads
    print("SA Main    : creating and starting")
    for i in range(n_placements):
        yott_placer(placements[str(i)],
                    matrix_len,
                    matrix_len_sqrt,
                    distance_matrix,
                    nodes_positions
                    )
        # correcting the edges
        for e in edges:
            if e[2] == 1:
                a = placements[str(i)]['edges']['%s_%s' % (e[0], e[1])]['a']
                b = placements[str(i)]['edges']['%s_%s' % (e[0], e[1])]['b']
                placements[str(i)]['edges']['%s_%s' % (e[0], e[1])]['a'] = b
                placements[str(i)]['edges']['%s_%s' % (e[0], e[1])]['b'] = a
        for n in nodes:
            nodes_positions[n] = None
    print("SA Main    : Done process")
    del i, e
    return placements


if __name__ == '__main__':
    try:
        # FIXME
        # for debug only
        _r.seed(0)

        input_path = './bench/test_bench/'
        output_path = './exp_results/placements/yolt/'
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
            while '\\n' in list(g.nodes):
                g.remove_node('\\n')
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

    except Exception as e:
        print(e)
        traceback.print_exc()
