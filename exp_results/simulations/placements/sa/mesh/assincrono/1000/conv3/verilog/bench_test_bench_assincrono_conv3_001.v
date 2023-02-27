

module bench_test_bench_assincrono_conv3
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
  wire din_req_6;
  wire din_ack_6;
  wire [data_width-1:0] din_6;
  wire din_req_8;
  wire din_ack_8;
  wire [data_width-1:0] din_8;
  wire din_req_11;
  wire din_ack_11;
  wire [data_width-1:0] din_11;
  wire din_req_14;
  wire din_ack_14;
  wire [data_width-1:0] din_14;
  wire din_req_16;
  wire din_ack_16;
  wire [data_width-1:0] din_16;
  wire din_req_19;
  wire din_ack_19;
  wire [data_width-1:0] din_19;
  wire din_req_22;
  wire din_ack_22;
  wire [data_width-1:0] din_22;
  wire dout_req_23;
  wire dout_ack_23;
  wire [data_width-1:0] dout_23;
  wire dout_req_24;
  wire dout_ack_24;
  wire [data_width-1:0] dout_24;
  wire [32-1:0] count_producer [0:9-1];
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


  always @(posedge clk) begin
    if(rst) begin
      count_clock <= 0;
    end 
    count_clock <= count_clock + 1;
    if(done) begin
      $display("bench_test_bench_assincrono_conv3 throughput: %5.2f%%", (100.0 * (count_consumer[0] / (count_clock / 4.0))));
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
    .producer_id(6),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_6
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_6),
    .ack(din_ack_6),
    .dout(din_6),
    .count(count_producer[2])
  );


  producer
  #(
    .producer_id(8),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_8
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_8),
    .ack(din_ack_8),
    .dout(din_8),
    .count(count_producer[3])
  );


  producer
  #(
    .producer_id(11),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_11
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_11),
    .ack(din_ack_11),
    .dout(din_11),
    .count(count_producer[4])
  );


  producer
  #(
    .producer_id(14),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_14
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_14),
    .ack(din_ack_14),
    .dout(din_14),
    .count(count_producer[5])
  );


  producer
  #(
    .producer_id(16),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_16
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_16),
    .ack(din_ack_16),
    .dout(din_16),
    .count(count_producer[6])
  );


  producer
  #(
    .producer_id(19),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_19
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_19),
    .ack(din_ack_19),
    .dout(din_19),
    .count(count_producer[7])
  );


  producer
  #(
    .producer_id(22),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_22
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_22),
    .ack(din_ack_22),
    .dout(din_22),
    .count(count_producer[8])
  );


  consumer
  #(
    .consumer_id(23),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_23
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_23),
    .ack(dout_ack_23),
    .din(dout_23),
    .count(count_consumer[0])
  );


  consumer
  #(
    .consumer_id(24),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_24
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_24),
    .ack(dout_ack_24),
    .din(dout_24),
    .count(count_consumer[1])
  );


  conv3
  #(
    .data_width(data_width)
  )
  conv3
  (
    .clk(clk),
    .rst(rst),
    .din_req_1(din_req_1),
    .din_ack_1(din_ack_1),
    .din_1(din_1),
    .din_req_4(din_req_4),
    .din_ack_4(din_ack_4),
    .din_4(din_4),
    .din_req_6(din_req_6),
    .din_ack_6(din_ack_6),
    .din_6(din_6),
    .din_req_8(din_req_8),
    .din_ack_8(din_ack_8),
    .din_8(din_8),
    .din_req_11(din_req_11),
    .din_ack_11(din_ack_11),
    .din_11(din_11),
    .din_req_14(din_req_14),
    .din_ack_14(din_ack_14),
    .din_14(din_14),
    .din_req_16(din_req_16),
    .din_ack_16(din_ack_16),
    .din_16(din_16),
    .din_req_19(din_req_19),
    .din_ack_19(din_ack_19),
    .din_19(din_19),
    .din_req_22(din_req_22),
    .din_ack_22(din_ack_22),
    .din_22(din_22),
    .dout_req_23(dout_req_23),
    .dout_ack_23(dout_ack_23),
    .dout_23(dout_23),
    .dout_req_24(dout_req_24),
    .dout_ack_24(dout_ack_24),
    .dout_24(dout_24)
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



module conv3 #
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
  output din_req_6,
  input din_ack_6,
  input [data_width-1:0] din_6,
  output din_req_8,
  input din_ack_8,
  input [data_width-1:0] din_8,
  output din_req_11,
  input din_ack_11,
  input [data_width-1:0] din_11,
  output din_req_14,
  input din_ack_14,
  input [data_width-1:0] din_14,
  output din_req_16,
  input din_ack_16,
  input [data_width-1:0] din_16,
  output din_req_19,
  input din_ack_19,
  input [data_width-1:0] din_19,
  output din_req_22,
  input din_ack_22,
  input [data_width-1:0] din_22,
  input dout_req_23,
  output dout_ack_23,
  output [data_width-1:0] dout_23,
  input dout_req_24,
  output dout_ack_24,
  output [data_width-1:0] dout_24
);

  wire req_0_3;
  wire ack_0;
  wire [data_width-1:0] d0;
  wire req_1_0;
  wire ack_1;
  wire [data_width-1:0] d1;
  wire req_3_12;
  wire ack_3;
  wire [data_width-1:0] d3;
  wire req_4_3;
  wire ack_4;
  wire [data_width-1:0] d4;
  wire req_5_25;
  wire req_5_26;
  wire ack_5;
  wire [data_width-1:0] d5;
  wire req_6_5;
  wire ack_6;
  wire [data_width-1:0] d6;
  wire req_7_10;
  wire ack_7;
  wire [data_width-1:0] d7;
  wire req_8_7;
  wire ack_8;
  wire [data_width-1:0] d8;
  wire req_10_12;
  wire ack_10;
  wire [data_width-1:0] d10;
  wire req_11_10;
  wire ack_11;
  wire [data_width-1:0] d11;
  wire req_12_20;
  wire ack_12;
  wire [data_width-1:0] d12;
  wire req_13_15;
  wire ack_13;
  wire [data_width-1:0] d13;
  wire req_14_13;
  wire ack_14;
  wire [data_width-1:0] d14;
  wire req_15_18;
  wire ack_15;
  wire [data_width-1:0] d15;
  wire req_16_15;
  wire ack_16;
  wire [data_width-1:0] d16;
  wire req_18_18_20_0;
  wire ack_18;
  wire [data_width-1:0] d18;
  wire req_19_18;
  wire ack_19;
  wire [data_width-1:0] d19;
  wire req_20_24;
  wire ack_20;
  wire [data_width-1:0] d20;
  wire req_21_23;
  wire ack_21;
  wire [data_width-1:0] d21;
  wire req_22_21;
  wire ack_22;
  wire [data_width-1:0] d22;
  wire req_25_0;
  wire req_25_7;
  wire ack_25;
  wire [data_width-1:0] d25;
  wire req_26_21;
  wire req_26_26_13_0;
  wire ack_26;
  wire [data_width-1:0] d26;
  wire req_18_20_0_20;
  wire ack_18_20_0;
  wire [data_width-1:0] d18_20_0;
  wire req_26_13_0_13;
  wire ack_26_13_0;
  wire [data_width-1:0] d26_13_0;

  async_operator
  #(
    .data_width(data_width),
    .op("mul"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  mul_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_25_0, req_1_0}),
    .ack_l({ack_25, ack_1}),
    .req_r({req_0_3}),
    .ack_r(ack_0),
    .din({d25, d1}),
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
    .req_l({req_4_3, req_0_3}),
    .ack_l({ack_4, ack_0}),
    .req_r({req_3_12}),
    .ack_r(ack_3),
    .din({d4, d0}),
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
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  addi_5
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_6_5}),
    .ack_l({ack_6}),
    .req_r({req_5_25, req_5_26}),
    .ack_r(ack_5),
    .din({d6}),
    .dout(d5)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_6
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_6),
    .ack_l(din_ack_6),
    .req_r({req_6_5}),
    .ack_r(ack_6),
    .din(din_6),
    .dout(d6)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("mul"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  mul_7
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_25_7, req_8_7}),
    .ack_l({ack_25, ack_8}),
    .req_r({req_7_10}),
    .ack_r(ack_7),
    .din({d25, d8}),
    .dout(d7)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_8
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_8),
    .ack_l(din_ack_8),
    .req_r({req_8_7}),
    .ack_r(ack_8),
    .din(din_8),
    .dout(d8)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("mul"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  mul_10
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_11_10, req_7_10}),
    .ack_l({ack_11, ack_7}),
    .req_r({req_10_12}),
    .ack_r(ack_10),
    .din({d11, d7}),
    .dout(d10)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_11
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_11),
    .ack_l(din_ack_11),
    .req_r({req_11_10}),
    .ack_r(ack_11),
    .din(din_11),
    .dout(d11)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_12
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_10_12, req_3_12}),
    .ack_l({ack_10, ack_3}),
    .req_r({req_12_20}),
    .ack_r(ack_12),
    .din({d10, d3}),
    .dout(d12)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_13
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_26_13_0_13, req_14_13}),
    .ack_l({ack_26_13_0, ack_14}),
    .req_r({req_13_15}),
    .ack_r(ack_13),
    .din({d26_13_0, d14}),
    .dout(d13)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_14
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_14),
    .ack_l(din_ack_14),
    .req_r({req_14_13}),
    .ack_r(ack_14),
    .din(din_14),
    .dout(d14)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("mul"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  mul_15
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_16_15, req_13_15}),
    .ack_l({ack_16, ack_13}),
    .req_r({req_15_18}),
    .ack_r(ack_15),
    .din({d16, d13}),
    .dout(d15)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_16
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_16),
    .ack_l(din_ack_16),
    .req_r({req_16_15}),
    .ack_r(ack_16),
    .din(din_16),
    .dout(d16)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("mul"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  mul_18
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_19_18, req_15_18}),
    .ack_l({ack_19, ack_15}),
    .req_r({req_18_18_20_0}),
    .ack_r(ack_18),
    .din({d19, d15}),
    .dout(d18)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_19
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_19),
    .ack_l(din_ack_19),
    .req_r({req_19_18}),
    .ack_r(ack_19),
    .din(din_19),
    .dout(d19)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_20
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_18_20_0_20, req_12_20}),
    .ack_l({ack_18_20_0, ack_12}),
    .req_r({req_20_24}),
    .ack_r(ack_20),
    .din({d18_20_0, d12}),
    .dout(d20)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("mul"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  mul_21
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_26_21, req_22_21}),
    .ack_l({ack_26, ack_22}),
    .req_r({req_21_23}),
    .ack_r(ack_21),
    .din({d26, d22}),
    .dout(d21)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_22
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_22),
    .ack_l(din_ack_22),
    .req_r({req_22_21}),
    .ack_r(ack_22),
    .din(din_22),
    .dout(d22)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_23
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_21_23),
    .ack_l(ack_21),
    .req_r(dout_req_23),
    .ack_r(dout_ack_23),
    .din(d21),
    .dout(dout_23)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_24
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_20_24),
    .ack_l(ack_20),
    .req_r(dout_req_24),
    .ack_r(dout_ack_24),
    .din(d20),
    .dout(dout_24)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(2)
  )
  reg_25
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_5_25}),
    .ack_l({ack_5}),
    .req_r({req_25_0, req_25_7}),
    .ack_r(ack_25),
    .din({d5}),
    .dout(d25)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(2)
  )
  reg_26
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_5_26}),
    .ack_l({ack_5}),
    .req_r({req_26_21, req_26_26_13_0}),
    .ack_r(ack_26),
    .din({d5}),
    .dout(d26)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_18_20_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_18_18_20_0}),
    .ack_l({ack_18}),
    .req_r({req_18_20_0_20}),
    .ack_r(ack_18_20_0),
    .din({d18}),
    .dout(d18_20_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_26_13_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_26_26_13_0}),
    .ack_l({ack_26}),
    .req_r({req_26_13_0_13}),
    .ack_r(ack_26_13_0),
    .din({d26}),
    .dout(d26_13_0)
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

