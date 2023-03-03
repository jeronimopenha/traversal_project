import os
import shutil
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import traceback
from src.simulator.simul import simul_dot_batch
from src.util import create_folders

if __name__ == '__main__':
    try:
        dot_path = '/home/jeronimo/Documents/GIT/traversal_project/bench/test_bench/test_simul/cost_1/'
        output_path = './exp_results/simulations/test/'
        create_folders(output_path,True)
        simul_dot_batch(dot_path,output_path)

    except Exception as e:
        print(e)
        traceback.print_exc()
