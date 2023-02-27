import os
import shutil
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import traceback
import networkx as nx
from asynchronous_dataflow.src.make_test_bench import make_test_bench
from veriloggen import Module, simulation
import json
import multiprocessing as mp


def add_regs(dataflow):
    df = dataflow.copy()
    for edge in dataflow.edges():
        if int(dataflow.edges[edge]['w']) > 0:
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


def create_simul(s_dot: str) -> Module:
    dataflow_dot = nx.DiGraph(nx.nx_pydot.read_dot(s_dot))
    nodes = dataflow_dot.nodes()
    while '\\n' in nodes.keys():
        dataflow_dot.remove_node('\\n')
    file = s_dot[2:-4].replace('/', '_').replace('-', '_')
    # .to_verilog('src/' + file + '.v')
    dataflow_dot = add_regs(dataflow_dot)
    m = make_test_bench(file, dataflow_dot)
    return m, file


def simul(file_l: list(), id:int):
    dot = file_l[0]
    bench_name = file_l[1]
    verilog_path = file_l[3]
    data_output_path = file_l[4]
    results_path = file_l[5]

    m, file = create_simul(dot)
    m.to_verilog('%s%s.v' % (verilog_path, file))
    sim = simulation.Simulator(m, sim="iverilog")
    rslt = sim.run(outputfile='%d.out' % id)
    lines = rslt.split('\n')
    lines.pop(0)
    lines.pop(-1)
    th = float(lines[-1].split(':')
               [1].replace(' ', '').replace('%', ''))
    lines.pop(-1)
    simul_results = {
        'benchmark': bench_name.replace('.dot', ''),
        'simul_step': 'original',
        'throughput': th
    }
    with open('%s%s.json' % (results_path, file), 'w') as json_file:
        json.dump(simul_results, json_file, indent=4)
    json_file.close()

    data = {}
    # counter = 0
    for line in lines:
        '''print(line, ' ', str(counter))
        counter += 1'''
        parts = line.split(',')
        c = parts[0].replace('c_', '').replace(' ', '')
        d = parts[1].replace(' ', '')
        if c not in data.keys():
            data[c] = []
        data[c].append(d)
    with open('%s%s.json' % (data_output_path, file), 'w') as json_file:
        json.dump(data, json_file, indent=4)
    json_file.close()


def worker_function(id: int, n_threads: int, files_l: list()):
    n_files = len(files_l)
    for idx in range(id, n_files, n_threads):
        if (idx < n_files):
            print("Running simul %d" % idx)
            simul(files_l[idx], id)


if __name__ == '__main__':
    try:
        input_path = './bench/test_bench/test_simul/'
        output_path = './exp_results/simulations/bench/test_simul/'

        if os.path.exists(output_path):
            shutil.rmtree(output_path)

        os.mkdir(output_path)

        file_l = []

        for dir, folder, files in os.walk(input_path):
            for f in files:
                data = []
                data .append(os.path.join(dir, f))
                data.append(f.replace('.dot', ''))
                data.append('%s.dot' % f.split('.')[0])
                others = dir.replace(input_path, '').split('/')
                vec = []
                s = output_path
                for other in others:
                    vec.append(other)
                    s = '%s%s/' % (s, other)
                    if not os.path.exists(s):
                        os.mkdir(s)
                temp = '%sverilog/' % s
                if not os.path.exists(temp):
                    os.mkdir(temp)
                data.append(temp)
                temp = '%soutput/' % s
                if not os.path.exists(temp):
                    os.mkdir(temp)
                data.append(temp)
                temp = '%sresults/' % s
                if not os.path.exists(temp):
                    os.mkdir(temp)
                data.append(temp)
                data.append(vec)
                file_l.append(data)

        # executing the SA algorithm in multithreads
        workers = list()
        #n_threads = 1  # os.cpu_count()//2
        n_workers = os.cpu_count()
        for i in range(n_workers):
            x = mp.Process(target=worker_function, args=(i,
                                                         n_workers,
                                                         file_l
                                                         ))
            print("Simulator Main    : creating and starting %s." % x.name)
            workers.append(x)
            x.start()

        for th in workers:
            th.join()
            print("Simulator Main    : %s done." % th.name)
        a = 1

    except Exception as e:
        print(e)
        traceback.print_exc()
