import os
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import traceback
import matplotlib.pyplot as plt
from src.routers.maze.maze import read_json, find_files_conditional


if __name__ == '__main__':
    try:
        placers = ['sa']  # , 'yolt', 'yott']
        strategies = ['given', 'g_l', 'l_g', 'random']

        graph_dict = {}
        # placement_costs = []

        input_path_base = sys.path[-1]+'/exp_results/routers/maze/'
        output_path_base = sys.path[-1]+'/exp_results/stats/'

        for placer in placers:
            for strategy in strategies:

                input_path = '%s%s/%s/' % (input_path_base, placer, strategy)
                files_router = find_files_conditional(input_path, '.json')
                routed = read_json(files_router)
                if len(routed) == 0:
                    continue

                # counter = 0
                # if len(placement_costs) == 0:
                #    for r in routed.keys():
                #        if counter == 100:
                #            break
                #        placement_costs.append(routed[r]['placer_cost'])
                #        counter +=1

                stats = {}
                for r in routed.keys():
                    benchmark = routed[r]['benchmark']
                    if benchmark not in stats.keys():
                        stats[benchmark] = []
                    if len(stats[benchmark]) < 100:
                        stats[benchmark].append(routed[r])

                for b in stats.keys():
                    if b not in graph_dict.keys():
                        graph_dict[b] = {}

                    benchs = stats[b]
                    for bench in benchs:
                        if strategy not in graph_dict[b].keys():
                            graph_dict[b][strategy] = []
                        graph_dict[b][strategy].append(bench['router_cost'])

        for g in graph_dict.keys():
            plt.title('Router cost for %s' % g)
            for d in graph_dict[g].keys():
                x = [i for i in range(len(graph_dict[g][d]))]
                plt.plot(x, graph_dict[g][d], label=d)
            plt.legend()
            plt.show()

        a = 1

        '''

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
            writer.writerows(csv_data)'''

    except Exception as e:
        print(e)
        traceback.print_exc()
