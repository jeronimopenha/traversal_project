

module bench_test_bench_assincrono_ewf
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
  wire din_req_40;
  wire din_ack_40;
  wire [data_width-1:0] din_40;
  wire din_req_41;
  wire din_ack_41;
  wire [data_width-1:0] din_41;
  wire dout_req_42;
  wire dout_ack_42;
  wire [data_width-1:0] dout_42;
  wire dout_req_43;
  wire dout_ack_43;
  wire [data_width-1:0] dout_43;
  wire dout_req_44;
  wire dout_ack_44;
  wire [data_width-1:0] dout_44;
  wire dout_req_45;
  wire dout_ack_45;
  wire [data_width-1:0] dout_45;
  wire dout_req_46;
  wire dout_ack_46;
  wire [data_width-1:0] dout_46;
  wire [32-1:0] count_producer [0:2-1];
  wire [32-1:0] count_consumer [0:5-1];
  real count_clock;

  wire [5-1:0] consumers_done;
  wire done;
  assign consumers_done[0] = count_consumer[0] >= max_data_size;
  assign consumers_done[1] = count_consumer[1] >= max_data_size;
  assign consumers_done[2] = count_consumer[2] >= max_data_size;
  assign consumers_done[3] = count_consumer[3] >= max_data_size;
  assign consumers_done[4] = count_consumer[4] >= max_data_size;
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
      $display("bench_test_bench_assincrono_ewf throughput: %5.2f%%", (100.0 * (count_consumer[0] / (count_clock / 4.0))));
      $finish;
    end 
  end


  producer
  #(
    .producer_id(40),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_40
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_40),
    .ack(din_ack_40),
    .dout(din_40),
    .count(count_producer[0])
  );


  producer
  #(
    .producer_id(41),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_41
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_41),
    .ack(din_ack_41),
    .dout(din_41),
    .count(count_producer[1])
  );


  consumer
  #(
    .consumer_id(42),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_42
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_42),
    .ack(dout_ack_42),
    .din(dout_42),
    .count(count_consumer[0])
  );


  consumer
  #(
    .consumer_id(43),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_43
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_43),
    .ack(dout_ack_43),
    .din(dout_43),
    .count(count_consumer[1])
  );


  consumer
  #(
    .consumer_id(44),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_44
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_44),
    .ack(dout_ack_44),
    .din(dout_44),
    .count(count_consumer[2])
  );


  consumer
  #(
    .consumer_id(45),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_45
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_45),
    .ack(dout_ack_45),
    .din(dout_45),
    .count(count_consumer[3])
  );


  consumer
  #(
    .consumer_id(46),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_46
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_46),
    .ack(dout_ack_46),
    .din(dout_46),
    .count(count_consumer[4])
  );


  ewf
  #(
    .data_width(data_width)
  )
  ewf
  (
    .clk(clk),
    .rst(rst),
    .din_req_40(din_req_40),
    .din_ack_40(din_ack_40),
    .din_40(din_40),
    .din_req_41(din_req_41),
    .din_ack_41(din_ack_41),
    .din_41(din_41),
    .dout_req_42(dout_req_42),
    .dout_ack_42(dout_ack_42),
    .dout_42(dout_42),
    .dout_req_43(dout_req_43),
    .dout_ack_43(dout_ack_43),
    .dout_43(dout_43),
    .dout_req_44(dout_req_44),
    .dout_ack_44(dout_ack_44),
    .dout_44(dout_44),
    .dout_req_45(dout_req_45),
    .dout_ack_45(dout_ack_45),
    .dout_45(dout_45),
    .dout_req_46(dout_req_46),
    .dout_ack_46(dout_ack_46),
    .dout_46(dout_46)
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



module ewf #
(
  parameter data_width = 32
)
(
  input clk,
  input rst,
  output din_req_40,
  input din_ack_40,
  input [data_width-1:0] din_40,
  output din_req_41,
  input din_ack_41,
  input [data_width-1:0] din_41,
  input dout_req_42,
  output dout_ack_42,
  output [data_width-1:0] dout_42,
  input dout_req_43,
  output dout_ack_43,
  output [data_width-1:0] dout_43,
  input dout_req_44,
  output dout_ack_44,
  output [data_width-1:0] dout_44,
  input dout_req_45,
  output dout_ack_45,
  output [data_width-1:0] dout_45,
  input dout_req_46,
  output dout_ack_46,
  output [data_width-1:0] dout_46
);

  wire req_0_2;
  wire req_0_15;
  wire req_0_17;
  wire ack_0;
  wire [data_width-1:0] d0;
  wire req_1_8;
  wire req_1_11;
  wire req_1_1_4_0;
  wire ack_1;
  wire [data_width-1:0] d1;
  wire req_2_3;
  wire req_2_7;
  wire req_2_9;
  wire ack_2;
  wire [data_width-1:0] d2;
  wire req_3_4;
  wire ack_3;
  wire [data_width-1:0] d3;
  wire req_4_5;
  wire req_4_10;
  wire req_4_4_6_0;
  wire ack_4;
  wire [data_width-1:0] d4;
  wire req_5_7;
  wire ack_5;
  wire [data_width-1:0] d5;
  wire req_6_8;
  wire ack_6;
  wire [data_width-1:0] d6;
  wire req_7_9;
  wire req_7_10;
  wire req_7_18;
  wire ack_7;
  wire [data_width-1:0] d7;
  wire req_8_11;
  wire req_8_13;
  wire req_8_19;
  wire ack_8;
  wire [data_width-1:0] d8;
  wire req_9_12;
  wire ack_9;
  wire [data_width-1:0] d9;
  wire req_10_10_13_0;
  wire ack_10;
  wire [data_width-1:0] d10;
  wire req_11_14;
  wire ack_11;
  wire [data_width-1:0] d11;
  wire req_12_15;
  wire ack_12;
  wire [data_width-1:0] d12;
  wire req_13_44;
  wire ack_13;
  wire [data_width-1:0] d13;
  wire req_14_16;
  wire ack_14;
  wire [data_width-1:0] d14;
  wire req_15_17;
  wire req_15_29;
  wire req_15_15_18_0;
  wire ack_15;
  wire [data_width-1:0] d15;
  wire req_16_19;
  wire req_16_28;
  wire req_16_16_20_0;
  wire ack_16;
  wire [data_width-1:0] d16;
  wire req_17_21;
  wire ack_17;
  wire [data_width-1:0] d17;
  wire req_18_22;
  wire ack_18;
  wire [data_width-1:0] d18;
  wire req_19_19_23_0;
  wire ack_19;
  wire [data_width-1:0] d19;
  wire req_20_24;
  wire ack_20;
  wire [data_width-1:0] d20;
  wire req_21_25;
  wire ack_21;
  wire [data_width-1:0] d21;
  wire req_22_26;
  wire req_22_32;
  wire ack_22;
  wire [data_width-1:0] d22;
  wire req_23_27;
  wire req_23_33;
  wire ack_23;
  wire [data_width-1:0] d23;
  wire req_24_28;
  wire ack_24;
  wire [data_width-1:0] d24;
  wire req_25_29;
  wire ack_25;
  wire [data_width-1:0] d25;
  wire req_26_30;
  wire ack_26;
  wire [data_width-1:0] d26;
  wire req_27_31;
  wire ack_27;
  wire [data_width-1:0] d27;
  wire req_28_42;
  wire ack_28;
  wire [data_width-1:0] d28;
  wire req_29_46;
  wire ack_29;
  wire [data_width-1:0] d29;
  wire req_30_32;
  wire ack_30;
  wire [data_width-1:0] d30;
  wire req_31_33;
  wire ack_31;
  wire [data_width-1:0] d31;
  wire req_32_45;
  wire ack_32;
  wire [data_width-1:0] d32;
  wire req_33_43;
  wire ack_33;
  wire [data_width-1:0] d33;
  wire req_40_0;
  wire ack_40;
  wire [data_width-1:0] d40;
  wire req_41_1;
  wire ack_41;
  wire [data_width-1:0] d41;
  wire req_1_4_0_4;
  wire ack_1_4_0;
  wire [data_width-1:0] d1_4_0;
  wire req_4_6_0_6;
  wire ack_4_6_0;
  wire [data_width-1:0] d4_6_0;
  wire req_10_13_0_13;
  wire ack_10_13_0;
  wire [data_width-1:0] d10_13_0;
  wire req_15_18_0_18;
  wire ack_15_18_0;
  wire [data_width-1:0] d15_18_0;
  wire req_16_20_0_20;
  wire ack_16_20_0;
  wire [data_width-1:0] d16_20_0;
  wire req_19_23_0_23;
  wire ack_19_23_0;
  wire [data_width-1:0] d19_23_0;

  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(3)
  )
  addi_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_40_0}),
    .ack_l({ack_40}),
    .req_r({req_0_2, req_0_15, req_0_17}),
    .ack_r(ack_0),
    .din({d40}),
    .dout(d0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(3)
  )
  addi_1
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_41_1}),
    .ack_l({ack_41}),
    .req_r({req_1_8, req_1_11, req_1_1_4_0}),
    .ack_r(ack_1),
    .din({d41}),
    .dout(d1)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(3)
  )
  addi_2
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_0_2}),
    .ack_l({ack_0}),
    .req_r({req_2_3, req_2_7, req_2_9}),
    .ack_r(ack_2),
    .din({d0}),
    .dout(d2)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  addi_3
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_2_3}),
    .ack_l({ack_2}),
    .req_r({req_3_4}),
    .ack_r(ack_3),
    .din({d2}),
    .dout(d3)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(3)
  )
  add_4
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_3_4, req_1_4_0_4}),
    .ack_l({ack_3, ack_1_4_0}),
    .req_r({req_4_5, req_4_10, req_4_4_6_0}),
    .ack_r(ack_4),
    .din({d3, d1_4_0}),
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
    .req_l({req_4_5}),
    .ack_l({ack_4}),
    .req_r({req_5_7}),
    .ack_r(ack_5),
    .din({d4}),
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
    .req_l({req_4_6_0_6}),
    .ack_l({ack_4_6_0}),
    .req_r({req_6_8}),
    .ack_r(ack_6),
    .din({d4_6_0}),
    .dout(d6)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(3)
  )
  add_7
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_5_7, req_2_7}),
    .ack_l({ack_5, ack_2}),
    .req_r({req_7_9, req_7_10, req_7_18}),
    .ack_r(ack_7),
    .din({d5, d2}),
    .dout(d7)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(3)
  )
  add_8
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_6_8, req_1_8}),
    .ack_l({ack_6, ack_1}),
    .req_r({req_8_11, req_8_13, req_8_19}),
    .ack_r(ack_8),
    .din({d6, d1}),
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
    .req_l({req_7_9, req_2_9}),
    .ack_l({ack_7, ack_2}),
    .req_r({req_9_12}),
    .ack_r(ack_9),
    .din({d7, d2}),
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
    .req_l({req_7_10, req_4_10}),
    .ack_l({ack_7, ack_4}),
    .req_r({req_10_10_13_0}),
    .ack_r(ack_10),
    .din({d7, d4}),
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
    .req_l({req_8_11, req_1_11}),
    .ack_l({ack_8, ack_1}),
    .req_r({req_11_14}),
    .ack_r(ack_11),
    .din({d8, d1}),
    .dout(d11)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_12
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_9_12}),
    .ack_l({ack_9}),
    .req_r({req_12_15}),
    .ack_r(ack_12),
    .din({d9}),
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
    .req_l({req_10_13_0_13, req_8_13}),
    .ack_l({ack_10_13_0, ack_8}),
    .req_r({req_13_44}),
    .ack_r(ack_13),
    .din({d10_13_0, d8}),
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
    .req_l({req_11_14}),
    .ack_l({ack_11}),
    .req_r({req_14_16}),
    .ack_r(ack_14),
    .din({d11}),
    .dout(d14)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(3)
  )
  add_15
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_12_15, req_0_15}),
    .ack_l({ack_12, ack_0}),
    .req_r({req_15_17, req_15_29, req_15_15_18_0}),
    .ack_r(ack_15),
    .din({d12, d0}),
    .dout(d15)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(3)
  )
  addi_16
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_14_16}),
    .ack_l({ack_14}),
    .req_r({req_16_19, req_16_28, req_16_16_20_0}),
    .ack_r(ack_16),
    .din({d14}),
    .dout(d16)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_17
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_15_17, req_0_17}),
    .ack_l({ack_15, ack_0}),
    .req_r({req_17_21}),
    .ack_r(ack_17),
    .din({d15, d0}),
    .dout(d17)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_18
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_15_18_0_18, req_7_18}),
    .ack_l({ack_15_18_0, ack_7}),
    .req_r({req_18_22}),
    .ack_r(ack_18),
    .din({d15_18_0, d7}),
    .dout(d18)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_19
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_16_19, req_8_19}),
    .ack_l({ack_16, ack_8}),
    .req_r({req_19_19_23_0}),
    .ack_r(ack_19),
    .din({d16, d8}),
    .dout(d19)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  addi_20
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_16_20_0_20}),
    .ack_l({ack_16_20_0}),
    .req_r({req_20_24}),
    .ack_r(ack_20),
    .din({d16_20_0}),
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
    .req_l({req_17_21}),
    .ack_l({ack_17}),
    .req_r({req_21_25}),
    .ack_r(ack_21),
    .din({d17}),
    .dout(d21)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  addi_22
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_18_22}),
    .ack_l({ack_18}),
    .req_r({req_22_26, req_22_32}),
    .ack_r(ack_22),
    .din({d18}),
    .dout(d22)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  addi_23
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_19_23_0_23}),
    .ack_l({ack_19_23_0}),
    .req_r({req_23_27, req_23_33}),
    .ack_r(ack_23),
    .din({d19_23_0}),
    .dout(d23)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_24
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_20_24}),
    .ack_l({ack_20}),
    .req_r({req_24_28}),
    .ack_r(ack_24),
    .din({d20}),
    .dout(d24)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  addi_25
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_21_25}),
    .ack_l({ack_21}),
    .req_r({req_25_29}),
    .ack_r(ack_25),
    .din({d21}),
    .dout(d25)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_26
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_22_26}),
    .ack_l({ack_22}),
    .req_r({req_26_30}),
    .ack_r(ack_26),
    .din({d22}),
    .dout(d26)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_27
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_23_27}),
    .ack_l({ack_23}),
    .req_r({req_27_31}),
    .ack_r(ack_27),
    .din({d23}),
    .dout(d27)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_28
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_24_28, req_16_28}),
    .ack_l({ack_24, ack_16}),
    .req_r({req_28_42}),
    .ack_r(ack_28),
    .din({d24, d16}),
    .dout(d28)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_29
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_25_29, req_15_29}),
    .ack_l({ack_25, ack_15}),
    .req_r({req_29_46}),
    .ack_r(ack_29),
    .din({d25, d15}),
    .dout(d29)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  addi_30
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_26_30}),
    .ack_l({ack_26}),
    .req_r({req_30_32}),
    .ack_r(ack_30),
    .din({d26}),
    .dout(d30)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  addi_31
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_27_31}),
    .ack_l({ack_27}),
    .req_r({req_31_33}),
    .ack_r(ack_31),
    .din({d27}),
    .dout(d31)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_32
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_30_32, req_22_32}),
    .ack_l({ack_30, ack_22}),
    .req_r({req_32_45}),
    .ack_r(ack_32),
    .din({d30, d22}),
    .dout(d32)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_33
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_31_33, req_23_33}),
    .ack_l({ack_31, ack_23}),
    .req_r({req_33_43}),
    .ack_r(ack_33),
    .din({d31, d23}),
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
  in_40
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_40),
    .ack_l(din_ack_40),
    .req_r({req_40_0}),
    .ack_r(ack_40),
    .din(din_40),
    .dout(d40)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_41
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_41),
    .ack_l(din_ack_41),
    .req_r({req_41_1}),
    .ack_r(ack_41),
    .din(din_41),
    .dout(d41)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_42
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_28_42),
    .ack_l(ack_28),
    .req_r(dout_req_42),
    .ack_r(dout_ack_42),
    .din(d28),
    .dout(dout_42)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_43
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_33_43),
    .ack_l(ack_33),
    .req_r(dout_req_43),
    .ack_r(dout_ack_43),
    .din(d33),
    .dout(dout_43)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_44
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_13_44),
    .ack_l(ack_13),
    .req_r(dout_req_44),
    .ack_r(dout_ack_44),
    .din(d13),
    .dout(dout_44)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_45
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_32_45),
    .ack_l(ack_32),
    .req_r(dout_req_45),
    .ack_r(dout_ack_45),
    .din(d32),
    .dout(dout_45)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_46
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_29_46),
    .ack_l(ack_29),
    .req_r(dout_req_46),
    .ack_r(dout_ack_46),
    .din(d29),
    .dout(dout_46)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_1_4_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_1_1_4_0}),
    .ack_l({ack_1}),
    .req_r({req_1_4_0_4}),
    .ack_r(ack_1_4_0),
    .din({d1}),
    .dout(d1_4_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_4_6_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_4_4_6_0}),
    .ack_l({ack_4}),
    .req_r({req_4_6_0_6}),
    .ack_r(ack_4_6_0),
    .din({d4}),
    .dout(d4_6_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_10_13_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_10_10_13_0}),
    .ack_l({ack_10}),
    .req_r({req_10_13_0_13}),
    .ack_r(ack_10_13_0),
    .din({d10}),
    .dout(d10_13_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_15_18_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_15_15_18_0}),
    .ack_l({ack_15}),
    .req_r({req_15_18_0_18}),
    .ack_r(ack_15_18_0),
    .din({d15}),
    .dout(d15_18_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_16_20_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_16_16_20_0}),
    .ack_l({ack_16}),
    .req_r({req_16_20_0_20}),
    .ack_r(ack_16_20_0),
    .din({d16}),
    .dout(d16_20_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_19_23_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_19_19_23_0}),
    .ack_l({ack_19}),
    .req_r({req_19_23_0_23}),
    .ack_r(ack_19_23_0),
    .din({d19}),
    .dout(d19_23_0)
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

