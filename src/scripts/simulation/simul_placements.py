import os
import shutil
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import traceback
import networkx as nx
from src.simulator.simul_make_test_bench import make_test_bench
from src.simulator.simul import simul_add_regs, simul_graph_batch
from src.util import create_folders, get_files, read_json_file, fix_networkx_digraph, insert_slash_in_path

if __name__ == '__main__':
    try:
        dot_path = './bench/test_bench/async_optimal/'
        placement_path = './exp_results/placements/sa/mesh/async_optimal/1000/'
        output_path = './exp_results/simulations/placements/sa/mesh/async_optimal/'
        type_placemnet = '_unsorted'
        output_path = insert_slash_in_path(output_path)
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
            placements_to_remove = []
            send_to_simul = {}
            counter = 1
            for placement in placement_files.keys():
                if counter > 10:
                    print()
                    break
                if placement_files[placement]['benchmark'] == bench:
                    print(counter, end='\r')
                    counter += 1
                    placements_to_remove.append(placement)
                    g = nx.DiGraph(nx.nx_pydot.read_dot(
                        dot_files[dot]['file_full_path']))
                    fix_networkx_digraph(g)
                    placement_json = read_json_file(
                        placement_files[placement]['file_full_path'])

                    json_edges = []
                    for e in placement_json['edges'].keys():
                        if placement_json['edges'][e]['cost'] > 1:
                            vec = []
                            vec.append(e.split('_')[0])
                            vec.append(e.split('_')[1])
                            vec.append(placement_json['edges'][e]['cost'])
                            json_edges.append(vec)
                            del vec
                    del e

                    edges = g.edges
                    for p in edges._adjdict.keys():
                        for f in edges._adjdict[p].keys():
                            for je in json_edges:
                                if p == je[0] and f == je[1]:
                                    edges._adjdict[p][f]['w'] = str(je[2]-1)
                                    edges._adjdict[p][f]['label'] = edges._adjdict[p][f]['w']
                                    json_edges.remove(je)
                                    break

                    send_to_simul[placement] = placement_files[placement]

                    # creating the needed data to simulations
                    name = send_to_simul[placement]['file_name'].replace(
                        '.json', '')
                    send_to_simul[placement]['name'] = name

                    send_to_simul[placement]['output_base_path'] = output_path + bench + '/'

                    # creating the digraph object to generate the verilog simulator
                    send_to_simul[placement]['dataflow'] = g
                    # adding regs to simulate the delays sent on edges
                    send_to_simul[placement]['dataflow_regs'] = simul_add_regs(
                        g)
                    m = make_test_bench(
                        name, send_to_simul[placement]['dataflow_regs'])
                    send_to_simul[placement]['module'] = m

            for p in placements_to_remove:
                placement_files.pop(p)
            del p
            print('Simul_placements: simulating %s%s benchmark' %
                  (bench, type_placemnet))
            simul_graph_batch(send_to_simul, output_path + bench + '/')

    except Exception as e:
        print(e)
        traceback.print_exc()
