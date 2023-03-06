import os
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import traceback
import matplotlib.pyplot as plt
from src.util import read_json_file, get_files


if __name__ == '__main__':
    try:
        input_path = './exp_results/simulations/placements/sa/mesh/async_optimal/'
        output_path_base = './exp_results/line_graphs/'

        json_files = get_files(input_path, '.json')

        graph_dict = {}
        simul_results = {}
        for file in json_files.keys():
            bench = json_files[file]['file_name_no_ext'][:-4]
            if bench not in simul_results.keys():
                simul_results[bench] = []
            simul_results[bench].append(json_files[file])

            del bench
        del file

        for bench in simul_results.keys():
            simul_results[bench].sort(key=lambda v: v['file_name'])
            throughput = []
            for file in simul_results[bench]:
                json_content = read_json_file(file['file_full_path'])
                throughput.append(json_content['throughput_worst'])
                del json_content
            del file

            plt.title('Results of simulations for %s' % bench)
            x = [i+1 for i in range(len(simul_results[bench]))]
            
            plt.plot(x, throughput, label='throughput')
            plt.legend()
            plt.savefig(output_path_base + bench +'.png')
            plt.cla()
            plt.clf()
            a = 1
        del bench

        '''for strategy in strategies:

            input_path = '%s%s/%s/' % (input_path_base, placer, strategy)
            files_router = find_files_conditional(input_path, '.json')
            routed = read_json_files(files_router)
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

        a = 1'''

    except Exception as e:
        print(e)
        traceback.print_exc()
