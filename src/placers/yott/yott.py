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
                nodes_positions: list(),
                liberty_matrix: list(list()),
                annotations: dict(),
                liberty_degree: dict()
                ):
    # FIXME Corrigir zigzag
    edges = initial_placement['edges']
    placement = initial_placement['placement']
    total_cost = 0
    for e in edges.keys():
        a = edges[e]['a']
        b = edges[e]['b']
        b_degree = liberty_degree[b][0]
        positioned = False

        if nodes_positions[b] is not None:
            continue

        # If the left note is not positioned yet, I will put it in a random free place
        if nodes_positions[a] is None:
            while True:
                cell = _r.randint(0, matrix_len-1)
                if placement[cell] is None:
                    nodes_positions[a] = cell
                    placement[cell] = a
                    liberty_matrix[cell] = 0
                    update_liberty_matrix(
                        cell, matrix_len_sqrt, distance_matrix[0], liberty_matrix)
                    break
            del cell

        # solve the cycles annotations
        if b in annotations.keys():
            condition_try = 0
            conditions_removed = 0
            # using only the useful conditions
            conditions = []
            temp = []
            for t_1 in annotations[b]:
                temp.append(t_1.copy())
            del t_1

            for c in temp:
                t = nodes_positions[c[0]]
                if t is not None:
                    conditions.append(c)

                del t

            del temp, c

            conditions.append([a, 1])
            n_conditions = len(conditions)

            intersection_cells = []
            intersection = False
            while not intersection:
                cells = []
                # finding the possible cells to place b
                i = 0
                while i < len(conditions):
                    c = conditions[i]

                    cnp = nodes_positions[c[0]]

                    cells_temp = None
                    a_l = cnp//matrix_len_sqrt
                    a_c = cnp % matrix_len_sqrt

                    for d in distance_matrix[c[1]-1]:
                        cell_l = a_l + d[0]
                        cell_c = a_c + d[1]
                        if cell_l < 0 or cell_l > matrix_len_sqrt-1 or\
                                cell_c < 0 or cell_c > matrix_len_sqrt-1:
                            continue
                        cell = cell_l * matrix_len_sqrt + cell_c
                        if placement[cell] is None:
                            if cells_temp is None:
                                cells_temp = []
                            cells_temp.append(cell)
                        del cell_l, cell_c, cell
                    del cnp, a_l, a_c, d

                    if cells_temp is not None:
                        cells.append(cells_temp)
                        i += 1
                    else:
                        conditions[i][1] += 1
                del cells_temp, i, c,

                # looking for an intersection between the conditions possible cells
                cells_temp = {}
                for cell_v in cells:
                    for c in cell_v:
                        if c in cells_temp.keys():
                            cells_temp[c] += 1
                        else:
                            cells_temp[c] = 1
                    del c
                del cell_v
                for k in cells_temp.keys():
                    if cells_temp[k] == n_conditions:
                        intersection_cells.append(k)
                        intersection = True
                del k, cells_temp

                if not intersection:
                    conditions[condition_try][1] += 1
                    condition_try += 1
                    if condition_try == n_conditions:
                        condition_try = 0
                    retry = False
                    for c in conditions:
                        if c[1] > (matrix_len_sqrt-1)*2:
                            retry = True
                            break
                    del c
                    if retry:
                        conditions_removed += 1
                        condition_try = 0
                        # using only the useful conditions
                        conditions = []
                        temp = []
                        for t_1 in annotations[b]:
                            temp.append(t_1.copy())
                        del t_1

                        for c in temp:
                            t = nodes_positions[c[0]]
                            if t is not None:
                                conditions.append(c)
                            del t
                        del temp, c

                        for i in range(conditions_removed):
                            conditions.pop(0)
                        del i

                        conditions.append([a, 1])
                        n_conditions = len(conditions)
                        del retry

            del cells, condition_try, conditions, n_conditions, intersection, conditions_removed
            # once we have some intersection cells,
            # lets find out the better one to place de b node

            better_cell = None
            better_degree = None
            for cell in intersection_cells:
                cell_degree = liberty_matrix[cell]
                if cell_degree == b_degree:
                    positioned = True
                else:
                    if better_cell == None:
                        better_cell = cell
                        better_degree = cell_degree
                    else:
                        if abs(cell_degree-b_degree) < abs(better_degree-b_degree):
                            better_cell = cell
                            better_degree = cell_degree
                del cell_degree
                if positioned:
                    break

            if not positioned:
                cell = better_cell
            initial_placement['total_swaps'] += 1
            nodes_positions[b] = cell
            placement[cell] = b
            liberty_matrix[cell] = 0
            update_liberty_matrix(cell, matrix_len_sqrt,
                                  distance_matrix[0], liberty_matrix)
            # edges[e]['final_cost'] = d
            # total_cost += d
            del better_cell, better_degree, intersection_cells, cell, positioned

        else:
            # if the node is nos annotated, we will try to put it in a cell that
            # has no more resources than it demands or in the better one possible

            # finding the possible cells to place b
            done = False
            a_d = 1
            cells = []
            while not done:
                cells_temp = None
                a_p = nodes_positions[a]
                a_l = a_p//matrix_len_sqrt
                a_c = a_p % matrix_len_sqrt

                for d in distance_matrix[a_d-1]:
                    cell_l = a_l + d[0]
                    cell_c = a_c + d[1]
                    if cell_l < 0 or cell_l > matrix_len_sqrt-1 or\
                            cell_c < 0 or cell_c > matrix_len_sqrt-1:
                        continue
                    cell = cell_l * matrix_len_sqrt + cell_c
                    if placement[cell] is None:
                        if cells_temp is None:
                            cells_temp = []
                        cells_temp.append(cell)
                    del cell_l, cell_c, cell
                del a_p, a_l, a_c, d

                if cells_temp is not None:
                    cells = cells_temp
                    done = True
                else:
                    a_d += 1
            del cells_temp

            # once we have some possible cells,
            # lets find out the better one to place de b node

            better_cell = None
            better_degree = None
            for cell in cells:
                cell_degree = liberty_matrix[cell]
                if cell_degree == b_degree:
                    positioned = True
                else:
                    if better_cell == None:
                        better_cell = cell
                        better_degree = cell_degree
                    else:
                        if abs(cell_degree-b_degree) < abs(better_degree-b_degree):
                            better_cell = cell
                            better_degree = cell_degree
                del cell_degree
                if positioned:
                    break

            if not positioned:
                cell = better_cell
            initial_placement['total_swaps'] += 1
            nodes_positions[b] = cell
            placement[cell] = b
            liberty_matrix[cell] = 0
            update_liberty_matrix(cell, matrix_len_sqrt,
                                  distance_matrix[0], liberty_matrix)
            # edges[e]['final_cost'] = d
            # total_cost += d
            del better_cell, better_degree, cells, cell, positioned
    #initial_placement['total_cost'] = total_cost


def update_liberty_matrix(position: int, matrix_len_sqrt: int, distance_matrix: list(), liberty_matrix: list(list())):
    p_l = position//matrix_len_sqrt
    p_c = position % matrix_len_sqrt
    for d in distance_matrix:
        n_l = p_l + d[0]
        n_c = p_c + d[1]
        if n_l < 0 or n_l > matrix_len_sqrt-1 or\
                n_c < 0 or n_c > matrix_len_sqrt-1:
            continue
        cell = n_l*matrix_len_sqrt + n_c
        if liberty_matrix[cell] > 0:
            liberty_matrix[cell] -= 1


def create_annotation(g: nx.DiGraph, counter: int, a: str, b: str, direction: str, annotations: dict()):

    if counter == 3:
        return

    if a == b:
        return

    if a not in annotations.keys():
        annotations[a] = []
    annotations[a].append([b, counter+1])

    q = []
    if direction == 'IN':
        for s in g._succ[a].keys():
            if len(g._succ[s]) > 0:
                q.append(s)
        for s in q:
            create_annotation(g, counter+1, s, b, direction, annotations)
    elif direction == 'OUT':
        for p in g._pred[a].keys():
            if len(g._pred[p]) > 0:
                q.append(p)
        for p in q:
            create_annotation(g, counter+1, p, b, direction, annotations)


def create_liberty_degree(a: str, visited: list(), liberty_degree: dict()):
    if liberty_degree[a][1]:
        return
    for s in g._succ[a].keys():
        if s in visited:
            liberty_degree[a][0] -= 1
    for p in g._pred[a].keys():
        if p in visited:
            liberty_degree[a][0] -= 1
    liberty_degree[a][1] = True


def get_edges_yott(g: nx.DiGraph) -> list(list()):
    # FIXME docstring
    """_summary_
        Returns a list of edges according
        with the zig zag algorithm
    Returns:
        _type_: _description_
    """
    visited = []
    annotations = {}
    liberty_degree = {}
    output_list = []
    # get the node inputs
    for n in g.nodes():
        if g.out_degree(n) == 0:
            output_list.append([n, 'IN'])
        liberty_degree[n] = [g.out_degree(n) + g.in_degree(n), False]

    stack = output_list.copy()

    edges = []

    l_fanin, l_fanout = {}, {}
    for no in g:
        l_fanin[no] = list(g.predecessors(no))
        l_fanout[no] = list(g.successors(no))

    while stack:
        a, direction = stack.pop(0)  # get the top1
        if a not in visited:
            visited.append(a)

        # liberty degree update
        create_liberty_degree(a, visited, liberty_degree)

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

                # cycle verification
                if b not in visited:
                    visited.append(b)
                else:
                    create_annotation(g, 0, a, b, 'OUT', annotations)

            elif fanin >= 1:  # Case 2

                b = l_fanin[a][-1]      # get the elem more in the right

                stack.insert(0, [a, 'IN'])
                for i in range(fanin):
                    stack.insert(0, [b, 'IN'])

                l_fanin[a].remove(b)
                l_fanout[b].remove(a)

                edges.append([a, b, 'IN'])

                # cycle verification
                if b not in visited:
                    visited.append(b)
                else:
                    create_annotation(g, 0, a, b, 'IN', annotations)

        else:  # direction == 'OUT'

            if fanin >= 1:  # Case 3

                b = l_fanin[a][0]  # get the element more left side

                for i in range(fanout):
                    stack.insert(0, [a, 'OUT'])
                stack.insert(0, [b, 'IN'])

                l_fanin[a].remove(b)
                l_fanout[b].remove(a)

                edges.append([a, b, 'IN'])

                # cycle verification
                if b not in visited:
                    visited.append(b)
                else:
                    create_annotation(g, 0, a, b, 'IN', annotations)

            elif fanout >= 1:  # Case 2

                b = l_fanout[a][0]  # get the element more left side

                stack.insert(0, [a, 'OUT'])
                for i in range(fanout):
                    stack.insert(0, [b, 'OUT'])

                l_fanout[a].remove(b)
                l_fanin[b].remove(a)

                edges.append([a, b, 'OUT'])

                # cycle verification
                if b not in visited:
                    visited.append(b)
                else:
                    create_annotation(g, 0, a, b, 'OUT', annotations)

    return edges, annotations, liberty_degree


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
    edges, annotations, liberty_degree = get_edges_yott(g)
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
    del d, j

    temp = []
    liberty_matrix = []
    # for mesh architecture
    for i in range(matrix_len):
        l = i//matrix_len_sqrt
        c = i % matrix_len_sqrt
        if (l == 0 and c == 0) or \
            (l == 0 and c == matrix_len_sqrt-1) or\
                (l == matrix_len_sqrt-1 and c == 0) or\
                (l == matrix_len_sqrt-1 and c == matrix_len_sqrt-1):
            temp.append(2)
        elif (l == 0) or (c == 0) or\
                (l == matrix_len_sqrt-1) or (c == matrix_len_sqrt-1):
            temp.append(3)
        else:
            temp.append(4)
    del l, c

    for i in range(n_placements):
        liberty_matrix.append(temp.copy())
    del i, temp

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
    del e, i, edges_dict

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
    print("YOTT Main    : creating and starting")
    for i in range(n_placements):
        print("YOTT Main    : placing %d" % (i+1))
        yott_placer(placements[str(i)],
                    matrix_len,
                    matrix_len_sqrt,
                    distance_matrix,
                    nodes_positions,
                    liberty_matrix[i],
                    annotations,
                    liberty_degree
                    )
        # correcting the edges
        for e in edges:
            if e[2] == 'IN':
                a = placements[str(i)]['edges']['%s_%s' % (e[0], e[1])]['a']
                b = placements[str(i)]['edges']['%s_%s' % (e[0], e[1])]['b']
                placements[str(i)]['edges']['%s_%s' % (e[0], e[1])]['a'] = b
                placements[str(i)]['edges']['%s_%s' % (e[0], e[1])]['b'] = a
                del a, b
        del e
        for n in nodes:
            nodes_positions[n] = None
        del n
    print("YOTT Main    : Done process")
    del i
    return placements


if __name__ == '__main__':
    try:
        # FIXME
        # for debug only
        _r.seed(0)

        input_path = './bench/test_bench/'
        output_path = './exp_results/placements/yott/'
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
