from veriloggen import *

from make_component import make_dataflow
import networkx as nx


def make_producer():
    m = Module('producer')
    producer_id = m.Parameter('producer_id', 0)
    data_width = m.Parameter('data_width', 8)
    fail_rate = m.Parameter('fail_rate', 0)
    is_const = m.Parameter('is_const', 'false')
    initial_value = m.Parameter('initial_value', 0)
    clk = m.Input('clk')
    rst = m.Input('rst')
    req = m.Input('req')
    ack = m.OutputReg('ack')
    dout = m.OutputReg('dout', data_width)
    count = m.OutputReg('count', 32)

    dout_next = m.Reg('dout_next', data_width)
    stop = m.Reg('stop')
    randd = m.Real('randd')
    m.Always(Posedge(clk))(
        If(rst)(
            dout(initial_value),
            dout_next(initial_value),
            ack(0),
            count(0),
            stop(0),
            randd(EmbeddedCode('$abs($random%101)+1')),
        ).Else(
            ack(0),
            randd(EmbeddedCode('$abs($random%101)+1')),
            stop(Mux(randd > fail_rate, 0, 1)),
            # If(ack)(
            #    Write("p_%d,%d\\n",producer_id,dout)
            # ),
            If(req & ~ack & Not(stop))(
                ack(1),
                dout(dout_next),
                If(is_const == "false")(
                    dout_next.inc()
                ),
                count.inc()
            )
        )
    )

    return m


def make_consumer():
    m = Module('consumer')
    consumer_id = m.Parameter('consumer_id', 0)
    data_width = m.Parameter('data_width', 8)
    fail_rate = m.Parameter('fail_rate', 0)
    clk = m.Input('clk')
    rst = m.Input('rst')
    req = m.OutputReg('req')
    ack = m.Input('ack')
    din = m.Input('din', data_width)
    count = m.OutputReg('count', 32)
    stop = m.Reg('stop')
    randd = m.Real('randd')
    m.Always(Posedge(clk))(
        If(rst)(
            req(0),
            count(0),
            stop(0),
            randd(EmbeddedCode('$abs($random%101)+1'))
        ).Else(
            req(0),
            randd(EmbeddedCode('$abs($random%101)+1')),
            stop(Mux(randd > fail_rate, 0, 1)),
            If(Not(stop))(
                req(1)
            ),
            If(ack)(
                count.inc(),
                Write("c_%d, %d\\n", consumer_id, din)
            )
        )
    )
    return m


def make_test_bench(file: str, dataflow_dot: nx.DiGraph()):
    dataflow = make_dataflow(dataflow_dot)
    m = Module(file)
    data_width = m.Localparam('data_width', 32)
    fail_rate_producer = m.Localparam('fail_rate_producer', 0)
    fail_rate_consumer = m.Localparam('fail_rate_consumer', 0)
    is_const = m.Localparam('is_const', 'false')
    initial_value = m.Localparam('initial_value', 0)

    max_data_size = m.Localparam('max_data_size', 5000)

    clk = m.Reg('clk')
    rst = m.Reg('rst')

    df_ports = dataflow.get_ports()
    ports = m.get_vars()
    for p in df_ports:
        if p not in ports:
            m.Wire(p, df_ports[p].width)

    ports = m.get_vars()

    n_in = 0
    n_out = 0
    for no in dataflow_dot.nodes:
        if no == '\\n':
            continue
        op = str.lower(dataflow_dot.nodes[no]['op'])
        if op == 'in':
            n_in += 1
        elif op == 'out':
            n_out += 1

    count_producer = m.Wire('count_producer', 32, n_in)
    count_consumer = m.Wire('count_consumer', 32, n_out)
    count_clock = m.Real('count_clock', 32)

    m.EmbeddedCode('')
    consumers_done = m.Wire('consumers_done', n_out)
    done = m.Wire('done')
    for i in range(n_out):
        consumers_done[i].assign(count_consumer[i] >= max_data_size)

    done.assign(Uand(consumers_done))

    simulation.setup_clock(m, clk, hperiod=1)
    simulation.setup_reset(m, rst, period=1)
    # simulation.setup_waveform(m)

    i = m.Integer('i')

    m.Always(Posedge(clk))(
        If(rst)(
            count_clock(0)
        ),
        count_clock.inc(),
        If(done)(
            For(i(0), i < n_out, i.inc())(
                Display(file + " throughput: %d : %5.2f%%", i,
                        Mul(100.0, (count_consumer[i] / (count_clock / 4.0)))),

            ),
            Finish()
        )
    )
    p = make_producer()
    c = make_consumer()
    c_in = 0
    c_out = 0
    for no in dataflow_dot.nodes:
        op = str.lower(dataflow_dot.nodes[no]['op'])
        if op == 'in':
            param = [
                ('producer_id', int(no)),
                ('data_width', data_width),
                ('fail_rate', fail_rate_producer),
                ('initial_value', initial_value),
                ('is_const', is_const)
            ]
            con = [
                ('clk', clk),
                ('rst', rst),
                ('req', ports['din_req_%s' % no]),
                ('ack', ports['din_ack_%s' % no]),
                ('dout', ports['din_%s' % no]),
                ('count', count_producer[c_in])
            ]
            m.Instance(p, p.name + '_%s' % no, param, con)
            c_in += 1
        elif op == 'out':
            param = [
                ('consumer_id', int(no)),
                ('data_width', data_width),
                ('fail_rate', fail_rate_consumer)
            ]
            con = [
                ('clk', clk),
                ('rst', rst),
                ('req', ports['dout_req_%s' % no]),
                ('ack', ports['dout_ack_%s' % no]),
                ('din', ports['dout_%s' % no]),
                ('count', count_consumer[c_out])
            ]
            m.Instance(c, c.name + '_%s' % no, param, con)
            c_out += 1

    m.Instance(dataflow, dataflow.name,
               dataflow.get_params(), dataflow.get_ports())

    return m
