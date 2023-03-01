

module bench_test_bench_assincrono_optimal_arf
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
  wire din_req_28;
  wire din_ack_28;
  wire [data_width-1:0] din_28;
  wire din_req_29;
  wire din_ack_29;
  wire [data_width-1:0] din_29;
  wire din_req_30;
  wire din_ack_30;
  wire [data_width-1:0] din_30;
  wire din_req_31;
  wire din_ack_31;
  wire [data_width-1:0] din_31;
  wire din_req_32;
  wire din_ack_32;
  wire [data_width-1:0] din_32;
  wire din_req_33;
  wire din_ack_33;
  wire [data_width-1:0] din_33;
  wire din_req_34;
  wire din_ack_34;
  wire [data_width-1:0] din_34;
  wire din_req_35;
  wire din_ack_35;
  wire [data_width-1:0] din_35;
  wire dout_req_36;
  wire dout_ack_36;
  wire [data_width-1:0] dout_36;
  wire dout_req_37;
  wire dout_ack_37;
  wire [data_width-1:0] dout_37;
  wire [32-1:0] count_producer [0:8-1];
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
      $display("bench_test_bench_assincrono_optimal_arf throughput: %5.2f%%", (100.0 * (count_consumer[0] / (count_clock / 4.0))));
      $finish;
    end 
  end


  producer
  #(
    .producer_id(28),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_28
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_28),
    .ack(din_ack_28),
    .dout(din_28),
    .count(count_producer[0])
  );


  producer
  #(
    .producer_id(29),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_29
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_29),
    .ack(din_ack_29),
    .dout(din_29),
    .count(count_producer[1])
  );


  producer
  #(
    .producer_id(30),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_30
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_30),
    .ack(din_ack_30),
    .dout(din_30),
    .count(count_producer[2])
  );


  producer
  #(
    .producer_id(31),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_31
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_31),
    .ack(din_ack_31),
    .dout(din_31),
    .count(count_producer[3])
  );


  producer
  #(
    .producer_id(32),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_32
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_32),
    .ack(din_ack_32),
    .dout(din_32),
    .count(count_producer[4])
  );


  producer
  #(
    .producer_id(33),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_33
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_33),
    .ack(din_ack_33),
    .dout(din_33),
    .count(count_producer[5])
  );


  producer
  #(
    .producer_id(34),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_34
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_34),
    .ack(din_ack_34),
    .dout(din_34),
    .count(count_producer[6])
  );


  producer
  #(
    .producer_id(35),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_35
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_35),
    .ack(din_ack_35),
    .dout(din_35),
    .count(count_producer[7])
  );


  consumer
  #(
    .consumer_id(36),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_36
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_36),
    .ack(dout_ack_36),
    .din(dout_36),
    .count(count_consumer[0])
  );


  consumer
  #(
    .consumer_id(37),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_37
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_37),
    .ack(dout_ack_37),
    .din(dout_37),
    .count(count_consumer[1])
  );


  arf
  #(
    .data_width(data_width)
  )
  arf
  (
    .clk(clk),
    .rst(rst),
    .din_req_28(din_req_28),
    .din_ack_28(din_ack_28),
    .din_28(din_28),
    .din_req_29(din_req_29),
    .din_ack_29(din_ack_29),
    .din_29(din_29),
    .din_req_30(din_req_30),
    .din_ack_30(din_ack_30),
    .din_30(din_30),
    .din_req_31(din_req_31),
    .din_ack_31(din_ack_31),
    .din_31(din_31),
    .din_req_32(din_req_32),
    .din_ack_32(din_ack_32),
    .din_32(din_32),
    .din_req_33(din_req_33),
    .din_ack_33(din_ack_33),
    .din_33(din_33),
    .din_req_34(din_req_34),
    .din_ack_34(din_ack_34),
    .din_34(din_34),
    .din_req_35(din_req_35),
    .din_ack_35(din_ack_35),
    .din_35(din_35),
    .dout_req_36(dout_req_36),
    .dout_ack_36(dout_ack_36),
    .dout_36(dout_36),
    .dout_req_37(dout_req_37),
    .dout_ack_37(dout_ack_37),
    .dout_37(dout_37)
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



module arf #
(
  parameter data_width = 32
)
(
  input clk,
  input rst,
  output din_req_28,
  input din_ack_28,
  input [data_width-1:0] din_28,
  output din_req_29,
  input din_ack_29,
  input [data_width-1:0] din_29,
  output din_req_30,
  input din_ack_30,
  input [data_width-1:0] din_30,
  output din_req_31,
  input din_ack_31,
  input [data_width-1:0] din_31,
  output din_req_32,
  input din_ack_32,
  input [data_width-1:0] din_32,
  output din_req_33,
  input din_ack_33,
  input [data_width-1:0] din_33,
  output din_req_34,
  input din_ack_34,
  input [data_width-1:0] din_34,
  output din_req_35,
  input din_ack_35,
  input [data_width-1:0] din_35,
  input dout_req_36,
  output dout_ack_36,
  output [data_width-1:0] dout_36,
  input dout_req_37,
  output dout_ack_37,
  output [data_width-1:0] dout_37
);

  wire req_0_8;
  wire ack_0;
  wire [data_width-1:0] d0;
  wire req_1_8;
  wire ack_1;
  wire [data_width-1:0] d1;
  wire req_2_9;
  wire ack_2;
  wire [data_width-1:0] d2;
  wire req_3_9;
  wire ack_3;
  wire [data_width-1:0] d3;
  wire req_4_10;
  wire ack_4;
  wire [data_width-1:0] d4;
  wire req_5_10;
  wire ack_5;
  wire [data_width-1:0] d5;
  wire req_6_11;
  wire ack_6;
  wire [data_width-1:0] d6;
  wire req_7_11;
  wire ack_7;
  wire [data_width-1:0] d7;
  wire req_8_26;
  wire ack_8;
  wire [data_width-1:0] d8;
  wire req_9_12;
  wire ack_9;
  wire [data_width-1:0] d9;
  wire req_10_13;
  wire ack_10;
  wire [data_width-1:0] d10;
  wire req_11_27;
  wire ack_11;
  wire [data_width-1:0] d11;
  wire req_12_14;
  wire req_12_16;
  wire ack_12;
  wire [data_width-1:0] d12;
  wire req_13_15;
  wire req_13_13_17_0;
  wire ack_13;
  wire [data_width-1:0] d13;
  wire req_14_18;
  wire ack_14;
  wire [data_width-1:0] d14;
  wire req_15_18;
  wire ack_15;
  wire [data_width-1:0] d15;
  wire req_16_16_19_0;
  wire ack_16;
  wire [data_width-1:0] d16;
  wire req_17_19;
  wire ack_17;
  wire [data_width-1:0] d17;
  wire req_18_20;
  wire req_18_18_22_0;
  wire ack_18;
  wire [data_width-1:0] d18;
  wire req_19_21;
  wire req_19_23;
  wire ack_19;
  wire [data_width-1:0] d19;
  wire req_20_20_24_0;
  wire ack_20;
  wire [data_width-1:0] d20;
  wire req_21_24;
  wire ack_21;
  wire [data_width-1:0] d21;
  wire req_22_25;
  wire ack_22;
  wire [data_width-1:0] d22;
  wire req_23_25;
  wire ack_23;
  wire [data_width-1:0] d23;
  wire req_24_26;
  wire ack_24;
  wire [data_width-1:0] d24;
  wire req_25_27;
  wire ack_25;
  wire [data_width-1:0] d25;
  wire req_26_36;
  wire ack_26;
  wire [data_width-1:0] d26;
  wire req_27_37;
  wire ack_27;
  wire [data_width-1:0] d27;
  wire req_28_0;
  wire ack_28;
  wire [data_width-1:0] d28;
  wire req_29_1;
  wire ack_29;
  wire [data_width-1:0] d29;
  wire req_30_2;
  wire ack_30;
  wire [data_width-1:0] d30;
  wire req_31_3;
  wire ack_31;
  wire [data_width-1:0] d31;
  wire req_32_4;
  wire ack_32;
  wire [data_width-1:0] d32;
  wire req_33_5;
  wire ack_33;
  wire [data_width-1:0] d33;
  wire req_34_6;
  wire ack_34;
  wire [data_width-1:0] d34;
  wire req_35_7;
  wire ack_35;
  wire [data_width-1:0] d35;
  wire req_13_17_0_17;
  wire ack_13_17_0;
  wire [data_width-1:0] d13_17_0;
  wire req_16_19_0_19;
  wire ack_16_19_0;
  wire [data_width-1:0] d16_19_0;
  wire req_18_22_0_22;
  wire ack_18_22_0;
  wire [data_width-1:0] d18_22_0;
  wire req_20_24_0_24;
  wire ack_20_24_0;
  wire [data_width-1:0] d20_24_0;

  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_28_0}),
    .ack_l({ack_28}),
    .req_r({req_0_8}),
    .ack_r(ack_0),
    .din({d28}),
    .dout(d0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_1
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_29_1}),
    .ack_l({ack_29}),
    .req_r({req_1_8}),
    .ack_r(ack_1),
    .din({d29}),
    .dout(d1)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_2
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_30_2}),
    .ack_l({ack_30}),
    .req_r({req_2_9}),
    .ack_r(ack_2),
    .din({d30}),
    .dout(d2)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_3
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_31_3}),
    .ack_l({ack_31}),
    .req_r({req_3_9}),
    .ack_r(ack_3),
    .din({d31}),
    .dout(d3)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_4
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_32_4}),
    .ack_l({ack_32}),
    .req_r({req_4_10}),
    .ack_r(ack_4),
    .din({d32}),
    .dout(d4)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_5
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_33_5}),
    .ack_l({ack_33}),
    .req_r({req_5_10}),
    .ack_r(ack_5),
    .din({d33}),
    .dout(d5)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_6
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_34_6}),
    .ack_l({ack_34}),
    .req_r({req_6_11}),
    .ack_r(ack_6),
    .din({d34}),
    .dout(d6)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_7
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_35_7}),
    .ack_l({ack_35}),
    .req_r({req_7_11}),
    .ack_r(ack_7),
    .din({d35}),
    .dout(d7)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_8
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_1_8, req_0_8}),
    .ack_l({ack_1, ack_0}),
    .req_r({req_8_26}),
    .ack_r(ack_8),
    .din({d1, d0}),
    .dout(d8)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_9
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_3_9, req_2_9}),
    .ack_l({ack_3, ack_2}),
    .req_r({req_9_12}),
    .ack_r(ack_9),
    .din({d3, d2}),
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
    .req_l({req_5_10, req_4_10}),
    .ack_l({ack_5, ack_4}),
    .req_r({req_10_13}),
    .ack_r(ack_10),
    .din({d5, d4}),
    .dout(d10)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_11
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_7_11, req_6_11}),
    .ack_l({ack_7, ack_6}),
    .req_r({req_11_27}),
    .ack_r(ack_11),
    .din({d7, d6}),
    .dout(d11)
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
    .req_l({req_9_12}),
    .ack_l({ack_9}),
    .req_r({req_12_14, req_12_16}),
    .ack_r(ack_12),
    .din({d9}),
    .dout(d12)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  addi_13
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_10_13}),
    .ack_l({ack_10}),
    .req_r({req_13_15, req_13_13_17_0}),
    .ack_r(ack_13),
    .din({d10}),
    .dout(d13)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_14
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_12_14}),
    .ack_l({ack_12}),
    .req_r({req_14_18}),
    .ack_r(ack_14),
    .din({d12}),
    .dout(d14)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_15
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_13_15}),
    .ack_l({ack_13}),
    .req_r({req_15_18}),
    .ack_r(ack_15),
    .din({d13}),
    .dout(d15)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_16
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_12_16}),
    .ack_l({ack_12}),
    .req_r({req_16_16_19_0}),
    .ack_r(ack_16),
    .din({d12}),
    .dout(d16)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_17
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_13_17_0_17}),
    .ack_l({ack_13_17_0}),
    .req_r({req_17_19}),
    .ack_r(ack_17),
    .din({d13_17_0}),
    .dout(d17)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(2)
  )
  add_18
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_15_18, req_14_18}),
    .ack_l({ack_15, ack_14}),
    .req_r({req_18_20, req_18_18_22_0}),
    .ack_r(ack_18),
    .din({d15, d14}),
    .dout(d18)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(2)
  )
  add_19
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_17_19, req_16_19_0_19}),
    .ack_l({ack_17, ack_16_19_0}),
    .req_r({req_19_21, req_19_23}),
    .ack_r(ack_19),
    .din({d17, d16_19_0}),
    .dout(d19)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_20
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_18_20}),
    .ack_l({ack_18}),
    .req_r({req_20_20_24_0}),
    .ack_r(ack_20),
    .din({d18}),
    .dout(d20)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_21
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_19_21}),
    .ack_l({ack_19}),
    .req_r({req_21_24}),
    .ack_r(ack_21),
    .din({d19}),
    .dout(d21)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_22
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_18_22_0_22}),
    .ack_l({ack_18_22_0}),
    .req_r({req_22_25}),
    .ack_r(ack_22),
    .din({d18_22_0}),
    .dout(d22)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_23
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_19_23}),
    .ack_l({ack_19}),
    .req_r({req_23_25}),
    .ack_r(ack_23),
    .din({d19}),
    .dout(d23)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_24
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_21_24, req_20_24_0_24}),
    .ack_l({ack_21, ack_20_24_0}),
    .req_r({req_24_26}),
    .ack_r(ack_24),
    .din({d21, d20_24_0}),
    .dout(d24)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_25
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_23_25, req_22_25}),
    .ack_l({ack_23, ack_22}),
    .req_r({req_25_27}),
    .ack_r(ack_25),
    .din({d23, d22}),
    .dout(d25)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_26
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_24_26, req_8_26}),
    .ack_l({ack_24, ack_8}),
    .req_r({req_26_36}),
    .ack_r(ack_26),
    .din({d24, d8}),
    .dout(d26)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_27
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_25_27, req_11_27}),
    .ack_l({ack_25, ack_11}),
    .req_r({req_27_37}),
    .ack_r(ack_27),
    .din({d25, d11}),
    .dout(d27)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_28
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_28),
    .ack_l(din_ack_28),
    .req_r({req_28_0}),
    .ack_r(ack_28),
    .din(din_28),
    .dout(d28)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_29
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_29),
    .ack_l(din_ack_29),
    .req_r({req_29_1}),
    .ack_r(ack_29),
    .din(din_29),
    .dout(d29)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_30
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_30),
    .ack_l(din_ack_30),
    .req_r({req_30_2}),
    .ack_r(ack_30),
    .din(din_30),
    .dout(d30)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_31
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_31),
    .ack_l(din_ack_31),
    .req_r({req_31_3}),
    .ack_r(ack_31),
    .din(din_31),
    .dout(d31)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_32
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_32),
    .ack_l(din_ack_32),
    .req_r({req_32_4}),
    .ack_r(ack_32),
    .din(din_32),
    .dout(d32)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_33
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_33),
    .ack_l(din_ack_33),
    .req_r({req_33_5}),
    .ack_r(ack_33),
    .din(din_33),
    .dout(d33)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_34
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_34),
    .ack_l(din_ack_34),
    .req_r({req_34_6}),
    .ack_r(ack_34),
    .din(din_34),
    .dout(d34)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_35
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_35),
    .ack_l(din_ack_35),
    .req_r({req_35_7}),
    .ack_r(ack_35),
    .din(din_35),
    .dout(d35)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_36
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_26_36),
    .ack_l(ack_26),
    .req_r(dout_req_36),
    .ack_r(dout_ack_36),
    .din(d26),
    .dout(dout_36)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_37
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_27_37),
    .ack_l(ack_27),
    .req_r(dout_req_37),
    .ack_r(dout_ack_37),
    .din(d27),
    .dout(dout_37)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_13_17_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_13_13_17_0}),
    .ack_l({ack_13}),
    .req_r({req_13_17_0_17}),
    .ack_r(ack_13_17_0),
    .din({d13}),
    .dout(d13_17_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_16_19_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_16_16_19_0}),
    .ack_l({ack_16}),
    .req_r({req_16_19_0_19}),
    .ack_r(ack_16_19_0),
    .din({d16}),
    .dout(d16_19_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_18_22_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_18_18_22_0}),
    .ack_l({ack_18}),
    .req_r({req_18_22_0_22}),
    .ack_r(ack_18_22_0),
    .din({d18}),
    .dout(d18_22_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_20_24_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_20_20_24_0}),
    .ack_l({ack_20}),
    .req_r({req_20_24_0_24}),
    .ack_r(ack_20_24_0),
    .din({d20}),
    .dout(d20_24_0)
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

