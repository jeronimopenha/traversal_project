import os
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import traceback
import json
import networkx as nx
from math import sqrt, ceil


def create_nodes_map(map_file: str):
    nodes_map = {}
    with open(map_file) as f:
        lines = f.readlines()
        for line in lines:
            line = line.replace('\n', '')
            n_vec = line.split(';')
            if n_vec[1] != '':
                nodes_map[n_vec[0]] = n_vec[1]
        del line, lines, n_vec
    f.close()
    del f

    return nodes_map


if __name__ == '__main__':
    try:
        dot_path = './bench/test_bench/assincrono_optimal/'
        input_path = './exp_results/placements/sa/mesh/assincrono_optimal/'
        output_path = './exp_results/placements/sa/mesh/assincrono_optimal/'

        files_map = []
        files_dot = []
        files_raw = []

        # discover all files to be processed
        for dir, folder, files in os.walk(input_path):
            for f in files:
                # map files
                if '.map' in f:
                    files_map.append(
                        [os.path.join(dir, f), f, f.split('.')[0]])
                elif '.raw' in f:
                    # raw placement files
                    files_raw.append(
                        [os.path.join(dir, f), f, f.split('.')[0]])

        # benchmarks dot files
        for dir, folder, files in os.walk(dot_path):
            for f in files:
                files_dot.append(
                    [os.path.join(dir, f), f, f.split('.')[0]])
        del dir, folder, files, f

        # create the pimary dictionary to convert
        # the placement nodes indexes to the dot nodes indexes
        nodes_map = {}
        for i in files_map:
            nodes_map[i[2]] = create_nodes_map(i[0])
        del i

        # opening every benchmark dot file
        benchmarks = {}
        for f in files_dot:
            benchmarks[f[2]] = nx.DiGraph(nx.nx_pydot.read_dot(f[0]))
        del f

        # change the dictionary above to link the raw placement indexes to
        # the benchmark dot indexes
        for b in benchmarks.keys():
            g = benchmarks[b]
            nodes = list(g.nodes)
            if '\\n' in nodes:
                nodes.remove('\\n')
                g.remove_node('\\n')
            for l in nodes:
                node = g.nodes[l]
                lb = node['label']
                for n in nodes_map[b]:
                    if nodes_map[b][n] == lb:
                        nodes_map[b][n] = l
                        break
                del n, lb, node
            del nodes, l, g
        del b
        # read the raw files correcting the nodes indexes and
        # creating a json file for each one
        placements = {}
        for file in files_raw:
            with open(file[0]) as f:
                lines = f.readlines()
            f.close()
            del f

            placement_raw = []
            for l in lines:
                l = l.replace('\n', '')
                l = l.split(';')
                for i in l:
                    if i == '-1':
                        placement_raw.append(None)
                    else:
                        placement_raw.append(nodes_map[file[2]][i])
                del i
            del l, lines

            g = benchmarks[file[2]]
            nodes = list(g.nodes)
            n_nodes = len(nodes)
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

            for node in nodes:
                out_degree = g.out_degree[node]
                if out_degree > multicast_max:
                    multicast_max = out_degree
                if out_degree not in multicasts.keys():
                    multicasts[out_degree] = 0
                multicasts[out_degree] += 1

            dist_sorted_keys = sorted(distances.keys())
            multicast_sorted_keys = sorted(multicasts.keys())
            placement_json = {'benchmark': file[2],
                              'placement_raw_file': file[1],
                              'min_cost': n_edges,
                              'total_cost': total_cost,
                              'multicast_max': multicast_max,
                              'distances_max': distances_max,
                              'multicasts': {key: multicasts[key] for key in multicast_sorted_keys},
                              'distances': {key: distances[key] for key in dist_sorted_keys},
                              'placement': placement_raw,
                              'edges': edges_raw,
                              'dest': file[0].replace(file[1], '')
                              }
            if file[2] not in placements.keys():
                placements[file[2]] = []
            placements[file[2]].append(placement_json)
        for bench in placements.keys():
            placements[bench].sort(key=lambda v: v['total_cost'])
        for bench in placements.keys():
            for i in range(len(placements[bench])):
                b = placements[bench][i]
                p = '%s/%s_%s.json' % (b['dest'],
                                       b['benchmark'], '{:0>3}'.format(i))
                with open(p, 'w') as json_file:
                    json.dump(b, json_file, indent=4)
                json_file.close()
        a = 1
    except Exception as e:
        print(e)
        traceback.print_exc()
