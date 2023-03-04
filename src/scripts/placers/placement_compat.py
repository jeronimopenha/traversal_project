import os
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import traceback
import json
import networkx as nx
from math import sqrt, ceil
from src.util import get_files, fix_networkx_digraph, create_folders


def create_nodes_map(map_file_full_path: str):
    nodes_map = {}
    with open(map_file_full_path) as f:
        lines = f.readlines()
        for line in lines:
            line = line.replace('\n', '')
            n_vec = line.split(';')
            if n_vec[1] != '':
                nodes_map[n_vec[0]] = n_vec[1]
    f.close()
    return nodes_map


def save_placement(placements: dict(), output_folder_name: str):
    for bench_name in placements.keys():
        for k in range(len(placements[bench_name])):
            placement = placements[bench_name][k]
            dest = placement['dest']
            dest = dest+'/' if dest[-1] != '/'else dest
            p = '%s%s' % (dest, output_folder_name)
            create_folders(p)
            p += '%s_%s.json' % (bench_name, '{:0>3}'.format(k))
            with open(p, 'w') as json_file:
                json.dump(placement, json_file, indent=4)
            json_file.close()


if __name__ == '__main__':
    try:
        dot_path = './bench/test_bench/async/'
        placement_path = './exp_results/placements/sa/mesh/async/1000/'
        output_path = './exp_results/placements/sa/mesh/async/1000/'

        files_map = get_files(placement_path, '.map')
        files_raw = get_files(placement_path, '.raw')
        files_dot = get_files(dot_path, '.dot')

        # create the pimary dictionary to convert
        # the placement nodes indexes to the dot nodes indexes
        nodes_map = {}
        for k in files_map.keys():
            nodes_map[files_map[k]['file_name_no_ext']] = create_nodes_map(
                files_map[k]['file_full_path'])
        del k

        # opening every benchmark dot file
        benchmarks = {}
        for k in files_dot.keys():
            g = nx.DiGraph(nx.nx_pydot.read_dot(
                files_dot[k]['file_full_path']))
            fix_networkx_digraph(g)
            benchmarks[files_dot[k]['file_name_no_ext']] = g
            del g
        del k

        # change the dictionary above to link the raw placement indexes to
        # the benchmark dot indexes
        for k in benchmarks.keys():
            g = benchmarks[k]
            nodes = list(g.nodes)
            for n in nodes:
                node = g.nodes[n]
                lb = node['label']
                for nm in nodes_map[k]:
                    if nodes_map[k][nm] == lb:
                        nodes_map[k][nm] = n
                        break
                del nm, lb, node
            del nodes, n, g
        del k
        # read the raw files correcting the nodes indexes and
        # creating a json file for each one
        placements = {}
        for kfr in files_raw:
            bench_name = files_raw[kfr]['file_name_no_ext']
            with open(files_raw[kfr]['file_full_path']) as file:
                lines = file.readlines()
            file.close()
            del file

            placement_raw = []
            for line in lines:
                line = line.replace('\n', '').split(';')
                for cell in line:
                    if cell == '-1':
                        placement_raw.append(None)
                    else:
                        placement_raw.append(nodes_map[bench_name][cell])
                del cell
            del line, lines

            g = benchmarks[bench_name]
            nodes = list(g.nodes)
            edges = list(g.edges)
            n_edges = len(edges)
            matrix_len = len(placement_raw)
            matrix_len_sqrt = ceil(sqrt(matrix_len))
            total_cost = 0
            edges_raw = {}
            distances_max = 0
            distances = {}
            multicast_max = 0
            multicasts = {}
            for e in edges:
                # finding the positions for each node of the edge
                n1 = placement_raw.index(e[0], 0, matrix_len)
                n2 = placement_raw.index(e[1], 0, matrix_len)
                l1 = n1//matrix_len_sqrt
                c1 = n1 % matrix_len_sqrt
                l2 = n2//matrix_len_sqrt
                c2 = n2 % matrix_len_sqrt
                edge_cost = abs(l1-l2) + abs(c1-c2)
                edges_raw['%s_%s' % (e[0], e[1])] = {}
                edges_raw['%s_%s' % (e[0], e[1])]['a'] = e[0]
                edges_raw['%s_%s' % (e[0], e[1])]['b'] = e[1]
                edges_raw['%s_%s' % (e[0], e[1])]['cost'] = edge_cost
                total_cost += edge_cost
                if edge_cost > distances_max:
                    distances_max = edge_cost
                if edge_cost not in distances.keys():
                    distances[edge_cost] = 0
                distances[edge_cost] += 1
                del c1, c2, l1, l2, n1, n2
            del e, matrix_len, matrix_len_sqrt, edge_cost, edges

            for node in nodes:
                out_degree = g.out_degree[node]
                if out_degree > multicast_max:
                    multicast_max = out_degree
                if out_degree not in multicasts.keys():
                    multicasts[out_degree] = 0
                multicasts[out_degree] += 1
                del out_degree
            del node, g, nodes

            dist_sorted_keys = sorted(distances.keys())
            multicast_sorted_keys = sorted(multicasts.keys())
            placement_json = {'benchmark': bench_name,
                              'placement_raw_file': kfr,
                              'min_cost': n_edges,
                              'total_cost': total_cost,
                              'multicast_max': multicast_max,
                              'distances_max': distances_max,
                              'multicasts': {key: multicasts[key] for key in multicast_sorted_keys},
                              'distances': {key: distances[key] for key in dist_sorted_keys},
                              'placement': placement_raw,
                              'edges': edges_raw,
                              'dest': files_raw[kfr]['base_path'].replace('/raw', '')
                              }
            if bench_name not in placements.keys():
                placements[bench_name] = []
            placements[bench_name].append(placement_json)

            del distances, distances_max, edges_raw, multicast_max, multicasts
            del n_edges, dist_sorted_keys, multicast_sorted_keys, placement_json
            del placement_raw, total_cost, bench_name
        del kfr, benchmarks, nodes_map

        # save unsorted placements
        save_placement(placements, 'json_unsorted/')

        # save sorted placements
        for bench_name in placements.keys():
            placements[bench_name].sort(key=lambda v: v['total_cost'])
        save_placement(placements, 'json_sorted/')

        a = 1

    except Exception as e:
        print(e)
        traceback.print_exc()
