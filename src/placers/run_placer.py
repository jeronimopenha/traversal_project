import os
import sys


if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import traceback
import src.util as _u
import src.placers.sap.sap as _sap

if __name__ == '__main__':
    try:
        experimental_dot = '/home/jeronimo/Documentos/GIT/traversal_project/bench/test_bench/conv3.dot'
        pr_graph = _u.PRGraph(experimental_dot)
        ret = _sap.create_placement_json(pr_graph)
        print(ret)

    except Exception as e:
        print(e)
        traceback.print_exc()
