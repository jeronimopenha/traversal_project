
class St4Choice:
    def __init__(self,
                 n_threads: int = 1,
                 choices: list() = []
                 ):
        self.n_threads = n_threads
        self.choices = []
        for i in range(self.n_threads):
            self.choices.append(choices.copy())

        self.output_new = {
            'idx': 0,
            'v': False,
            'edge_addr': 0,
            'choice': 0,
            'n_current': 0,
            'n_next': 0,
            'c_current': 0,
            'process': False,
            'c_next': 0
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
        c_current = _in['c_current']
        process = _in['process']

        c_next = self.choices[idx][choice] + c_current

        self.output_new = {
            'idx': idx,
            'v': v,
            'edge_addr': edge_add,
            'choice': choice,
            'n_current': n_current,
            'n_next': n_next,
            'c_current': c_current,
            'process': process,
            'c_next': c_next
        }
