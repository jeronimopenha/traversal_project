

module bench_test_bench_assincrono_atax
(

);

  localparam data_width = 32;
  localparam fail_rate_producer = 0;
  localparam fail_rate_consumer = 0;
  localparam is_const = "false";
  localparam initial_value = 0;
  localparam max_data_size = 5000;
  reg clk;
  reg rst;
  wire din_req_1;
  wire din_ack_1;
  wire [data_width-1:0] din_1;
  wire din_req_4;
  wire din_ack_4;
  wire [data_width-1:0] din_4;
  wire din_req_7;
  wire din_ack_7;
  wire [data_width-1:0] din_7;
  wire dout_req_11;
  wire dout_ack_11;
  wire [data_width-1:0] dout_11;
  wire din_req_13;
  wire din_ack_13;
  wire [data_width-1:0] din_13;
  wire dout_req_14;
  wire dout_ack_14;
  wire [data_width-1:0] dout_14;
  wire [32-1:0] count_producer [0:4-1];
  wire [32-1:0] count_consumer [0:2-1];
  real count_clock;

  wire [2-1:0] consumers_done;
  wire done;
  assign consumers_done[0] = count_consumer[0] >= max_data_size;
  assign consumers_done[1] = count_consumer[1] >= max_data_size;
  assign done = &consumers_done;

  initial begin
    clk = 0;
    forever begin
      #1 clk = !clk;
    end
  end


  initial begin
    rst = 0;
    #1;
    rst = 1;
    #1;
    rst = 0;
  end

  integer i;

  always @(posedge clk) begin
    if(rst) begin
      count_clock <= 0;
    end 
    count_clock <= count_clock + 1;
    if(done) begin
      $display("bench_test_bench_assincrono_atax throughput: %5.2f%%", (100.0 * (count_consumer[0] / (count_clock / 4.0))));
      $finish;
    end 
  end


  producer
  #(
    .producer_id(1),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_1
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_1),
    .ack(din_ack_1),
    .dout(din_1),
    .count(count_producer[0])
  );


  producer
  #(
    .producer_id(4),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_4
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_4),
    .ack(din_ack_4),
    .dout(din_4),
    .count(count_producer[1])
  );


  producer
  #(
    .producer_id(7),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_7
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_7),
    .ack(din_ack_7),
    .dout(din_7),
    .count(count_producer[2])
  );


  consumer
  #(
    .consumer_id(11),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_11
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_11),
    .ack(dout_ack_11),
    .din(dout_11),
    .count(count_consumer[0])
  );


  producer
  #(
    .producer_id(13),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_13
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_13),
    .ack(din_ack_13),
    .dout(din_13),
    .count(count_producer[3])
  );


  consumer
  #(
    .consumer_id(14),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_14
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_14),
    .ack(dout_ack_14),
    .din(dout_14),
    .count(count_consumer[1])
  );


  atax
  #(
    .data_width(data_width)
  )
  atax
  (
    .clk(clk),
    .rst(rst),
    .din_req_1(din_req_1),
    .din_ack_1(din_ack_1),
    .din_1(din_1),
    .din_req_4(din_req_4),
    .din_ack_4(din_ack_4),
    .din_4(din_4),
    .din_req_7(din_req_7),
    .din_ack_7(din_ack_7),
    .din_7(din_7),
    .dout_req_11(dout_req_11),
    .dout_ack_11(dout_ack_11),
    .dout_11(dout_11),
    .din_req_13(din_req_13),
    .din_ack_13(din_ack_13),
    .din_13(din_13),
    .dout_req_14(dout_req_14),
    .dout_ack_14(dout_ack_14),
    .dout_14(dout_14)
  );


endmodule



module producer #
(
  parameter producer_id = 0,
  parameter data_width = 8,
  parameter fail_rate = 0,
  parameter is_const = "false",
  parameter initial_value = 0
)
(
  input clk,
  input rst,
  input req,
  output reg ack,
  output reg [data_width-1:0] dout,
  output reg [32-1:0] count
);

  reg [data_width-1:0] dout_next;
  reg stop;
  real randd;

  always @(posedge clk) begin
    if(rst) begin
      dout <= initial_value;
      dout_next <= initial_value;
      ack <= 0;
      count <= 0;
      stop <= 0;
      randd <= $abs($random%101)+1;
    end else begin
      ack <= 0;
      randd <= $abs($random%101)+1;
      stop <= (randd > fail_rate)? 0 : 1;
      if(req & ~ack & !stop) begin
        ack <= 1;
        dout <= dout_next;
        if(is_const == "false") begin
          dout_next <= dout_next + 1;
        end 
        count <= count + 1;
      end 
    end
  end


endmodule



module consumer #
(
  parameter consumer_id = 0,
  parameter data_width = 8,
  parameter fail_rate = 0
)
(
  input clk,
  input rst,
  output reg req,
  input ack,
  input [data_width-1:0] din,
  output reg [32-1:0] count
);

  reg stop;
  real randd;

  always @(posedge clk) begin
    if(rst) begin
      req <= 0;
      count <= 0;
      stop <= 0;
      randd <= $abs($random%101)+1;
    end else begin
      req <= 0;
      randd <= $abs($random%101)+1;
      stop <= (randd > fail_rate)? 0 : 1;
      if(!stop) begin
        req <= 1;
      end 
      if(ack) begin
        count <= count + 1;
        $write("c_%d, %d\n", consumer_id, din);
      end 
    end
  end


endmodule



module atax #
(
  parameter data_width = 32
)
(
  input clk,
  input rst,
  output din_req_1,
  input din_ack_1,
  input [data_width-1:0] din_1,
  output din_req_4,
  input din_ack_4,
  input [data_width-1:0] din_4,
  output din_req_7,
  input din_ack_7,
  input [data_width-1:0] din_7,
  input dout_req_11,
  output dout_ack_11,
  output [data_width-1:0] dout_11,
  output din_req_13,
  input din_ack_13,
  input [data_width-1:0] din_13,
  input dout_req_14,
  output dout_ack_14,
  output [data_width-1:0] dout_14
);

  wire req_0_10;
  wire req_0_14;
  wire ack_0;
  wire [data_width-1:0] d0;
  wire req_1_0;
  wire ack_1;
  wire [data_width-1:0] d1;
  wire req_3_9;
  wire ack_3;
  wire [data_width-1:0] d3;
  wire req_4_3;
  wire ack_4;
  wire [data_width-1:0] d4;
  wire req_7_9;
  wire ack_7;
  wire [data_width-1:0] d7;
  wire req_9_10;
  wire ack_9;
  wire [data_width-1:0] d9;
  wire req_10_11;
  wire ack_10;
  wire [data_width-1:0] d10;
  wire req_12_0;
  wire req_12_12_3_0;
  wire ack_12;
  wire [data_width-1:0] d12;
  wire req_13_12;
  wire ack_13;
  wire [data_width-1:0] d13;
  wire req_12_3_0_3;
  wire ack_12_3_0;
  wire [data_width-1:0] d12_3_0;

  async_operator
  #(
    .data_width(data_width),
    .op("mul"),
    .immediate(0),
    .input_size(2),
    .output_size(2)
  )
  mul_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_12_0, req_1_0}),
    .ack_l({ack_12, ack_1}),
    .req_r({req_0_10, req_0_14}),
    .ack_r(ack_0),
    .din({d12, d1}),
    .dout(d0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_1
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_1),
    .ack_l(din_ack_1),
    .req_r({req_1_0}),
    .ack_r(ack_1),
    .din(din_1),
    .dout(d1)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("mul"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  mul_3
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_12_3_0_3, req_4_3}),
    .ack_l({ack_12_3_0, ack_4}),
    .req_r({req_3_9}),
    .ack_r(ack_3),
    .din({d12_3_0, d4}),
    .dout(d3)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_4
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_4),
    .ack_l(din_ack_4),
    .req_r({req_4_3}),
    .ack_r(ack_4),
    .din(din_4),
    .dout(d4)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_7
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_7),
    .ack_l(din_ack_7),
    .req_r({req_7_9}),
    .ack_r(ack_7),
    .din(din_7),
    .dout(d7)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("mul"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  mul_9
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_7_9, req_3_9}),
    .ack_l({ack_7, ack_3}),
    .req_r({req_9_10}),
    .ack_r(ack_9),
    .din({d7, d3}),
    .dout(d9)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_10
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_9_10, req_0_10}),
    .ack_l({ack_9, ack_0}),
    .req_r({req_10_11}),
    .ack_r(ack_10),
    .din({d9, d0}),
    .dout(d10)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_11
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_10_11),
    .ack_l(ack_10),
    .req_r(dout_req_11),
    .ack_r(dout_ack_11),
    .din(d10),
    .dout(dout_11)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  addi_12
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_13_12}),
    .ack_l({ack_13}),
    .req_r({req_12_0, req_12_12_3_0}),
    .ack_r(ack_12),
    .din({d13}),
    .dout(d12)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_13
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_13),
    .ack_l(din_ack_13),
    .req_r({req_13_12}),
    .ack_r(ack_13),
    .din(din_13),
    .dout(d13)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_14
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_0_14),
    .ack_l(ack_0),
    .req_r(dout_req_14),
    .ack_r(dout_ack_14),
    .din(d0),
    .dout(dout_14)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_12_3_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_12_12_3_0}),
    .ack_l({ack_12}),
    .req_r({req_12_3_0_3}),
    .ack_r(ack_12_3_0),
    .din({d12}),
    .dout(d12_3_0)
  );


endmodule



module async_operator #
(
  parameter data_width = 32,
  parameter op = "reg",
  parameter immediate = 32,
  parameter input_size = 1,
  parameter output_size = 1
)
(
  input clk,
  input rst,
  output reg [input_size-1:0] req_l,
  input [input_size-1:0] ack_l,
  input [output_size-1:0] req_r,
  output ack_r,
  input [data_width*input_size-1:0] din,
  output [data_width-1:0] dout
);

  reg [data_width*input_size-1:0] din_r;
  wire has_all;
  wire req_r_all;
  reg [output_size-1:0] ack_r_all;
  reg [input_size-1:0] has;
  integer i;
  genvar g;
  assign has_all = &has;
  assign req_r_all = &req_r;
  assign ack_r = &ack_r_all;

  always @(posedge clk) begin
    if(rst) begin
      has <= { input_size{ 1'b0 } };
      ack_r_all <= { output_size{ 1'b0 } };
      req_l <= { input_size{ 1'b0 } };
    end else begin
      for(i=0; i<input_size; i=i+1) begin
        if(~has[i] & ~req_l[i]) begin
          req_l[i] <= 1'b1;
        end 
        if(ack_l[i]) begin
          has[i] <= 1'b1;
          req_l[i] <= 1'b0;
        end 
      end
      if(has_all & req_r_all) begin
        ack_r_all <= { output_size{ 1'b1 } };
        has <= { input_size{ 1'b0 } };
      end 
      if(~has_all) begin
        ack_r_all <= { output_size{ 1'b0 } };
      end 
    end
  end


  generate for(g=0; g<input_size; g=g+1) begin : rcv

    always @(posedge ack_l[g]) begin
      din_r[data_width*(g+1)-1:data_width*g] <= din[data_width*(g+1)-1:data_width*g];
    end

  end
  endgenerate


  operator
  #(
    .input_size(input_size),
    .op(op),
    .immediate(immediate),
    .data_width(data_width)
  )
  operator
  (
    .din(din_r),
    .dout(dout)
  );


endmodule



module operator #
(
  parameter input_size = 1,
  parameter op = "reg",
  parameter immediate = 0,
  parameter data_width = 32
)
(
  input [data_width*input_size-1:0] din,
  output [data_width-1:0] dout
);


  generate if(input_size == 1) begin : gen_op
    if((op === "reg") || (op === "in") || (op === "out")) begin
      assign dout = din;
    end 
    if(op === "addi") begin
      assign dout = din+immediate;
    end 
    if(op === "subi") begin
      assign dout = din-immediate;
    end 
    if(op === "muli") begin
      assign dout = din*immediate;
    end 
  end else begin
    if(input_size == 2) begin
      if(op === "add") begin
        assign dout = din[data_width-1:0]+din[data_width*2-1:data_width];
      end 
      if(op === "sub") begin
        assign dout = din[data_width-1:0]-din[data_width*2-1:data_width];
      end 
      if(op === "mul") begin
        assign dout = din[data_width-1:0]*din[data_width*2-1:data_width];
      end 
    end else begin
      if(input_size == 3) begin
        if(op === "add") begin
          assign dout = din[data_width-1:0]+din[data_width*2-1:data_width]+din[data_width*3-1:data_width*2];
        end 
        if(op === "sub") begin
          assign dout = din[data_width-1:0]-din[data_width*2-1:data_width]-din[data_width*3-1:data_width*2];
        end 
        if(op === "mul") begin
          assign dout = din[data_width-1:0]*din[data_width*2-1:data_width]*din[data_width*3-1:data_width*2];
        end 
      end 
    end
  end
  endgenerate


endmodule

