import os
import sys


if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

from math import sqrt
import random as rnd
import st1_th_controller as _st1
import st2_edges as _st2
import st3_n2c as _st3
import st4_choice as _st4
import st5_c2n as _st5
import util as _u

if __name__ == '__main__':
    # rnd.seed(0)
    tr_graph = _u.TrGraph(os.getcwd() + '/src/dot/mac.dot')
    n_threads = 5
    matrix_len = 16
    first_node = int(tr_graph.edges[0][0])
    first_cell = [rnd.randint(0, matrix_len-1) for i in range(n_threads)]
    choices = [
        [[0,1],[1,0],[0,-1],[-1,0],[-1,-1],[1,-1],[-1,1],[1,1],[-2,0],[0,-2],[2,0],[0,2],[-3,0],[0,3],[3,0],[0,-3],],
        [[0,1],[1,0],[0,-1],[-1,0],[,],[,],[,],[,],[,],[,],[,],[,],[,],[,],[,],[,],],
        [[0,1],[1,0],[0,-1],[-1,0],[,],[,],[,],[,],[,],[,],[,],[,],[,],[,],[,],[,],],
        [[0,1],[1,0],[0,-1],[-1,0],[,],[,],[,],[,],[,],[,],[,],[,],[,],[,],],
        [[0,1],[1,0],[0,-1],[-1,0],[,],[,],[,],[,],[,],[,],[,],[,],[,],[,],[,],[,],],
        [[0,1],[1,0],[0,-1],[-1,0],[,],[,],[,],[,],[,],[,],[,],[,],[,],[,],[,],[,],],
        [[0,1],[1,0],[0,-1],[-1,0],[,],[,],[,],[,],[,],[,],[,],[,],[,],[,],[,],[,],],
        [[0,1],[1,0],[0,-1],[-1,0],[,],[,],[,],[,],[,],[,],[,],[,],[,],[,],[,],[,],],
    ]

    st1 = _st1.St1ThController(n_threads)
    st2 = _st2.St2Edges(n_threads, matrix_len, tr_graph.edges)
    st3 = _st3.St3N2c(n_threads, matrix_len, first_node, first_cell)
    st4 = _st4.St4Choice(n_threads, matrix_len, choices)
    st5 = _st5.St5C2n(n_threads, matrix_len, first_node, first_cell)

    for i in range(200):
        st1.execute()
        st2.execute(st1.output, st5.output)
        st3.execute(st2.output, st5.output)
        st4.execute(st3.output)
        st5.execute(st4.output, st5.output)

    matrix_len_sqrt = int(sqrt(matrix_len))
    for t in range(n_threads):
        print('TH: %d', t)
        for l in range(matrix_len_sqrt):
            _str = ''
            for c in range(matrix_len_sqrt):
                d = st5.c2n[t][(matrix_len_sqrt*l) + c]
                if d is None:
                    _str += '   _'
                else:
                    _str += '%03d_' % d
            print(_str)
        print()
