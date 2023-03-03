import os
import shutil
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import networkx as nx
import json
from veriloggen import *
import multiprocessing as mp
from src.util import get_files, create_folders, simul_add_regs
from src.simul_make_test_bench import make_test_bench


def worker_function(id: int, n_workers: int, files_dic: dict()):
    keys = list(files_dic.keys())
    n_files = len(keys)
    for idx in range(id, n_files, n_workers):
        if (idx < n_files):
            print("Simul_dot: Running simulation %d" % idx)
            rslt = simul(id, files_dic[keys[idx]]['module'])
            lines = rslt.split('\n')
            # remove the icarus verilog report log
            lines.pop(0)
            # remove the last blank line
            lines.pop(-1)

            worst_th = None
            avg_th = 0
            counter = 0
            while 'throughput' in lines[-1]:
                th = float(lines[-1].split(':')
                           [2].replace(' ', '').replace('%', ''))
                if worst_th is None:
                    worst_th = th
                else:
                    if worst_th > th:
                        worst_th = th
                avg_th += th
                counter += 1
                lines.pop(-1)
            avg_th /= counter
            simul_results = {
                'benchmark': files_dic[keys[idx]]['name'],
                'simul_step': 'original',
                'throughput_worst': worst_th,
                'throughput_avg': worst_th,
            }
            with open('%sresults/%s.json' % (files_dic[keys[idx]]['output_base_path'], files_dic[keys[idx]]['name']), 'w') as json_file:
                json.dump(simul_results, json_file, indent=4)
            json_file.close()

            data = {}
            # counter = 0
            for line in lines:
                parts = line.split(',')
                c = parts[0].replace('c_', '').replace(' ', '')
                d = parts[1].replace(' ', '')
                if c not in data.keys():
                    data[c] = []
                data[c].append(d)
            with open('%s/output/%s.json' % (files_dic[keys[idx]]['output_base_path'], files_dic[keys[idx]]['name']), 'w') as json_file:
                json.dump(data, json_file, indent=4)
            json_file.close()
    os.remove('%d.out' % id)


def simul(id: int, m: Module()) -> str:
    sim = simulation.Simulator(m, sim="iverilog")
    return sim.run(outputfile='%d.out' % id)


def simul_dot(dot_path: str, output_path: str) -> dict():

    print('Simul_dot: creating the output folders')
    create_folders('%sverilog' % output_path)
    create_folders('%soutput' % output_path)
    create_folders('%sdot' % output_path)
    create_folders('%sresults' % output_path)

    # get the dot files list
    print('Simul_dot: reading files')
    file_dic = get_files(dot_path, '.dot')
    # creating the needed data to simulations
    counter = 1
    for file in file_dic.keys():
        print(counter, end=' ')
        counter += 1
        name = file.replace('.dot', '')
        file_dic[file]['name'] = name
        if output_path[-1] != '/':
            output_path += '/'
        file_dic[file]['output_base_path'] = output_path

        # creating the digraph object to generate the verilog simulator
        file_dic[file]['dataflow'] = nx.DiGraph(
            nx.nx_pydot.read_dot(file_dic[file]['file_full_path']))
        # cleaning the nx reading commmon problem
        nodes = file_dic[file]['dataflow'].nodes
        while '\\n' in nodes.keys():
            file_dic[file]['dataflow'].remove_node('\\n')
        file_dic[file]['dataflow_regs'] = simul_add_regs(
            file_dic[file]['dataflow'])

    print()
    print('Simul_dot: making the simulator')
    counter = 1
    for file in file_dic.keys():
        print(counter, end=' ')
        counter += 1
        m = make_test_bench(name, file_dic[file]['dataflow_regs'])
        m.to_verilog('%sverilog/%s.v' %
                     (file_dic[file]['output_base_path'], file_dic[file]['name']))
        file_dic[file]['module'] = m

    print()
    print('Simul_dot: starting simulation')
    workers = list()
    # n_workers = 1
    n_workers = os.cpu_count()
    for i in range(n_workers):
        #worker_function(i, n_workers, file_dic)
        x = mp.Process(target=worker_function, args=(i,
                                                     n_workers,
                                                     file_dic
                                                     ))
        print("Simul_dot: creating and starting %s simulation process." % x.name)
        workers.append(x)
        x.start()

    for wk in workers:
        wk.join()
        print("Simul_dot: %s simulation process done." % wk.name)
