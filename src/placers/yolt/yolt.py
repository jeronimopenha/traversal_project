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


def yolt_placer(initial_placement: dict(),
                matrix_len: int,
                matrix_len_sqrt: int,
                distance_matrix: list(list()),
                nodes_positions: list()
                ):

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
        al = nodes_positions[a]//matrix_len_sqrt
        ac = nodes_positions[a] % matrix_len_sqrt
        d = 0
        if nodes_positions[b] is not None:
            bl = nodes_positions[b]//matrix_len_sqrt
            bc = nodes_positions[b] % matrix_len_sqrt
            d = abs(al-bl)+abs(ac-bc)
            edges[e]['final_cost'] = d
            total_cost += d
            continue
        positioned = False
        for dm_line in distance_matrix:
            initial_placement['total_tries'] += 1
            d = d+1
            for dm_column in dm_line:
                bl = al+dm_column[0]
                bc = ac+dm_column[1]
                if bl > matrix_len_sqrt-1 or \
                        bc > matrix_len_sqrt-1 or \
                        bl < 0 or bc < 0:
                    continue
                cell = bl*matrix_len_sqrt + bc
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


def get_edges_depth_first(g: nx.DiGraph) -> list(list()):
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


def get_edges_zigzag(g: nx.DiGraph) -> list(list()):
    # FIXME docstring
    """_summary_
        Returns a list of edges according
        with the zig zag algorithm
    Returns:
        _type_: _description_
    """

    output_list = []
    # get the node inputs
    for n in g.nodes():
        if g.out_degree(n) == 0:
            output_list.append([n, 'IN'])

    stack = output_list.copy()

    edges = []

    l_fanin, l_fanout = {}, {}
    for no in g:
        l_fanin[no] = list(g.predecessors(no))
        l_fanout[no] = list(g.successors(no))

    while stack:
        a, direction = stack.pop(0)  # get the top1

        fanin = len(l_fanin[a])     # get size fanin
        fanout = len(l_fanout[a])   # get size fanout

        if direction == 'IN':  # direction == 'IN'

            if fanout >= 1:  # Case 3

                b = l_fanout[a][-1]  # get the element more the right side

                for i in range(fanin):
                    stack.insert(0, [a, 'IN'])
                stack.insert(0, [b, 'OUT'])  # insert into stack

                l_fanout[a].remove(b)
                l_fanin[b].remove(a)

                edges.append([a, b, 'OUT'])

            elif fanin >= 1:  # Case 2

                b = l_fanin[a][-1]      # get the elem more in the right

                stack.insert(0, [a, 'IN'])
                for i in range(fanin):
                    stack.insert(0, [b, 'IN'])

                l_fanin[a].remove(b)
                l_fanout[b].remove(a)

                edges.append([a, b, 'IN'])

        else:  # direction == 'OUT'

            if fanin >= 1:  # Case 3

                b = l_fanin[a][0]  # get the element more left side

                for i in range(fanout):
                    stack.insert(0, [a, 'OUT'])
                stack.insert(0, [b, 'IN'])

                l_fanin[a].remove(b)
                l_fanout[b].remove(a)

                edges.append([a, b, 'IN'])

            elif fanout >= 1:  # Case 2

                b = l_fanout[a][0]  # get the element more left side

                stack.insert(0, [a, 'OUT'])
                for i in range(fanout):
                    stack.insert(0, [b, 'OUT'])

                l_fanout[a].remove(b)
                l_fanin[b].remove(a)

                edges.append([a, b, 'OUT'])

    return edges


def create_placement(g: nx.DiGraph,
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
        yolt_placer(placements[str(i)],
                    matrix_len,
                    matrix_len_sqrt,
                    distance_matrix,
                    nodes_positions
                    )
        # correcting the edges
        for e in edges:
            if e[2] == 'IN':
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
