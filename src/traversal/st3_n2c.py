from math import ceil, log2


class St3N2c:
    def __init__(self,
                 n_threads: int = 1,
                 matrix_len: int = 16,
                 first_node: int = 0,
                 first_cell: int = 1
                 ):
        self.n_threads = n_threads
        self.matrix_len = matrix_len
        n_c = ceil(log2(self.matrix_len)) + \
            1 if self.n_threads == 1 else ceil(log2(n_threads))
        n_c = 1 << n_c
        self.n2c = [None for i in range(n_c)]
        self.n2c[first_node] = first_cell

        self.output_new = {
            'idx': 0,
            'v': False,
            'edge_addr': 0,
            'choice': 0,
            'n_current': 0,
            'n_next': 0,
            'c_current': 0,
            'process': False
        }
        self.output = self.output_new.copy()

    def execute(self, _in: dict()):
        self.output = self.output_new.copy()

        idx = _in['idx']
        v = _in['v']
        edge_add = _in['edge_addr']
        choice = _in['choice']
        n_current = _in['n_current']
        n_next = _in['n_next']
        c_current = self.n2c[n_current]
        if self.n2c[n_next] or not v:
            process = False
        else:
            process = True

        self.output_new = {
            'idx': idx,
            'v': v,
            'edge_addr': edge_add,
            'choice': choice,
            'n_current': n_current,
            'n_next': n_next,
            'c_current': c_current,
            'process': process
        }
