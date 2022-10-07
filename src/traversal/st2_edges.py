class St2Edges:
    def __init__(self,
                 n_threads: int = 1,
                 matrix_len: int = 16,
                 edges: list() = []
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

    def execute(self, _in: dict()):
        self.output = self.output_new.copy()

        #TODO
        started = _in['started']
        idx = _in['idx']
        v = _in['v']
        edge_addr = _in['edge_addr']
        choice = _in['choice']
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
