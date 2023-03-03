import os
import shutil
import sys

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import traceback

if __name__ == '__main__':
    try:
        placement_path = './exp_results/placements/sa/mesh/assincrono/'
        dot_path = './bench/test_bench/assincrono/'
        output_path = './exp_results/simulations/placements/sa/mesh/assincrono/'

        if os.path.exists(output_path):
            shutil.rmtree(output_path)

        os.mkdir(output_path)

        file_l = []

        limit_counter = 10

        for dir, folder, files in os.walk(placement_path):
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
                others = dir.replace(placement_path, '').split('/')
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
                temp = '%sdot/' % s
                if not os.path.exists(temp):
                    os.mkdir(temp)
                data.append(temp)
                data.append('{:0>3}'.format(num))
                data.append(vec)
                file_l.append(data)

    except Exception as e:
        print(e)
        traceback.print_exc()
