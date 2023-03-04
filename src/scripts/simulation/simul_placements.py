import os
import shutil
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import traceback
from src.simulator.simul import simul_dot_batch
from src.util import create_folders, get_files, insert_slash_in_path

if __name__ == '__main__':
    try:
        dot_path = './bench/test_bench/async_optimal/'
        placement_path = './exp_results/placements/sa/mesh/async_optimal/1000/'
        output_path = './exp_results/simulations/placements/sa/mesh/async_optimal/'
        type_placemnet = '_unsorted'
        create_folders(output_path, True)

        dot_files = get_files(dot_path, '.dot')
        placement_files_raw = get_files(placement_path)
        placement_files = {}
        for key in placement_files_raw.keys():
            if type_placemnet in placement_files_raw[key]['base_path']:
                placement_files[key] = placement_files_raw[key]
                placement_files[key]['benchmark'] = placement_files[key]['file_name_no_ext'][0:-4]
        del key, placement_files_raw

        for dot in dot_files.keys():
            bench = dot_files[dot]['file_name_no_ext']
            simul_dot_path = ''
            simul_output_path = ''
            for placement in placement_files.keys():
                if placement_files[placement]['benchmark'] == bench:
                    simul_dot_path = placement_files[placement]['base_path']
                    simul_dot_path = insert_slash_in_path(simul_dot_path)
                    simul_output_path = output_path + bench + '/' + type_placemnet + '/'
                    break
            del placement
            print('Simul_placements: simulating %s%s benchmark' %
                  (bench, type_placemnet))
            # Preciso criar os dots antes
            simul_dot_batch(simul_dot_path, simul_output_path)

    except Exception as e:
        print(e)
        traceback.print_exc()
