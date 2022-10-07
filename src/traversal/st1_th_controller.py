import random as rnd


class St1ThController:
    def __init__(self,
                 n_threads: int = 1,
                 matrix_len: int = 16
                 ):
        rnd.seed(0)
        self.n_threads = n_threads
        self.matrix_len = matrix_len
        self.threads_started = [False for i in range(self.n_threads)]
        self.threads_done = [False for i in range(self.n_threads)]
        self.actual_th = 0
        self.output_new = {
            'started': False,
            'idx': 0,
            'v': False,
            'edge_addr': 0,
            'choice': 0
        }
        self.output = self.output_new.copy()

    def execute(self):
        self.output = self.output_new.copy()

        started = False
        idx = 0
        v = False
        edge_addr = 0
        choice = 0

        if self.actual_th < self.n_threads:
            started = False
            idx = self.actual_th
            v = True
            edge_addr = 0
            choice = 0

            self.actual_th += 1
        else:
            started = True
            idx = 0
            v = False
            edge_addr = 0
            choice = 0

        self.output_new = {
            'started': started,
            'idx': idx,
            'v': v,
            'edge_addr': edge_addr,
            'choice': choice
        }
