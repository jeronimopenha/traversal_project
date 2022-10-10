import random as rnd


class St1ThController:
    def __init__(self,
                 n_threads: int
                 ):
        rnd.seed(0)
        self.n_threads = n_threads
        self.threads_running = [True for i in range(self.n_threads)]
        self.threads_done = [-1 for i in range(self.n_threads)]
        self.done = False
        self.actual_th = 0
        self.output_new = {
            'start': False,
            'idx': 0,
            'v': False,
            'edge_addr': 0,
            'choice': 0,
            'choice_l': 0
        }
        self.output = self.output_new.copy()

    def execute(self):
        self.output = self.output_new.copy()

        start = False
        idx = 0
        v = False
        edge_addr = 0
        choice = 0
        choice_l = 0

        if self.actual_th < self.n_threads:
            start = True
            idx = self.actual_th
            v = True
            edge_addr = 0
            choice = 0
            choice_l = 0

            self.actual_th += 1
        else:
            start = False
            idx = 0
            v = False
            edge_addr = 0
            choice = 0
            choice_l = 0

        self.output_new = {
            'start': start,
            'idx': idx,
            'v': v,
            'edge_addr': edge_addr,
            'choice': choice,
            'choice_l': choice_l
        }
