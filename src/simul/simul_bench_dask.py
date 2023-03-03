import os
import shutil
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import traceback
import networkx as nx
from simul_make_test_bench import make_test_bench
from veriloggen import Module, simulation
import json
from src.simul import simul_dot
from src.util import create_folders


if __name__ == '__main__':
    try:
        dot_path = '/home/jeronimo/Documents/GIT/traversal_project/bench/test_bench/test_simul/cost_1/'
        output_path = './exp_results/simulations/bench/test_simul/cost1/'
        create_folders(output_path, True)
        simul_dot(dot_path, output_path)
        a=1

    except Exception as e:
        print(e)
        traceback.print_exc()
