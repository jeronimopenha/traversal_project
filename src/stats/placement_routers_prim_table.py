import os
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import traceback
from src.routers.maze.maze import read_json, find_files_conditional

if __name__ == '__main__':
    try:
        placers = ['sa', 'yolt', 'yott']

        input_path_base = sys.path[-1]+'/exp_results/routers/maze/'
        output_path_base = sys.path[-1]+'/exp_results/stats/'

        for placer in placers:
            input_path = '%s%s/given/' % (input_path_base, placer)

            files_router = find_files_conditional(input_path, '.json')
            routed = read_json(files_router)
            if len(routed) == 0:
                continue
            stats = {}
            for r in routed.keys():
                benchmark = routed[r]['benchmark']
                if benchmark not in stats.keys():
                    stats[benchmark] = []
                stats[benchmark].append(routed[r])

            for stat in stats.keys():
                stats[stat].sort(key=lambda v: v['router_cost'])
            a = 1

    except Exception as e:
        print(e)
        traceback.print_exc()
