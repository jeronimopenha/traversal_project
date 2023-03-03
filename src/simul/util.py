import os
import shutil
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import networkx as nx


def get_files(initial_path: str, ext_contition: str = None) -> list():
    files_l = {}

    for dir, folder, files in os.walk(initial_path):
        for f in files:
            if ext_contition is not None:
                if ext_contition in f:
                    files_l[f] = {'file_full_path': '%s%s' % (dir,f),
                                  'base_path': dir
                                  }
    return files_l


def create_folders(folder_path: str, recreate_folder: bool = False):
    if os.path.exists(folder_path):
        if recreate_folder:
            shutil.rmtree(folder_path)
            os.mkdir(folder_path)
    else:
        if folder_path[-1] == '/':
            folder_path = folder_path[0:-1]
        folders = folder_path.replace('./', '').split('/')
        temp_path = './'
        for folder in folders:
            temp_path += folder+'/'
            if not os.path.exists(temp_path):
                os.mkdir(temp_path)


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