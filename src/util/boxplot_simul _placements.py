import os
import shutil
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import traceback
import json
import matplotlib.pyplot as plt
import pandas as pd
import csv


def read_json(file: str):
    with open(file) as p_file:
        contents = p_file.read()
        content_dic = json.loads(contents)
    p_file.close()
    return content_dic


if __name__ == '__main__':
    try:
        input_path = './exp_results/simulations/placements/sa/mesh/'
        fig_path = './exp_results/boxplots/'
        csv_name = 'placement_simul.csv'
        files_l = []

        for dir, folder, files in os.walk(input_path):
            if '/results' not in dir:
                continue
            for f in files:

                fig_name = dir.replace(input_path, '').replace(
                    '/', '_').replace('_results', '')
                data = []
                data.append(os.path.join(dir, f))
                data.append(f.replace('.dot', ''))
                data.append('%s.dot' % f.split('.')[0])
                data.append(f.split('.')[0])
                others = dir.replace(input_path, '').replace(
                    '/results', '').split('/')
                data.append(others)
                files_l.append(data)
                del others
            del f
        del dir, folder, files

        data = {}
        csv_data = {}
        for i in range(len(files_l)):
            print('%d/%d' % (i+1, len(files_l)))
            test_type = files_l[i][4][0]
            bench = files_l[i][4][-1]

            if test_type not in data.keys():
                data[test_type] = {}
            if test_type not in csv_data.keys():
                csv_data[test_type] = {}

            if bench not in data[test_type].keys():
                data[test_type][bench] = []
            if bench not in csv_data[test_type].keys():
                csv_data[test_type][bench] = []

            json_dict = read_json(files_l[i][0])
            data[test_type][bench].append(float(json_dict['throughput']))
            csv_data[test_type][bench].append(
                [float(json_dict['throughput']), files_l[i][3]])
            del test_type, json_dict
        del files_l, i

        for t in data.keys():
            temp = {}
            keys = list(data[t].keys())
            keys.sort()
            for k in keys:
                temp[k] = data[t][k]
            data[t] = temp
            del temp, k, keys
        del t

        for k in data.keys():
            # Set the figure size
            plt.rcParams["figure.figsize"] = [7.50, 3.50]
            plt.rcParams["figure.autolayout"] = True
            # Pandas dataframe
            pd_data = pd.DataFrame(data[k])
            # Plot the dataframe
            ax = pd_data[list(pd_data.keys())].plot(
                kind='box', title='boxplot')
            # Display the plot
            # plt.show()
            plt.savefig('%s%s' % (fig_path, k), dpi='figure', format='svg')

        del pd_data, data, ax, fig_name, k

        for t in csv_data.keys():
            temp = {}
            keys = list(csv_data[t].keys())
            keys.sort()
            for k in keys:
                temp[k] = csv_data[t][k]
                temp[k].sort(key=lambda v: v[0], reverse=True)
            csv_data[t] = temp

            del temp, keys
        del t

        csv_header = ['test_type', 'benchmark', 'throughput', 'file']
        csv_rows = []
        for t in csv_data.keys():
            for k in csv_data[t].keys():
                for i in range(len(csv_data[t][k])):
                    row = []
                    row.append(t)
                    row.append(k)
                    row.append(csv_data[t][k][i][0])
                    row.append(csv_data[t][k][i][1])
                    csv_rows.append(row)
                    del row
                del i
            del k
        del t

        with open('%s%s' % (fig_path, csv_name), 'w') as f:
            writer = csv.writer(f)
            writer.writerow(csv_header)
            writer.writerows(csv_rows)
        f.close()
        del f

        a = 1

    except Exception as e:
        print(e)
        traceback.print_exc()
