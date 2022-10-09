class St2Edges:
    def __init__(self,
                 n_threads: int,
                 matrix_len: int,
                 edges: list()
                 ):
        self.n_threads = n_threads
        self.matrix_len = matrix_len
        self.edges_table = []
        for e in edges:
            self.edges_table.append(
                [
                    int(e[0]), int(e[1])
                ]
            )
        self.output_new = {
            'idx': 0,
            'v': False,
            'edge_addr': 0,
            'choice': 0,
            'n_current': 0,
            'n_next': 0
        }
        self.output = self.output_new.copy()

    def execute(self, _in: dict(), _p_in: dict()):
        self.output = self.output_new.copy()

        start = _in['start']

        if start:
            idx = _in['idx']
            v = _in['v']
            edge_addr = _in['edge_addr']
            choice = _in['choice']
        else:
            idx = _p_in['idx']
            v = _p_in['v']
            edge_addr = _p_in['edge_addr']
            choice = _p_in['choice']

        n_current = 0
        n_next = 0
        if edge_addr >= len(self.edges_table):
            v = False
        else:
            n_current = self.edges_table[edge_addr][0]
            n_next = self.edges_table[edge_addr][1]

        self.output_new = {
            'idx': idx,
            'v': v,
            'edge_addr': edge_addr,
            'choice': choice,
            'n_current': n_current,
            'n_next': n_next
        }
