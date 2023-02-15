import os
import sys

#if os.getcwd() not in sys.path:
#    sys.path.append(os.getcwd())

import json
import numpy as np


def routing_mesh(list_edge, GRID_SIZE, positions):
    '''
    Input:
        list_edge: lista de arestas [[0,1],[1,2],...] 0 -> 1 e 1->2, ...
        GRID_SIZE: tamanho do grid (considerei tamanho quadratico)
        positions: dicionario da posicao do nodo que retorna uma tupla de valores x e y do PE.
            Exemplo, se é o PE 0 então os valores de linha (i) e coluna (j) seriam 0 e 0, respectivamente
    Output:
        True: roteamento deu certo
        False: roteamento deu ruim

'''

    TOTAL_GRID_SIZE = GRID_SIZE * GRID_SIZE
    # uma matriz que sera preenchida com os nodos
    grid = np.full((TOTAL_GRID_SIZE, 4, 1), -1, dtype=int)
    dic_path = {}

    # verify if is routing
    for j in range(0, len(list_edge)):
        a = int(list_edge[j][0])
        b = int(list_edge[j][1])
        key = list_edge[j][0] + "_" + list_edge[j][1]
        pos_a_i = positions[str(a)][0]
        pos_a_j = positions[str(a)][1]
        pos_b_i = positions[str(b)][0]
        pos_b_j = positions[str(b)][1]

        dic_path[key] = []
        dist_walk = -1

        diff_i, diff_j = pos_b_i - pos_a_i, pos_b_j - pos_a_j
        dist_i, dist_j = abs(pos_b_i - pos_a_i), abs(pos_b_j - pos_a_j)

        pos_node_i, pos_node_j = pos_a_i, pos_a_j
        change = False

        count_per_curr = []
        while dist_i != 0 or dist_j != 0:
            diff_i = pos_b_i - pos_node_i
            diff_j = pos_b_j - pos_node_j

            # get the current position node
            pe_curr = pos_node_i * GRID_SIZE + pos_node_j
            dic_path[key].append(pe_curr)
            count_per_curr.append(pe_curr)

            # go to right neighbor
            # [pe], [0 = top, 1 = right, 2 = down, 3 = left], [0 = IN, OUT = 1]
            # go right
            if diff_j > 0 and pe_curr+1 < (pos_node_i+1)*GRID_SIZE and (grid[pe_curr][1][0] == -1 or grid[pe_curr][1][0] == a) and grid[pe_curr+1][3][0] != a and (pe_curr+1) not in count_per_curr:
                grid[pe_curr][1][0] = a
                pos_node_j += 1
                change = True
                # print("VIZ right 1")
            # go left
            elif diff_j < 0 and pe_curr-1 >= (pos_node_i)*GRID_SIZE and (grid[pe_curr][3][0] == -1 or grid[pe_curr][3][0] == a) and grid[pe_curr-1][1][0] != a and (pe_curr-1) not in count_per_curr:
                grid[pe_curr][3][0] = a
                pos_node_j -= 1
                change = True
                # print("VIZ left 1")
            # go down
            elif diff_i > 0 and pe_curr+GRID_SIZE < TOTAL_GRID_SIZE and (grid[pe_curr][2][0] == -1 or grid[pe_curr][2][0] == a) and grid[pe_curr+GRID_SIZE][0][0] != a and (pe_curr+GRID_SIZE) not in count_per_curr:
                grid[pe_curr][2][0] = a
                pos_node_i += 1
                change = True
                # print("VIZ down 1")
            # go up
            elif diff_i < 0 and pe_curr-GRID_SIZE >= 0 and (grid[pe_curr][0][0] == -1 or grid[pe_curr][0][0] == a) and grid[pe_curr-GRID_SIZE][2][0] != a and (pe_curr-GRID_SIZE) not in count_per_curr:
                grid[pe_curr][0][0] = a
                pos_node_i -= 1
                change = True
                # print("VIZ top 1")

            if not change:  # change, try a long path

                # go right
                if pe_curr+1 < (pos_node_i+1)*GRID_SIZE and (grid[pe_curr][1][0] == -1 or grid[pe_curr][1][0] == a) and grid[pe_curr+1][3][0] != a and (pe_curr+1) not in count_per_curr:
                    grid[pe_curr][1][0] = a
                    pos_node_j += 1
                    change = True
                    # print("right 1")
                # go left
                elif pe_curr-1 >= (pos_node_i)*GRID_SIZE and (grid[pe_curr][3][0] == -1 or grid[pe_curr][3][0] == a) and grid[pe_curr-1][1][0] != a and (pe_curr-1) not in count_per_curr:
                    grid[pe_curr][3][0] = a
                    pos_node_j -= 1
                    change = True
                    # print("left 1")
                # go down
                elif pe_curr+GRID_SIZE < TOTAL_GRID_SIZE and (grid[pe_curr][2][0] == -1 or grid[pe_curr][2][0] == a) and grid[pe_curr+GRID_SIZE][0][0] != a and (pe_curr+GRID_SIZE) not in count_per_curr:
                    grid[pe_curr][2][0] = a
                    pos_node_i += 1
                    change = True
                    # print("down 1")
                elif pe_curr-GRID_SIZE >= 0 and (grid[pe_curr][0][0] == -1 or grid[pe_curr][0][0] == a) and grid[pe_curr-GRID_SIZE][2][0] != a and (pe_curr-GRID_SIZE) not in count_per_curr:  # go up
                    grid[pe_curr][0][0] = a
                    pos_node_i -= 1
                    change = True
                    # print("top 1")

                if not change:  # not routing
                    return False, grid, dic_path

            if not change:  # not routing
                return False, grid, dic_path

            dist_i, dist_j = abs(
                pos_b_i - pos_node_i), abs(pos_b_j - pos_node_j)
            dist_walk += 1
            change = False

        if change:  # stop, give errors
            return False, grid, dic_path

        pe_final = pos_node_i * GRID_SIZE + pos_node_j
    return True, grid, dic_path


def routing_1hop(list_edge, GRID_SIZE, positions):

    TOTAL_GRID_SIZE = GRID_SIZE * GRID_SIZE
    grid = np.full((GRID_SIZE*GRID_SIZE, 4, 2), -1, dtype=int)

    # verify if is routing
    for j in range(0, len(list_edge)):
        a = int(list_edge[j][0])
        b = int(list_edge[j][1])
        key = list_edge[j][0] + "_" + list_edge[j][1]
        pos_a_i = positions[str(a)][0]
        pos_a_j = positions[str(a)][1]
        pos_b_i = positions[str(b)][0]
        pos_b_j = positions[str(b)][1]

        dic_path[key] = []
        dist_walk = -1

        diff_i, diff_j = pos_b_i - pos_a_i, pos_b_j - pos_a_j
        dist_i, dist_j = abs(pos_b_i - pos_a_i), abs(pos_b_j - pos_a_j)

        pos_node_i, pos_node_j = pos_a_i, pos_a_j
        change = False

        count_per_curr = []

        while dist_i != 0 or dist_j != 0:
            diff_i = pos_b_i - pos_node_i
            diff_j = pos_b_j - pos_node_j

            # get the current position node
            pe_curr = pos_node_i * GRID_SIZE + pos_node_j
            dic_path[key].append(pe_curr)
            count_per_curr.append(pe_curr)

            # go to right neighbor
            # [pe], [0 = top, 1 = right, 2 = down, 3 = left], [0 = IN, OUT = 1]
            # go right
            if diff_j > 0 and dist_j >= 2 and pe_curr+2 < (pos_node_i+1)*GRID_SIZE and (grid[pe_curr][1][1] == -1 or grid[pe_curr][1][1] == a) and grid[pe_curr+2][3][1] != a and (pe_curr+2) not in count_per_curr:
                grid[pe_curr][1][1] = a
                pos_node_j += 2
                change = True
                # print("VIZ right 2")
            # go right
            elif diff_j > 0 and pe_curr+1 < (pos_node_i+1)*GRID_SIZE and (grid[pe_curr][1][0] == -1 or grid[pe_curr][1][0] == a) and grid[pe_curr+1][3][0] != a and (pe_curr+1) not in count_per_curr:
                grid[pe_curr][1][0] = a
                pos_node_j += 1
                change = True
                # print("VIZ right 1")
            # go left
            elif diff_j < 0 and dist_j >= 2 and pe_curr-2 >= (pos_node_i)*GRID_SIZE and (grid[pe_curr][3][1] == -1 or grid[pe_curr][3][1] == a) and grid[pe_curr-2][1][1] != a and (pe_curr-2) not in count_per_curr:
                grid[pe_curr][3][1] = a
                pos_node_j -= 2
                change = True
                # print("VIZ left 2")
            # go left
            elif diff_j < 0 and pe_curr-1 >= (pos_node_i)*GRID_SIZE and (grid[pe_curr][3][0] == -1 or grid[pe_curr][3][0] == a) and grid[pe_curr-1][1][0] != a and (pe_curr-1) not in count_per_curr:
                grid[pe_curr][3][0] = a
                pos_node_j -= 1
                change = True
                # print("VIZ left 1")
            # go down
            elif diff_i > 0 and dist_i >= 2 and pe_curr+2*GRID_SIZE < TOTAL_GRID_SIZE and (grid[pe_curr][2][1] == -1 or grid[pe_curr][2][1] == a) and grid[pe_curr+2*GRID_SIZE][0][1] != a and (pe_curr+2*GRID_SIZE) not in count_per_curr:
                grid[pe_curr][2][1] = a
                pos_node_i += 2
                change = True
                # print("VIZ down 2")
            # go down
            elif diff_i > 0 and pe_curr+GRID_SIZE < TOTAL_GRID_SIZE and (grid[pe_curr][2][0] == -1 or grid[pe_curr][2][0] == a) and grid[pe_curr+GRID_SIZE][0][0] != a and (pe_curr+GRID_SIZE) not in count_per_curr:
                grid[pe_curr][2][0] = a
                pos_node_i += 1
                change = True
                # print("VIZ down 1")
            # go up
            elif diff_i < 0 and dist_i >= 2 and pe_curr-2*GRID_SIZE >= 0 and (grid[pe_curr][0][1] == -1 or grid[pe_curr][0][1] == a) and grid[pe_curr-2*GRID_SIZE][2][1] != a and (pe_curr-2*GRID_SIZE) not in count_per_curr:
                grid[pe_curr][0][1] = a
                pos_node_i -= 2
                change = True
                # print("VIZ top 2")
            # go up
            elif diff_i < 0 and pe_curr-GRID_SIZE >= 0 and (grid[pe_curr][0][0] == -1 or grid[pe_curr][0][0] == a) and grid[pe_curr-GRID_SIZE][2][0] != a and (pe_curr-GRID_SIZE) not in count_per_curr:
                grid[pe_curr][0][0] = a
                pos_node_i -= 1
                change = True
                # print("VIZ top 1")

            if not change:  # change, try a long path

                # go right
                if pe_curr+1 < (pos_node_i+1)*GRID_SIZE and (grid[pe_curr][1][0] == -1 or grid[pe_curr][1][0] == a) and grid[pe_curr+1][3][0] != a and (pe_curr+1) not in count_per_curr:
                    grid[pe_curr][1][0] = a
                    pos_node_j += 1
                    change = True
                    # print("right 1")
                # go left
                elif pe_curr-1 >= (pos_node_i)*GRID_SIZE and (grid[pe_curr][3][0] == -1 or grid[pe_curr][3][0] == a) and grid[pe_curr-1][1][0] != a and (pe_curr-1) not in count_per_curr:
                    grid[pe_curr][3][0] = a
                    pos_node_j -= 1
                    change = True
                    # print("left 1")
                # go down
                elif pe_curr+GRID_SIZE < TOTAL_GRID_SIZE and (grid[pe_curr][2][0] == -1 or grid[pe_curr][2][0] == a) and grid[pe_curr+GRID_SIZE][0][0] != a and (pe_curr+GRID_SIZE) not in count_per_curr:
                    grid[pe_curr][2][0] = a
                    pos_node_i += 1
                    change = True
                    # print("down 1")
                elif pe_curr-GRID_SIZE >= 0 and (grid[pe_curr][0][0] == -1 or grid[pe_curr][0][0] == a) and grid[pe_curr-GRID_SIZE][2][0] != a and (pe_curr-GRID_SIZE) not in count_per_curr:  # go up
                    grid[pe_curr][0][0] = a
                    pos_node_i -= 1
                    change = True
                    # print("top 1")

                if not change:  # not routing
                    return False

            if not change:  # not routing
                return False

            dist_i, dist_j = abs(
                pos_b_i - pos_node_i), abs(pos_b_j - pos_node_j)
            dist_walk += 1
            change = False

        if change:  # stop, give errors
            return False

        pe_final = pos_node_i * GRID_SIZE + pos_node_j

    return True


def find_files_conditional(path: str, condition: str) -> list():
    files_return = []
    for dir, folder, files in os.walk(path):
        for f in files:
            if condition in f:
                files_return.append(
                    [os.path.join(dir, f), f, '%s' % f.split('.')[0]])
    return files_return


def read_json(files: list()):
    placements = {}
    for file in files:
        with open(file[0]) as p_file:
            contents = p_file.read()
            placements[file[2]] = json.loads(contents)
        p_file.close()
    return placements


def read_maze_edges(edges: dict()) -> list():
    edges_vec = []
    for e in edges.keys():
        a = edges[e]['a']
        b = edges[e]['b']
        edges_vec.append([a, b])
    return edges_vec


def edges_sorted_third(val):
    return val[2]


def read_edges_sorted(edges: dict(), reverse: bool = False) -> list():
    edges_vec = []
    for e in edges.keys():
        a = edges[e]['a']
        b = edges[e]['b']
        cost = edges[e]['cost']
        edges_vec.append([a, b, cost])
    edges_vec.sort(key=edges_sorted_third, reverse=reverse)

    return edges_vec


def read_maze_edges_multicast(edges: dict()) -> list():
    nodes_data = {}
    for e in edges.keys():
        if edges[e]['a'] not in nodes_data.keys():
            # 0 = n_edges
            # 1 = sum of the edges cost
            # 3 = list of the edges
            nodes_data[edges[e]['a']] = [1, edges[e]
                                         ['cost'], [[edges[e]['a'], edges[e]['b']]]]
        else:
            nodes_data[edges[e]['a']][0] += 1
            nodes_data[edges[e]['a']][1] += edges[e]['cost']
            nodes_data[edges[e]['a']][2].append([edges[e]['a'], edges[e]['b']])

    edges_vec = []
    for e in edges.keys():
        a = edges[e]['a']
        b = edges[e]['b']
        cost = edges[e]['cost']
        edges_vec.append([a, b, cost])
    edges_vec.sort(key=edges_sorted_third)

    return edges_vec


def get_nodes_positions(placement: list(), matrix_sqrt: int) -> list(tuple()):
    positions = {}
    for i in range(len(placement)):
        n = placement[i]
        if n is not None:
            l = i//matrix_sqrt
            c = i % matrix_sqrt
            positions[n] = (l, c)
    return positions
