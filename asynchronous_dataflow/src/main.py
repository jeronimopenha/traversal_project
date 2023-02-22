import networkx as nx

from make_test_bench import make_test_bench



def add_regs(dataflow):
    df = dataflow.copy()
    for edge in dataflow.edges():
        if int(dataflow.edges[edge]['weight']) > 0:
            src = edge[0]
            dst = edge[1]
            port = int(dataflow.edges[edge]['port'])
            for r in range(int(dataflow.edges[edge]['weight'])):
                id = '%s_%s' % edge + '_%d' % r
                df.add_node(id)
                nx.set_node_attributes(df, {id: {'label': 'reg', 'op': 'reg'}})
                df.add_edge(src, id)
                nx.set_edge_attributes(df, {(src, id): {'port': 0, 'weight': 0}})
                src = id
            df.add_edge(src, dst)
            nx.set_edge_attributes(df, {(src, dst): {'port': port, 'weight': 0}})
            df.remove_edge(edge[0], edge[1])
    return df


def main():
    fp = open('files.txt','r')
    files = fp.read()
    fp.close()
    dots = files.split('\n')
    for d in dots:
        try:
            file = d[5:-4].replace('/', '_').replace('-', '_')
            print(file)
            dataflow_dot = nx.DiGraph(nx.nx_pydot.read_dot(d))
            make_test_bench(file, dataflow_dot).to_verilog('src/'+ file + '.v')
            dataflow_dot = add_regs(dataflow_dot)
            make_test_bench(file, dataflow_dot).to_verilog('src/' + file + '_with_regs.v')
            nx.drawing.nx_pydot.write_dot(dataflow_dot, 'dots/'+ file + '_with_regs.dot')
        except Exception as e:
            print(e)


if __name__ == '__main__':
    main()
