import os
import sys

# if os.getcwd() not in sys.path:
#    sys.path.append(os.getcwd())

import json
import numpy as np


def find_route(grid_size: int,
               grid: list(list()),
               path: list(),
               origin: int,
               a_l: int,
               a_c: int,
               b_l: int,
               b_c: int
               ) -> bool:
    # if the current cell is the destiny cell the routine is over
    if a_l == b_l and a_c == b_c:
        return True
    # d_l + = b is in top side
    # d_l - = b is in botom side
    d_l = b_l-a_l
    # d_j + = b is right side
    # d_j - = b is left side
    d_c = b_c-a_c
    # d = abs(d_l) + abs(d_c)
    # identify the 2 possible routes to destiny and go
    UP = 0
    RIGHT = 1
    DOWN = 2
    LEFT = 3
    if d_l > 0:
        n_l = a_l+1
        n_c = a_c
        # [up, right, down, left]
        if n_l < grid_size and (grid[a_l][a_c][DOWN] is None or grid[a_l][a_c][DOWN] == origin):
            path.append([a_l, a_c])
            grid[a_l][a_c][DOWN] = origin
            ret = find_route(grid_size, grid, path, origin, n_l, n_c, b_l, b_c)
            if not ret:
                path.pop(-1)
                grid[a_l][a_c][DOWN] = None
            else:
                return True
    elif d_l < 0:
        n_l = a_l-1
        n_c = a_c
        if n_l >= 0 and (grid[a_l][a_c][UP] is None or grid[a_l][a_c][UP] == origin):
            path.append([a_l, a_c])
            grid[a_l][a_c][UP] = origin
            ret = find_route(grid_size, grid, path, origin, n_l, n_c, b_l, b_c)
            if not ret:
                path.pop(-1)
                grid[a_l][a_c][UP] = None
            else:
                return True
    if d_c > 0:
        n_l = a_l
        n_c = a_c+1
        if n_l < grid_size and (grid[a_l][a_c][RIGHT] is None or grid[a_l][a_c][RIGHT] == origin):
            path.append([a_l, a_c])
            grid[a_l][a_c][RIGHT] = origin
            ret = find_route(grid_size, grid, path, origin, n_l, n_c, b_l, b_c)
            if not ret:
                path.pop(-1)
                grid[a_l][a_c][RIGHT] = None
            else:
                return True
    elif d_c < 0:
        n_l = a_l
        n_c = a_c-1
        if n_l >= 0 and (grid[a_l][a_c][LEFT] is None or grid[a_l][a_c][LEFT] == origin):
            path.append([a_l, a_c])
            grid[a_l][a_c][LEFT] = origin
            ret = find_route(grid_size, grid, path, origin, n_l, n_c, b_l, b_c)
            if not ret:
                path.pop(-1)
                grid[a_l][a_c][LEFT] = None
            else:
                return True
    # if nothing wortks, the route try is aborted
    return False


def routing(list_edge: list(list()), grid_size: int, positions: dict()):
    '''
    Input:
        list_edge: lista de arestas[[0, 1], [1, 2], ...] 0 -> 1 e 1 -> 2, ...
        GRID_SIZE: tamanho do grid(considerei tamanho quadratico)
        positions: dicionario da posicao do nodo que retorna uma tupla de valores x e y do PE.
            Exemplo, se é o PE 0 então os valores de linha(i) e coluna(j) seriam 0 e 0, respectivamente
    Output:
        True: roteamento deu certo
        False: roteamento deu ruim

    '''

    total_grid_size = grid_size * grid_size
    # uma matriz que sera preenchida com os nodos
    # np.full((TOTAL_GRID_SIZE, 4, 1), -1, dtype=int)
    grid = []
    for i in range(grid_size):
        # [up, right, down, left]
        grid.append([[None, None, None, None]for j in range(grid_size)])
    dic_path = {}

    for edge in list_edge:
        a = int(edge[0])
        b = int(edge[1])
        edge_key = "%s_%s" % (a, b)
        a_l = positions[str(a)][0]
        a_c = positions[str(a)][1]
        b_l = positions[str(b)][0]
        b_c = positions[str(b)][1]

        dic_path[edge_key] = []
        ret = find_route(grid_size, grid,
                         dic_path[edge_key], a, a_l, a_c, b_l, b_c)
        if not ret:
            return False, grid, dic_path
    return True, grid, dic_path

    '''  # verify if is routing
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
            pe_curr = pos_node_i * grid_size + pos_node_j
            dic_path[key].append(pe_curr)
            count_per_curr.append(pe_curr)

            # go to right neighbor
            # [pe], [0 = top, 1 = right, 2 = down, 3 = left], [0 = IN, OUT = 1]
            # go right
            if diff_j > 0 and pe_curr+1 < (pos_node_i+1)*grid_size and (grid[pe_curr][1][0] == -1 or grid[pe_curr][1][0] == a) and grid[pe_curr+1][3][0] != a and (pe_curr+1) not in count_per_curr:
                grid[pe_curr][1][0] = a
                pos_node_j += 1
                change = True
                # print("VIZ right 1")
            # go left
            elif diff_j < 0 and pe_curr-1 >= (pos_node_i)*grid_size and (grid[pe_curr][3][0] == -1 or grid[pe_curr][3][0] == a) and grid[pe_curr-1][1][0] != a and (pe_curr-1) not in count_per_curr:
                grid[pe_curr][3][0] = a
                pos_node_j -= 1
                change = True
                # print("VIZ left 1")
            # go down
            elif diff_i > 0 and pe_curr+grid_size < total_grid_size and (grid[pe_curr][2][0] == -1 or grid[pe_curr][2][0] == a) and grid[pe_curr+grid_size][0][0] != a and (pe_curr+grid_size) not in count_per_curr:
                grid[pe_curr][2][0] = a
                pos_node_i += 1
                change = True
                # print("VIZ down 1")
            # go up
            elif diff_i < 0 and pe_curr-grid_size >= 0 and (grid[pe_curr][0][0] == -1 or grid[pe_curr][0][0] == a) and grid[pe_curr-grid_size][2][0] != a and (pe_curr-grid_size) not in count_per_curr:
                grid[pe_curr][0][0] = a
                pos_node_i -= 1
                change = True
                # print("VIZ top 1")

            if not change:  # change, try a long path

                # go right
                if pe_curr+1 < (pos_node_i+1)*grid_size and (grid[pe_curr][1][0] == -1 or grid[pe_curr][1][0] == a) and grid[pe_curr+1][3][0] != a and (pe_curr+1) not in count_per_curr:
                    grid[pe_curr][1][0] = a
                    pos_node_j += 1
                    change = True
                    # print("right 1")
                # go left
                elif pe_curr-1 >= (pos_node_i)*grid_size and (grid[pe_curr][3][0] == -1 or grid[pe_curr][3][0] == a) and grid[pe_curr-1][1][0] != a and (pe_curr-1) not in count_per_curr:
                    grid[pe_curr][3][0] = a
                    pos_node_j -= 1
                    change = True
                    # print("left 1")
                # go down
                elif pe_curr+grid_size < total_grid_size and (grid[pe_curr][2][0] == -1 or grid[pe_curr][2][0] == a) and grid[pe_curr+grid_size][0][0] != a and (pe_curr+grid_size) not in count_per_curr:
                    grid[pe_curr][2][0] = a
                    pos_node_i += 1
                    change = True
                    # print("down 1")
                elif pe_curr-grid_size >= 0 and (grid[pe_curr][0][0] == -1 or grid[pe_curr][0][0] == a) and grid[pe_curr-grid_size][2][0] != a and (pe_curr-grid_size) not in count_per_curr:  # go up
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

        pe_final = pos_node_i * grid_size + pos_node_j
    return True, grid, dic_path'''
