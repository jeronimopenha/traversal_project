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
        input_path = './exp_results/simulations/bench/test_simul/'
        fig_path = './exp_results/boxplots/'
        fig_name = 'test_simul.svg'
        csv_name = 'test_simul.csv'
        files_l = []

        for dir, folder, files in os.walk(input_path):
            if '/results' not in dir:
                continue
            for f in files:
                data = []
                data.append(os.path.join(dir, f))
                data.append(f.replace('.dot', ''))
                data.append('%s.dot' % f.split('.')[0])
                others = dir.replace(input_path, '').split('/')
                vec = []
                for other in others:
                    if 'cost_' in other:
                        other = int(other.replace('cost_', ''))
                    vec.append(other)

                data.append(vec)
                files_l.append(data)
                del other, others, vec
            del f
        del dir, folder, files

        data = {}
        csv_data = {}
        for i in range(len(files_l)):
            print('%d/%d' % (i+1, len(files_l)))
            cost = files_l[i][3][0]
            if not isinstance(cost, int):
                continue

            if cost not in data.keys():
                data[cost] = []
            if cost not in csv_data.keys():
                csv_data[cost] = []

            json_dict = read_json(files_l[i][0])
            data[cost].append(float(json_dict['throughput']))
            csv_data[cost].append(
                [float(json_dict['throughput']), json_dict['benchmark']])
            del cost, json_dict
        del files_l, i

        temp = {}
        keys = list(data.keys())
        keys.sort()
        for k in keys:
            temp[k] = data[k]
        data = temp
        del temp, k, keys

        # Set the figure size
        plt.rcParams["figure.figsize"] = [7.50, 3.50]
        plt.rcParams["figure.autolayout"] = True
        # Pandas dataframe
        pd_data = pd.DataFrame(data)
        # Plot the dataframe
        ax = pd_data[list(pd_data.keys())].plot(kind='box', title='boxplot')
        # Display the plot
        # plt.show()
        plt.savefig('%s%s' % (fig_path, fig_name), dpi='figure', format='svg')

        del pd_data, data, ax

        temp = {}
        keys = list(csv_data.keys())
        keys.sort()
        for k in keys:
            temp[k] = csv_data[k]
            temp[k].sort(key=lambda v: v[0], reverse=True)
        csv_data = temp

        del temp, keys

        csv_header = ['added cost', 'throughput', 'file']
        csv_rows = []
        for k in csv_data.keys():
            for i in range(len(csv_data[k])):
                row = []
                row.append(k)
                row.append(csv_data[k][i][0])
                row.append(csv_data[k][i][1])
                csv_rows.append(row)
                del row
            del i
        del k

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
