import os
import shutil
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import networkx as nx
import json
from veriloggen import *
import multiprocessing as mp
from src.util import get_files, create_folders, fix_networkx_digraph, insert_slash_in_path
from src.simulator.simul_make_test_bench import make_test_bench


def dot_create_data_to_simulate(file_dic: dict, output_path: str) -> dict:
    # take data for one dot
    create_folders('%sverilog' % output_path)
    create_folders('%soutput' % output_path)
    create_folders('%sdot' % output_path)
    create_folders('%sresults' % output_path)

    # creating the needed data to simulations
    name = file_dic['file_name'].replace('.dot', '')
    file_dic['name'] = name
    output_path = insert_slash_in_path(output_path)
    file_dic['output_base_path'] = output_path

    # creating the digraph object to generate the verilog simulator
    file_dic['dataflow'] = nx.DiGraph(
        nx.nx_pydot.read_dot(file_dic['file_full_path']))
    fix_networkx_digraph(file_dic['dataflow'])
    # adding regs to simulate the delays sent on edges
    file_dic['dataflow_regs'] = simul_add_regs(
        file_dic['dataflow'])
    m = make_test_bench(name, file_dic['dataflow_regs'])
    file_dic['module'] = m
    return file_dic


def simul_add_regs(dataflow: nx.DiGraph()):
    df = dataflow.copy()
    for edge in dataflow.edges():
        if int(dataflow.edges[edge]['w']) > 0:
            dataflow.edges[edge]['label'] = dataflow.edges[edge]['w']
            src = edge[0]
            dst = edge[1]
            port = int(dataflow.edges[edge]['port'])
            for r in range(int(dataflow.edges[edge]['w'])):
                id = '%s_%s' % edge + '_%d' % r
                df.add_node(id)
                nx.set_node_attributes(df, {id: {'label': 'reg', 'op': 'reg'}})
                df.add_edge(src, id)
                nx.set_edge_attributes(df, {(src, id): {'port': 0, 'w': 0}})
                src = id
            df.add_edge(src, dst)
            nx.set_edge_attributes(df, {(src, dst): {'port': port, 'w': 0}})
            df.remove_edge(edge[0], edge[1])
    return df


def start_simulation(files_dic: dict):
    workers = list()
    # n_workers = 1
    n_workers = os.cpu_count()
    for i in range(min(n_workers, len(files_dic))):
        # worker_function(i, n_workers, file_dic)
        x = mp.Process(target=worker_function, args=(i,
                                                     n_workers,
                                                     files_dic
                                                     ))
        print("Simulator: creating and starting %s simulation process." % x.name)
        workers.append(x)
        x.start()

    for wk in workers:
        wk.join()
        print("Simulator: %s simulation process done." % wk.name)


def worker_function(id: int, n_workers: int, files_dic: dict):
    keys = list(files_dic.keys())
    n_files = len(keys)
    for idx in range(id, n_files, n_workers):
        if idx < n_files:
            print("Worker: Running simulation %d" % idx)
            m = files_dic[keys[idx]]['module']
            verilog_path = '%sverilog/%s.v' % (
                files_dic[keys[idx]]['output_base_path'], files_dic[keys[idx]]['name'])
            m.to_verilog(verilog_path)
            sim = simulation.Simulator(m, sim="iverilog")
            rslt = sim.run(outputfile='%d.out' % id)
            write_output_results(files_dic[keys[idx]], rslt)
    os.remove('%d.out' % id)


def write_output_results(file_dic: dict(), rslt: str):
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
        'benchmark': file_dic['name'],
        'throughput_worst': worst_th,
        'throughput_avg': worst_th,
    }
    with open('%sresults/%s.json' % (file_dic['output_base_path'], file_dic['name']), 'w') as json_file:
        json.dump(simul_results, json_file, indent=4)
    json_file.close()

    # FIXME For the output data uncoment the lines below
    '''data = {}
    # counter = 0
    for line in lines:
        parts = line.split(',')
        c = parts[0].replace('c_', '').replace(' ', '')
        d = parts[1].replace(' ', '')
        if c not in data.keys():
            data[c] = []
        data[c].append(d)
    with open('%s/output/%s.json' % (file_dic['output_base_path'], file_dic['name']), 'w') as json_file:
        json.dump(data, json_file, indent=4)
    json_file.close()'''


def simul_dot_batch(dot_files_path: str, output_path: str):
    # get the dot files list
    file_dic = get_files(dot_files_path, '.dot')
    # creating the needed data to simulations
    print('Simul_dot_batch: creating data to simulate')
    counter = 1
    for file in file_dic.keys():
        print('%d/%d' % (counter, len(file_dic.keys())), end='\r')
        counter += 1
        file_dic[file] = dot_create_data_to_simulate(
            file_dic[file], output_path)

    print()
    print('Simul_dot_batch: starting simulation')
    start_simulation(file_dic)
    '''workers = list()
    # n_workers = 1
    n_workers = os.cpu_count()
    for i in range(min(n_workers, len(file_dic))):
        #worker_function(i, min(n_workers, len(file_dic)), file_dic)
        x = mp.Process(target=worker_function, args=(i,
                                                     min(n_workers, len(
                                                         file_dic)),
                                                     file_dic
                                                     ))
        print("Simul_dot_batch: creating and starting %s simulation process." % x.name)
        workers.append(x)
        x.start()

    for wk in workers:
        wk.join()
        print("Simul_dot_batch: %s simulation process done." % wk.name)'''


def simul_graph_batch(graphs: dict, output_path: str) -> dict:
    # Create the output folders
    create_folders('%sverilog' % output_path)
    create_folders('%soutput' % output_path)
    create_folders('%sdot' % output_path)
    create_folders('%sresults' % output_path)

    print('Simul_graph_batch: starting simulation')
    workers = list()
    # n_workers = 1
    n_workers = os.cpu_count()
    for i in range(min(n_workers, len(graphs))):
        # worker_function(i, min(n_workers, len(graphs)), graphs)
        x = mp.Process(target=worker_function, args=(i,
                                                     min(n_workers, len(
                                                         graphs)),
                                                     graphs
                                                     ))
        print("Simul_dot_batch: creating and starting %s simulation process." % x.name)
        workers.append(x)
        x.start()

    for wk in workers:
        wk.join()
        print("Simul_dot_batch: %s simulation process done." % wk.name)
