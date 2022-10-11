from math import ceil, log2


class St3N2c:
    def __init__(self,
                 n_threads: int,
                 matrix_len: int,
                 first_node: int,
                 first_cell: list()
                 ):
        self.n_threads = n_threads
        self.matrix_len = matrix_len
        self.n2c = []
        for i in range(self.n_threads):
            self.n2c.append([None for i in range(self.matrix_len)])
        for i in range(self.n_threads):
            self.n2c[i][first_node] = first_cell[i]

        self.output_new = {
            'idx': 0,
            'v': False,
            'edge_addr': 0,
            'choice': 0,
            'choice_l': 0,
            'n_current': 0,
            'n_next': 0,
            'c_current': 0,
            'process': False
        }
        self.output = self.output_new.copy()

    def execute(self, _in: dict(), _sw: dict()):
        self.output = self.output_new.copy()

        idx = _in['idx']
        v = _in['v']

        #print('st_3_th:%d v:%d, sw_wr:' % (idx, v, ))

        edge_addr = _in['edge_addr']
        choice = _in['choice']
        choice_l = _in['choice_l']
        n_current = _in['n_current']
        n_next = _in['n_next']
        c_current = self.n2c[idx][n_current]

        # update n2c table
        sw = _sw['sw']
        if v or sw['wr']:
            a = 1
        if sw['wr']:
            #print('st3 WR')
            self.n2c[sw['idx']][sw['n_next']] = sw['c_next']

        if self.n2c[idx][n_next] is not None or not v:
            process = False
        else:
            process = True

        self.output_new = {
            'idx': idx,
            'v': v,
            'edge_addr': edge_addr,
            'choice': choice,
            'choice_l': choice_l,
            'n_current': n_current,
            'n_next': n_next,
            'c_current': c_current,
            'process': process
        }
