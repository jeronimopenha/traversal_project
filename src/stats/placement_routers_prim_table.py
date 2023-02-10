import os
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import traceback
import csv 
from src.routers.maze.maze import read_json, find_files_conditional

if __name__ == '__main__':
    try:
        placers = ['sa']  # , 'yolt', 'yott']
        strategies = ['given', 'g_l', 'l_g', 'random']

        csv_dict = {}

        input_path_base = sys.path[-1]+'/exp_results/routers/maze/'
        output_path_base = sys.path[-1]+'/exp_results/stats/'

        max_distance_b = 0
        max_distance_a = 0
        for placer in placers:
            for strategy in strategies:

                input_path = '%s%s/%s/' % (input_path_base, placer, strategy)
                files_router = find_files_conditional(input_path, '.json')
                routed = read_json(files_router)
                if len(routed) == 0:
                    continue

                stats = {}
                for r in routed.keys():
                    benchmark = routed[r]['benchmark']
                    if benchmark not in stats.keys():
                        stats[benchmark] = routed['%s_000' % benchmark]

                for b in stats.keys():
                    if b not in csv_dict.keys():
                        csv_dict[b] = {}

                    keys = list(stats[b]['distances_placer'].keys())
                    if max_distance_b < int(keys[-1]):
                        max_distance_b = int(keys[-1])

                    keys = list(stats[b]['distances_router'].keys())
                    if max_distance_a < int(keys[-1]):
                        max_distance_a = int(keys[-1])

                    csv_dict[b][strategy] = {
                        'benchmark': stats[b]['benchmark'],
                        'edges': stats[b]['min_cost'],
                        'sa_cost': stats[b]['placer_cost'],
                        'router_cost': stats[b]['router_cost'],
                        'distances_b': stats[b]['distances_placer'],
                        'distances_a': stats[b]['distances_router'],
                    }

        header = ['benchmark', 'strategy', 'edges', 'sa_cost', 'router_cost']
        for i in range(1, max_distance_b):
            header.append('db_%d' % i)

        for i in range(1, max_distance_a):
            header.append('da_%d' % i)

        csv_data = []
        for b in csv_dict.keys():
            
            for s in csv_dict[b].keys():
                row = []
                row.append(b)
                row.append(s)
                row.append(csv_dict[b][s]['edges'])
                row.append(csv_dict[b][s]['sa_cost'])
                row.append(csv_dict[b][s]['router_cost'] -
                           csv_dict[b][s]['sa_cost'])
                for i in range(1,max_distance_b):
                    if str(i)in csv_dict[b][s]['distances_b'].keys():
                        row.append(csv_dict[b][s]['distances_b'][str(i)])
                    else:
                        row.append(0)
                for i in range(1,max_distance_a):
                    if str(i)in csv_dict[b][s]['distances_a'].keys():
                        row.append(csv_dict[b][s]['distances_a'][str(i)])
                    else:
                        row.append(0)
                csv_data.append(row)
            

        with open('csv.csv', 'w') as f:
            writer = csv.writer(f)
            writer.writerow(header)
            writer.writerows(csv_data)

    except Exception as e:
        print(e)
        traceback.print_exc()
