import os
import sys

from more_itertools import first

if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

import st1_th_controller as _st1
import st2_edges as _st2
import st3_n2c as _st3
import st4_choice as _st4
import util as _u

if __name__ == '__main__':
    tr_graph = _u.TrGraph(os.getcwd() + '/src/dot/mac.dot')
    n_threads = 1
    matrix_len = 16
    first_node = int(tr_graph.edges[0][0])
    first_cell = 1
    choices = [1, -1, 4, -4, 2, -2, 8, -8]

    st1 = _st1.St1ThController(n_threads, matrix_len)
    st2 = _st2.St2Edges(n_threads, matrix_len, tr_graph.edges)
    st3 = _st3.St3N2c(n_threads, matrix_len, first_node, first_cell)
    st4 = _st4.St4Choice(n_threads,choices)

    for i in range(100):
        st1.execute()
        st2.execute(st1.output)
        st3.execute(st2.output)
        st4.execute(st3.output)
