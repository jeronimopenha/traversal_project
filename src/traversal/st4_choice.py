from math import sqrt


class St4Choice:
    def __init__(self,
                 n_threads: int,
                 matrix_len: int,
                 choices: list()
                 ):
        self.n_threads = n_threads
        self.matrix_len = matrix_len
        self.matrix_sqrt = int(sqrt(self.matrix_len))
        self.choices = choices.copy()
        #for i in range(self.n_threads):
        #    self.choices.append(choices.copy())

        self.output_new = {
            'idx': 0,
            'v': False,
            'edge_addr': 0,
            'choice': 0,
            'choice_l':0,
            'n_current': 0,
            'n_next': 0,
            'c_current': 0,
            'process': False,
            'c_next': None
        }
        self.output = self.output_new.copy()

    def execute(self, _in: dict()):
        self.output = self.output_new.copy()

        idx = _in['idx']
        v = _in['v']

        #print('st_4_th:%d v:%d, sw_wr:' % (idx, v, ))

        edge_addr = _in['edge_addr']
        choice = _in['choice']
        choice_l = _in['choice_l']
        n_current = _in['n_current']
        n_next = _in['n_next']
        c_current = _in['c_current']
        process = _in['process']

        c_next = None
        if v:
            if choice >= len(self.choices):
                ch = self.choices[choice_l][-1]
            else:
                ch = self.choices[choice_l][choice]
            l = c_current // self.matrix_sqrt
            c = c_current % self.matrix_sqrt
            l += ch[0]
            c += ch[1]
            if not(l < 0 or l > self.matrix_sqrt-1 or c < 0 or c > self.matrix_sqrt-1):
                c_next = (l*self.matrix_sqrt) + c

        self.output_new = {
            'idx': idx,
            'v': v,
            'edge_addr': edge_addr,
            'choice': choice,
            'choice_l': choice_l,
            'n_current': n_current,
            'n_next': n_next,
            'c_current': c_current,
            'process': process,
            'c_next': c_next
        }
