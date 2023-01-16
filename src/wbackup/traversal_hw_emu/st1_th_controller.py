import random as rnd


class St1ThController:
    def __init__(self,
                 n_threads: int
                 ):
        rnd.seed(0)
        self.n_threads = n_threads
        # -1 exec, 0 erro, 1 done
        self.threads_done = [-1 for i in range(self.n_threads)]
        self.done = False
        self.done_cnt = 0
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

    def execute(self, _in: dict()):
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
            choice_l = idx

            self.actual_th += 1
        else:
            start = False
            idx = 0
            v = False
            edge_addr = 0
            choice = 0
            choice_l = 0

        _in_idx = _in['idx']
        _in_state = _in['state']
        _in_done = _in['done']
        if _in_done:
            self.threads_done[_in_idx] = _in_state
            self.done_cnt += 1
        if self.done_cnt == self.n_threads:
            self.done = True

        self.output_new = {
            'start': start,
            'idx': idx,
            'v': v,
            'edge_addr': edge_addr,
            'choice': choice,
            'choice_l': choice_l
        }
