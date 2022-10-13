from math import ceil, log2, sqrt


class St5C2n:
    def __init__(self,
                 n_threads: int,
                 matrix_len: int,
                 first_node: int,
                 first_cell: list(), 
                 choices_l_qty: int
                 ):
        self.n_threads = n_threads
        self.matrix_len = matrix_len
        self.matrix_sqrt = int(sqrt(self.matrix_len))
        self.choices_l_qty = choices_l_qty
        self.c2n = []
        for i in range(self.n_threads):
            self.c2n.append([None for i in range(self.matrix_len)])
        for i in range(self.n_threads):
            self.c2n[i][first_cell[i]] = first_node

        self.output_new = {
            'idx': 0,
            'v': False,
            'edge_addr': 0,
            'choice': 0,
            'choice_l': 0,
            'sw': {'idx': 0, 'wr': False, 'c_next': 0, 'n_next': 0}

        }
        self.output = self.output_new.copy()

    #FIXME Corrigir as constantes da quantidade de linhas de escolha para um parâmetro
    def execute(self, _in: dict(), _sw):
        self.output = self.output_new.copy()

        idx = _in['idx']
        v = _in['v']
        edge_addr = _in['edge_addr']
        choice = _in['choice']
        choice_l = _in['choice_l']
        n_current = _in['n_current']
        n_next = _in['n_next']
        c_current = _in['c_current']
        process = _in['process']
        c_next = _in['c_next']
        sw = {'idx': 0, 'wr': False, 'c_next': 0, 'n_next': 0}

        # update c2n table
        b_sw = _sw['sw']
        if v or b_sw['wr']:
            a = 1
        if b_sw['wr']:
            self.c2n[b_sw['idx']][b_sw['c_next']] = b_sw['n_next']
            #print('TH %d' % b_sw['idx'])
            #for l in range(self.matrix_sqrt):
            #    print(
            #        self.c2n[b_sw['idx']][l*self.matrix_sqrt:(l*self.matrix_sqrt)+self.matrix_sqrt])
            #print()

        # se process então ver se pode alocar
        # se não pode alocar incrementar choice
        # se pode alocar, atualizar tabelas e incrementar edge addr
        # não for process, incrementar edge addr
        if process:
            if c_next is None:
                choice += 1
            elif self.c2n[idx][c_next] is None:
                sw['c_next'] = c_next
                sw['n_next'] = n_next
                sw['wr'] = True
                sw['idx'] = idx
                choice = 0
                edge_addr += 1
                choice_l = (choice_l + 1) if choice_l < self.choices_l_qty-1 else 0
            else:
                choice += 1
        elif v:
            edge_addr += 1
            choice_l = (choice_l + 1) if choice_l < self.choices_l_qty-1 else 0
            choice = 0

        self.output_new = {
            'idx': idx,
            'v': v,
            'edge_addr': edge_addr,
            'choice': choice,
            'choice_l': choice_l,
            'sw': sw

        }
