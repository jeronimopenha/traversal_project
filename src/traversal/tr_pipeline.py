import os
import sys


if os.getcwd() not in sys.path:
    sys.path.append(os.getcwd())

from math import sqrt
import random
import time
import st1_th_controller as _st1
import st2_edges as _st2
import st3_n2c as _st3
import st4_choice as _st4
import st5_c2n as _st5
import util as _u


def traversal(tr_graph,
              edges: list(),
              first_node: int,
              n_threads: int = 5,
              matrix_len: int = 16,
              matrix_len_sqrt: int = 4,
              times: int = 1
              ) -> list():
    # 1ª LINE - DIST 1
    # 2º LINE - DIST 2
    # 3º LINE - DIST 3
    # depois trocar para espiral
    choices = [
        [[1, 0], [0, 1], [0, -1], [-1, 0],
         [-1, -1], [1, -1], [-1, 1], [1, 1], [-2, 0], [0, -2], [2, 0], [0, 2],
         [-3, 0], [0, 3], [3, 0], [0, -3]],
        [[0, 1], [0, -1], [1, 0], [-1, 0],
         [-2, 0], [0, -2], [2, 0], [0, 2], [-1, -1], [1, -1], [-1, 1], [1, 1],
         [-2, -1], [2, -1], [-2, 1], [2, 1]],
        [[0, 1], [1, 0], [-1, 0], [0, -1],
         [-1, 1], [1, 1], [-1, -1], [1, -1], [-2, 0], [0, -2], [2, 0], [0, 2],
         [-1, -2], [1, -2], [1, 2], [-1, 2]],
        [[1, 0], [0, -1], [0, 1], [-1, 0],
         [-1, -1], [1, -1], [-1, 1], [1, 1],  [2, 0], [0, 2], [-2, 0], [0, -2],
         [-2, 1], [2, 1], [-1, 2], [1, 2]],
        [[0, 1], [0, -1], [-1, 0], [1, 0],
         [-1, 1], [1, 1], [-2, 0], [0, -2], [-1, -1], [1, -1], [2, 0], [0, 2],
         [-2, 1], [-1, 2], [0, 3], [1, 2]],
        [[1, 0], [0, 1], [0, -1], [-1, 0],
         [-1, -1], [1, 1], [-2, 0], [0, -2], [2, 0], [0, 2], [1, -1], [-1, 1],
         [0, -3], [-1, 2], [0, 3], [1, 2]],
        [[0, 1], [1, 0], [0, -1], [-1, 0],
         [-1, 1], [-1, -1], [1, -1],  [1, 1], [0, -2], [-2, 0],  [2, 0], [0, 2],
         [0, -3], [-1, -2], [1, -2], [0, 3]],
        [[0, 1], [-1, 0], [1, 0], [0, -1],
         [-1, -1],  [-2, 0], [0, -2], [2, 0], [0, 2], [1, -1], [-1, 1], [1, 1],
         [-2, -1], [-1, -2], [1, -2], [2, -1]]
    ]

    # nº arestas 1 2 etc
    # histograma
    # pior aresta (mais longa)
    # número arestas maiores que 1
    # comprimento médio
    # número de passadas por nó em média para SA e YOTO

    results = []
    for i in range(times):
        random.seed(time.clock_gettime_ns(time.CLOCK_REALTIME))
        first_cell = [random.randint(0, matrix_len-1)
                      for r in range(n_threads)]
        # print(first_cell)
        st1 = _st1.St1ThController(n_threads)
        st2 = _st2.St2Edges(n_threads, matrix_len, edges)
        st3 = _st3.St3N2c(n_threads, matrix_len, first_node, first_cell)
        st4 = _st4.St4Choice(n_threads, matrix_len, choices)
        st5 = _st5.St5C2n(n_threads, matrix_len, first_node, first_cell)

        while not st1.done:
            st1.execute(st2.output)
            st2.execute(st1.output, st5.output)
            st3.execute(st2.output, st5.output)
            st4.execute(st3.output)
            st5.execute(st4.output, st5.output)

        for t in range(n_threads):
            if st1.threads_done[t] == 1:
                results.append({'th%d' % t: st5.c2n[t]})
                #print('TH: %d', t)
                # for l in range(matrix_len_sqrt):
                #    _str = ''
                #    for c in range(matrix_len_sqrt):
                #        d = st5.c2n[t][(matrix_len_sqrt*l) + c]
                #        if d is None:
                #            _str += '   _'
                #        else:
                #            _str += '%03d_' % d
                #    print(_str)
                # print()
        del st1, st2, st3, st4, st5, t
    return results


def maize_router(results: list()) -> list():
    pass


def main(dot: str, times: int = 1):
    tr_graph = _u.TrGraph(dot)
    n_threads = 5
    matrix_len: int = 16
    matrix_len_sqrt = int(sqrt(matrix_len))
    edges = tr_graph.depth_algorithm()
    first_node = int(edges[0][0])

    results = traversal(tr_graph=tr_graph,
                        edges=edges,
                        first_node=first_node,
                        n_threads=n_threads,
                        matrix_len=matrix_len,
                        matrix_len_sqrt=matrix_len_sqrt,
                        times=times
                        )

    for d in results:
        print(d)


if __name__ == '__main__':
    main(dot=os.getcwd() + '/src/dot/mac.dot',
         times=100)
