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


def simul(s_dot: str) -> Module:
    dataflow_dot = nx.DiGraph(nx.nx_pydot.read_dot(s_dot))
    nodes = dataflow_dot.nodes()
    while '\\n' in nodes.keys():
        dataflow_dot.remove_node('\\n')
    file = s_dot[2:-4].replace('/', '_').replace('-', '_')
    # .to_verilog('src/' + file + '.v')
    m = make_test_bench(file, dataflow_dot)
    return m, file


if __name__ == '__main__':
    try:
        input_path = './bench/test_bench/'
        output_path = './exp_results/simulations/bench/'

        if os.path.exists(output_path):
            shutil.rmtree(output_path)

        os.mkdir(output_path)

        files_l = []

        for dir, folder, files in os.walk(input_path):
            for f in files:
                data = []
                data .append(os.path.join(dir, f))
                data.append(f[:-4])
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
                files_l.append(data)

        for i in range(len(files_l)):
            dot = files_l[i][0]
            bench_name = files_l[i][1]
            verilog_path = files_l[i][3]
            data_output_path= files_l[i][4]
            results_path = files_l[i][5]

            m, file = simul(dot)
            m.to_verilog('%s%s.v' % (verilog_path, file))
            sim = simulation.Simulator(m, sim="iverilog")
            rslt = sim.run()
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
            # print(rslt)

    except Exception as e:
        print(e)
        traceback.print_exc()
