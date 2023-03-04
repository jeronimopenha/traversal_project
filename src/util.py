import os
import shutil
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import networkx as nx
import json


def insert_slash_in_path(str_path: str) -> str:
    str_temp = str_path + '/' if str_path[-1] != '/' else str_path
    return str_temp


def get_files(initial_path: str, ext_contition: str = None) -> list():
    files_l = {}

    for dir, folder, files in os.walk(initial_path):
        for f in files:
            temp = dir
            temp = insert_slash_in_path(temp)
            if ext_contition is not None:
                if ext_contition in f:
                    files_l[f] = {'file_name': f,
                                  'file_name_no_ext': f.split('.')[0],
                                  'file_full_path': '%s/%s' % (temp, f),
                                  'base_path': dir
                                  }
            else:
                files_l[f] = {'file_name': f,
                              'file_name_no_ext': f.split('.')[0],
                              'file_full_path': '%s/%s' % (temp, f),
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


def fix_networkx_digraph(g=nx.DiGraph()):
    # fixing the nx reading commmon problem
    nodes = g.nodes
    while '\\n' in nodes.keys():
        g.remove_node('\\n')


def read_json_files(files: list()):
    data = {}
    for file in files:
        with open(file[0]) as p_file:
            contents = p_file.read()
            data[file[2]] = json.loads(contents)
        p_file.close()
    return data
