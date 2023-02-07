import os
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import traceback
import json
import networkx as nx
from math import ceil, sqrt
from src.routers.maze.maze import *


if __name__ == '__main__':
    try:
        # SA - DOT WITH REGS
        #placements_input_path = './exp_results/placements/sa/'
        #results_output_path = './exp_results/routers/maze/sa/given/'

        # YOLT - DOT WITH REGS
        placements_input_path = './exp_results/placements/yolt/'
        results_output_path = './exp_results/routers/maze/yolt/given/'

        # YOTT - DOT WITH REGS
        #placements_input_path = './exp_results/placements/yott/'
        #results_output_path = './exp_results/routers/maze/yott/given/'

        files_placements = find_files_conditional(
            placements_input_path, '.json')
        placements = read_json(files_placements)
        routings = {}

        # random edges to routing
        for pl in placements.keys():
            matrix_sqrt = ceil(sqrt(len(placements[pl]['placement'])))
            edges = read_maze_edges(placements[pl]['edges'])

            positions = get_maze_positions(
                placements[pl]['placement'], matrix_sqrt)

            routed, grid, dic_path = routing_mesh(
                edges, matrix_sqrt, positions)

            if routed:
                ed = {}
                router_cost = 0
                for e in edges:
                    k = '%s_%s' % (e[0], e[1])
                    cost = len(dic_path[k])
                    router_cost += cost
                    ed[k] = {
                        'a': e[0],
                        'b': e[1],
                        'cost': cost,
                        'path': dic_path[k]
                    }
                routings[pl] = {'benchmark': placements[pl]['benchmark'],
                                'test': 'given',
                                'placement_file': '%s.json' % pl,
                                'placer_cost': placements[pl]['total_cost'],
                                'router_cost': router_cost,
                                'positions': positions,
                                'edges': ed
                                }
        for k in routings:
            with open('%s%s/%s.json' % (results_output_path, placements[k]['benchmark'], k), 'w') as json_file:
                json.dump(routings[k], json_file, indent=4)
            json_file.close()

    except Exception as e:
        print(e)
        traceback.print_exc()
