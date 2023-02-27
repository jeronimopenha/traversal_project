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


def create_simul(dataflow_dot: nx.DiGraph(), file: str) -> Module:
    dataflow_dot = add_regs(dataflow_dot)
    m = make_test_bench(file, dataflow_dot)
    return m


def simul(file_l: list(), id: int):
    dot = file_l[1]
    bench_name = file_l[0]['benchmark']
    verilog_path = file_l[2]
    data_output_path = file_l[3]
    results_path = file_l[4]
    diff = file_l[5]

    json_edges = []
    for e in file_l[0]['edges'].keys():
        if file_l[0]['edges'][e]['cost'] > 1:
            vec = []
            vec.append(e.split('_')[0])
            vec.append(e.split('_')[1])
            vec.append(file_l[0]['edges'][e]['cost'])
            json_edges.append(vec)
            del vec
    del e

    dataflow_dot = nx.DiGraph(nx.nx_pydot.read_dot(dot))
    nodes = dataflow_dot.nodes()
    edges = dataflow_dot.edges
    while '\\n' in nodes.keys():
        dataflow_dot.remove_node('\\n')
    file = dot[2:-4].replace('/', '_').replace('-', '_')
    for p in edges._adjdict.keys():
        for f in edges._adjdict[p].keys():
            for je in json_edges:
                if p == je[0] and f == je[1]:
                    edges._adjdict[p][f]['w'] = str(je[2]-1)
                    json_edges.remove(je)
                    break

    m = create_simul(dataflow_dot, file)
    m.to_verilog('%s%s_%s.v' % (verilog_path, file, diff))
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
    with open('%s%s_%s.json' % (results_path, file, diff), 'w') as json_file:
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
    with open('%s%s_%s.json' % (data_output_path, file, diff), 'w') as json_file:
        json.dump(data, json_file, indent=4)
    json_file.close()


def worker_function(id: int, n_workers: int, files_l: list()):
    n_files = len(files_l)
    for idx in range(id, n_files, n_workers):
        if (idx < n_files):
            print("Running simul %d" % idx)
            simul(files_l[idx], id)


if __name__ == '__main__':
    try:
        input_path = './exp_results/placements/sa/mesh/assincrono/'
        dot_path = './bench/test_bench/assincrono/'
        output_path = './exp_results/simulations/placements/sa/mesh/assincrono/'

        if os.path.exists(output_path):
            shutil.rmtree(output_path)

        os.mkdir(output_path)

        file_l = []

        limit_counter = 10

        for dir, folder, files in os.walk(input_path):
            for f in files:
                if '.json' not in f:
                    continue
                num = int(f.replace('.json', '').split('_')[-1])
                if num >= limit_counter:
                    continue
                with open('%s/%s' % (dir, f)) as p_file:
                    contents = p_file.read()
                    json_contents = json.loads(contents)
                p_file.close()
                del contents, p_file

                data = []
                data.append(json_contents)
                data.append('%s%s.dot' %
                            (dot_path, json_contents['benchmark']))
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
                data.append('{:0>3}'.format(num))
                data.append(vec)
                file_l.append(data)

        # executing the SA algorithm in multithreads
        workers = list()
        n_workers = os.cpu_count()
        for i in range(n_workers):
            #worker_function(i, n_workers, file_l)
            x = mp.Process(target=worker_function, args=(i,
                                                         n_workers,
                                                         file_l
                                                         ))
            print("Simulator Main    : creating and starting %s." % x.name)
            workers.append(x)
            x.start()

        for wk in workers:
            wk.join()
            print("Simulator Main    : %s done." % wk.name)
        for wk in range(n_workers):
            if os.path.exists("%d.out" % wk):
                os.remove("%d.out" % wk)
        a = 1

    except Exception as e:
        print(e)
        traceback.print_exc()
