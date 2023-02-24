import os
import shutil
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import traceback
import json
import matplotlib.pyplot as plt
import pandas as pd


'''rnd.seed(0)
# Creating dataset
data = [rnd.randint(0,1000) for i in range(200)]
 
fig = plt.figure(figsize =(10, 7))
 
# Creating plot
plt.boxplot(data)
 
# show plot
plt.show()
a=1'''


def read_json(file: str):
    with open(file) as p_file:
        contents = p_file.read()
        content_dic = json.loads(contents)
    p_file.close()
    return content_dic


if __name__ == '__main__':
    try:
        input_path = './exp_results/simulations/bench/test_simul/'
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

        data = {}
        for i in range(len(files_l)):
            print('%d/%d' % (i+1, len(files_l)))
            cost = files_l[i][3][0]
            if not isinstance(cost, int):
                continue

            if cost not in data.keys():
                data[cost] = []

            json_dict = read_json(files_l[i][0])

            data[cost].append(float(json_dict['throughput']))




        # Set the figure size
        plt.rcParams["figure.figsize"] = [7.50, 3.50]
        plt.rcParams["figure.autolayout"] = True
        # Pandas dataframe
        data = pd.DataFrame(data)
        # Plot the dataframe
        ax = data[list(data.keys())].plot(kind='box', title='boxplot')
        # Display the plot
        plt.show()

        '''for cost in data.keys():
            
            plt.boxplot(data[cost])
        
            # show plot
            plt.show()'''

        a = 1

    except Exception as e:
        print(e)
        traceback.print_exc()
