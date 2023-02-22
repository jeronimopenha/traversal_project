

module bench_test_bench_sincrono_h2v2_smooth
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
  wire din_req_2;
  wire din_ack_2;
  wire [data_width-1:0] din_2;
  wire din_req_18;
  wire din_ack_18;
  wire [data_width-1:0] din_18;
  wire din_req_23;
  wire din_ack_23;
  wire [data_width-1:0] din_23;
  wire dout_req_49;
  wire dout_ack_49;
  wire [data_width-1:0] dout_49;
  wire din_req_52;
  wire din_ack_52;
  wire [data_width-1:0] din_52;
  wire din_req_53;
  wire din_ack_53;
  wire [data_width-1:0] din_53;
  wire din_req_54;
  wire din_ack_54;
  wire [data_width-1:0] din_54;
  wire din_req_55;
  wire din_ack_55;
  wire [data_width-1:0] din_55;
  wire din_req_56;
  wire din_ack_56;
  wire [data_width-1:0] din_56;
  wire din_req_57;
  wire din_ack_57;
  wire [data_width-1:0] din_57;
  wire din_req_58;
  wire din_ack_58;
  wire [data_width-1:0] din_58;
  wire din_req_59;
  wire din_ack_59;
  wire [data_width-1:0] din_59;
  wire din_req_60;
  wire din_ack_60;
  wire [data_width-1:0] din_60;
  wire din_req_61;
  wire din_ack_61;
  wire [data_width-1:0] din_61;
  wire din_req_62;
  wire din_ack_62;
  wire [data_width-1:0] din_62;
  wire din_req_63;
  wire din_ack_63;
  wire [data_width-1:0] din_63;
  wire [32-1:0] count_producer [0:16-1];
  wire [32-1:0] count_consumer [0:1-1];
  real count_clock;

  wire [1-1:0] consumers_done;
  wire done;
  assign consumers_done[0] = count_consumer[0] >= max_data_size;
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


  initial begin
    $dumpfile("uut.vcd");
    $dumpvars(0);
  end


  always @(posedge clk) begin
    if(rst) begin
      count_clock <= 0;
    end 
    count_clock <= count_clock + 1;
    if(done) begin
      $display("bench_test_bench_sincrono_h2v2_smooth throughput: %5.2f%%", (100.0 * (count_consumer[0] / (count_clock / 4.0))));
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
    .producer_id(2),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_2
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_2),
    .ack(din_ack_2),
    .dout(din_2),
    .count(count_producer[1])
  );


  producer
  #(
    .producer_id(18),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_18
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_18),
    .ack(din_ack_18),
    .dout(din_18),
    .count(count_producer[2])
  );


  producer
  #(
    .producer_id(23),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_23
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_23),
    .ack(din_ack_23),
    .dout(din_23),
    .count(count_producer[3])
  );


  consumer
  #(
    .consumer_id(49),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_49
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_49),
    .ack(dout_ack_49),
    .din(dout_49),
    .count(count_consumer[0])
  );


  producer
  #(
    .producer_id(52),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_52
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_52),
    .ack(din_ack_52),
    .dout(din_52),
    .count(count_producer[4])
  );


  producer
  #(
    .producer_id(53),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_53
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_53),
    .ack(din_ack_53),
    .dout(din_53),
    .count(count_producer[5])
  );


  producer
  #(
    .producer_id(54),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_54
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_54),
    .ack(din_ack_54),
    .dout(din_54),
    .count(count_producer[6])
  );


  producer
  #(
    .producer_id(55),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_55
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_55),
    .ack(din_ack_55),
    .dout(din_55),
    .count(count_producer[7])
  );


  producer
  #(
    .producer_id(56),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_56
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_56),
    .ack(din_ack_56),
    .dout(din_56),
    .count(count_producer[8])
  );


  producer
  #(
    .producer_id(57),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_57
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_57),
    .ack(din_ack_57),
    .dout(din_57),
    .count(count_producer[9])
  );


  producer
  #(
    .producer_id(58),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_58
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_58),
    .ack(din_ack_58),
    .dout(din_58),
    .count(count_producer[10])
  );


  producer
  #(
    .producer_id(59),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_59
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_59),
    .ack(din_ack_59),
    .dout(din_59),
    .count(count_producer[11])
  );


  producer
  #(
    .producer_id(60),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_60
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_60),
    .ack(din_ack_60),
    .dout(din_60),
    .count(count_producer[12])
  );


  producer
  #(
    .producer_id(61),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_61
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_61),
    .ack(din_ack_61),
    .dout(din_61),
    .count(count_producer[13])
  );


  producer
  #(
    .producer_id(62),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_62
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_62),
    .ack(din_ack_62),
    .dout(din_62),
    .count(count_producer[14])
  );


  producer
  #(
    .producer_id(63),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_63
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_63),
    .ack(din_ack_63),
    .dout(din_63),
    .count(count_producer[15])
  );


  h2v2_smooth
  #(
    .data_width(data_width)
  )
  h2v2_smooth
  (
    .clk(clk),
    .rst(rst),
    .din_req_1(din_req_1),
    .din_ack_1(din_ack_1),
    .din_1(din_1),
    .din_req_2(din_req_2),
    .din_ack_2(din_ack_2),
    .din_2(din_2),
    .din_req_18(din_req_18),
    .din_ack_18(din_ack_18),
    .din_18(din_18),
    .din_req_23(din_req_23),
    .din_ack_23(din_ack_23),
    .din_23(din_23),
    .dout_req_49(dout_req_49),
    .dout_ack_49(dout_ack_49),
    .dout_49(dout_49),
    .din_req_52(din_req_52),
    .din_ack_52(din_ack_52),
    .din_52(din_52),
    .din_req_53(din_req_53),
    .din_ack_53(din_ack_53),
    .din_53(din_53),
    .din_req_54(din_req_54),
    .din_ack_54(din_ack_54),
    .din_54(din_54),
    .din_req_55(din_req_55),
    .din_ack_55(din_ack_55),
    .din_55(din_55),
    .din_req_56(din_req_56),
    .din_ack_56(din_ack_56),
    .din_56(din_56),
    .din_req_57(din_req_57),
    .din_ack_57(din_ack_57),
    .din_57(din_57),
    .din_req_58(din_req_58),
    .din_ack_58(din_ack_58),
    .din_58(din_58),
    .din_req_59(din_req_59),
    .din_ack_59(din_ack_59),
    .din_59(din_59),
    .din_req_60(din_req_60),
    .din_ack_60(din_ack_60),
    .din_60(din_60),
    .din_req_61(din_req_61),
    .din_ack_61(din_ack_61),
    .din_61(din_61),
    .din_req_62(din_req_62),
    .din_ack_62(din_ack_62),
    .din_62(din_62),
    .din_req_63(din_req_63),
    .din_ack_63(din_ack_63),
    .din_63(din_63)
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



module h2v2_smooth #
(
  parameter data_width = 32
)
(
  input clk,
  input rst,
  output din_req_1,
  input din_ack_1,
  input [data_width-1:0] din_1,
  output din_req_2,
  input din_ack_2,
  input [data_width-1:0] din_2,
  output din_req_18,
  input din_ack_18,
  input [data_width-1:0] din_18,
  output din_req_23,
  input din_ack_23,
  input [data_width-1:0] din_23,
  input dout_req_49,
  output dout_ack_49,
  output [data_width-1:0] dout_49,
  output din_req_52,
  input din_ack_52,
  input [data_width-1:0] din_52,
  output din_req_53,
  input din_ack_53,
  input [data_width-1:0] din_53,
  output din_req_54,
  input din_ack_54,
  input [data_width-1:0] din_54,
  output din_req_55,
  input din_ack_55,
  input [data_width-1:0] din_55,
  output din_req_56,
  input din_ack_56,
  input [data_width-1:0] din_56,
  output din_req_57,
  input din_ack_57,
  input [data_width-1:0] din_57,
  output din_req_58,
  input din_ack_58,
  input [data_width-1:0] din_58,
  output din_req_59,
  input din_ack_59,
  input [data_width-1:0] din_59,
  output din_req_60,
  input din_ack_60,
  input [data_width-1:0] din_60,
  output din_req_61,
  input din_ack_61,
  input [data_width-1:0] din_61,
  output din_req_62,
  input din_ack_62,
  input [data_width-1:0] din_62,
  output din_req_63,
  input din_ack_63,
  input [data_width-1:0] din_63
);

  wire req_0_38;
  wire ack_0;
  wire [data_width-1:0] d0;
  wire req_1_43;
  wire ack_1;
  wire [data_width-1:0] d1;
  wire req_2_20;
  wire ack_2;
  wire [data_width-1:0] d2;
  wire req_3_21;
  wire ack_3;
  wire [data_width-1:0] d3;
  wire req_4_35;
  wire ack_4;
  wire [data_width-1:0] d4;
  wire req_5_45;
  wire ack_5;
  wire [data_width-1:0] d5;
  wire req_6_4;
  wire req_6_47;
  wire ack_6;
  wire [data_width-1:0] d6;
  wire req_7_48;
  wire ack_7;
  wire [data_width-1:0] d7;
  wire req_8_33;
  wire ack_8;
  wire [data_width-1:0] d8;
  wire req_9_48;
  wire req_9_51;
  wire ack_9;
  wire [data_width-1:0] d9;
  wire req_10_16;
  wire ack_10;
  wire [data_width-1:0] d10;
  wire req_11_41;
  wire ack_11;
  wire [data_width-1:0] d11;
  wire req_12_5;
  wire ack_12;
  wire [data_width-1:0] d12;
  wire req_13_22;
  wire ack_13;
  wire [data_width-1:0] d13;
  wire req_14_49;
  wire ack_14;
  wire [data_width-1:0] d14;
  wire req_15_9;
  wire req_15_26;
  wire ack_15;
  wire [data_width-1:0] d15;
  wire req_16_6;
  wire ack_16;
  wire [data_width-1:0] d16;
  wire req_17_8;
  wire ack_17;
  wire [data_width-1:0] d17;
  wire req_18_32;
  wire ack_18;
  wire [data_width-1:0] d18;
  wire req_19_30;
  wire ack_19;
  wire [data_width-1:0] d19;
  wire req_20_40;
  wire ack_20;
  wire [data_width-1:0] d20;
  wire req_21_11;
  wire ack_21;
  wire [data_width-1:0] d21;
  wire req_22_37;
  wire ack_22;
  wire [data_width-1:0] d22;
  wire req_23_38;
  wire ack_23;
  wire [data_width-1:0] d23;
  wire req_24_7;
  wire ack_24;
  wire [data_width-1:0] d24;
  wire req_25_46;
  wire ack_25;
  wire [data_width-1:0] d25;
  wire req_26_35;
  wire ack_26;
  wire [data_width-1:0] d26;
  wire req_27_50;
  wire ack_27;
  wire [data_width-1:0] d27;
  wire req_28_40;
  wire ack_28;
  wire [data_width-1:0] d28;
  wire req_29_28;
  wire ack_29;
  wire [data_width-1:0] d29;
  wire req_30_32;
  wire ack_30;
  wire [data_width-1:0] d30;
  wire req_31_27;
  wire ack_31;
  wire [data_width-1:0] d31;
  wire req_32_43;
  wire ack_32;
  wire [data_width-1:0] d32;
  wire req_33_11;
  wire ack_33;
  wire [data_width-1:0] d33;
  wire req_34_24;
  wire ack_34;
  wire [data_width-1:0] d34;
  wire req_35_47;
  wire ack_35;
  wire [data_width-1:0] d35;
  wire req_36_0;
  wire ack_36;
  wire [data_width-1:0] d36;
  wire req_37_24;
  wire ack_37;
  wire [data_width-1:0] d37;
  wire req_38_20;
  wire ack_38;
  wire [data_width-1:0] d38;
  wire req_39_41;
  wire ack_39;
  wire [data_width-1:0] d39;
  wire req_40_50;
  wire ack_40;
  wire [data_width-1:0] d40;
  wire req_41_15;
  wire req_41_51;
  wire ack_41;
  wire [data_width-1:0] d41;
  wire req_42_34;
  wire ack_42;
  wire [data_width-1:0] d42;
  wire req_43_6;
  wire ack_43;
  wire [data_width-1:0] d43;
  wire req_44_39;
  wire ack_44;
  wire [data_width-1:0] d44;
  wire req_45_37;
  wire ack_45;
  wire [data_width-1:0] d45;
  wire req_46_45;
  wire ack_46;
  wire [data_width-1:0] d46;
  wire req_47_14;
  wire ack_47;
  wire [data_width-1:0] d47;
  wire req_48_26;
  wire ack_48;
  wire [data_width-1:0] d48;
  wire req_50_33;
  wire ack_50;
  wire [data_width-1:0] d50;
  wire req_51_7;
  wire ack_51;
  wire [data_width-1:0] d51;
  wire req_52_19;
  wire ack_52;
  wire [data_width-1:0] d52;
  wire req_53_10;
  wire ack_53;
  wire [data_width-1:0] d53;
  wire req_54_44;
  wire ack_54;
  wire [data_width-1:0] d54;
  wire req_55_29;
  wire ack_55;
  wire [data_width-1:0] d55;
  wire req_56_13;
  wire ack_56;
  wire [data_width-1:0] d56;
  wire req_57_12;
  wire ack_57;
  wire [data_width-1:0] d57;
  wire req_58_36;
  wire ack_58;
  wire [data_width-1:0] d58;
  wire req_59_31;
  wire ack_59;
  wire [data_width-1:0] d59;
  wire req_60_17;
  wire ack_60;
  wire [data_width-1:0] d60;
  wire req_61_3;
  wire ack_61;
  wire [data_width-1:0] d61;
  wire req_62_25;
  wire ack_62;
  wire [data_width-1:0] d62;
  wire req_63_42;
  wire ack_63;
  wire [data_width-1:0] d63;

  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_36_0}),
    .ack_l({ack_36}),
    .req_r({req_0_38}),
    .ack_r(ack_0),
    .din({d36}),
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
    .req_r({req_1_43}),
    .ack_r(ack_1),
    .din(din_1),
    .dout(d1)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_2
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_2),
    .ack_l(din_ack_2),
    .req_r({req_2_20}),
    .ack_r(ack_2),
    .din(din_2),
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
    .req_l({req_61_3}),
    .ack_l({ack_61}),
    .req_r({req_3_21}),
    .ack_r(ack_3),
    .din({d61}),
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
    .req_l({req_6_4}),
    .ack_l({ack_6}),
    .req_r({req_4_35}),
    .ack_r(ack_4),
    .din({d6}),
    .dout(d4)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_5
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_12_5}),
    .ack_l({ack_12}),
    .req_r({req_5_45}),
    .ack_r(ack_5),
    .din({d12}),
    .dout(d5)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(2)
  )
  add_6
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_43_6, req_16_6}),
    .ack_l({ack_43, ack_16}),
    .req_r({req_6_4, req_6_47}),
    .ack_r(ack_6),
    .din({d43, d16}),
    .dout(d6)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_7
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_51_7, req_24_7}),
    .ack_l({ack_51, ack_24}),
    .req_r({req_7_48}),
    .ack_r(ack_7),
    .din({d51, d24}),
    .dout(d7)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_8
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_17_8}),
    .ack_l({ack_17}),
    .req_r({req_8_33}),
    .ack_r(ack_8),
    .din({d17}),
    .dout(d8)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  addi_9
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_15_9}),
    .ack_l({ack_15}),
    .req_r({req_9_48, req_9_51}),
    .ack_r(ack_9),
    .din({d15}),
    .dout(d9)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  addi_10
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_53_10}),
    .ack_l({ack_53}),
    .req_r({req_10_16}),
    .ack_r(ack_10),
    .din({d53}),
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
    .req_l({req_33_11, req_21_11}),
    .ack_l({ack_33, ack_21}),
    .req_r({req_11_41}),
    .ack_r(ack_11),
    .din({d33, d21}),
    .dout(d11)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  addi_12
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_57_12}),
    .ack_l({ack_57}),
    .req_r({req_12_5}),
    .ack_r(ack_12),
    .din({d57}),
    .dout(d12)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  addi_13
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_56_13}),
    .ack_l({ack_56}),
    .req_r({req_13_22}),
    .ack_r(ack_13),
    .din({d56}),
    .dout(d13)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_14
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_47_14}),
    .ack_l({ack_47}),
    .req_r({req_14_49}),
    .ack_r(ack_14),
    .din({d47}),
    .dout(d14)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(2)
  )
  reg_15
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_41_15}),
    .ack_l({ack_41}),
    .req_r({req_15_9, req_15_26}),
    .ack_r(ack_15),
    .din({d41}),
    .dout(d15)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_16
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_10_16}),
    .ack_l({ack_10}),
    .req_r({req_16_6}),
    .ack_r(ack_16),
    .din({d10}),
    .dout(d16)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  addi_17
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_60_17}),
    .ack_l({ack_60}),
    .req_r({req_17_8}),
    .ack_r(ack_17),
    .din({d60}),
    .dout(d17)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_18
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_18),
    .ack_l(din_ack_18),
    .req_r({req_18_32}),
    .ack_r(ack_18),
    .din(din_18),
    .dout(d18)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  addi_19
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_52_19}),
    .ack_l({ack_52}),
    .req_r({req_19_30}),
    .ack_r(ack_19),
    .din({d52}),
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
    .req_l({req_38_20, req_2_20}),
    .ack_l({ack_38, ack_2}),
    .req_r({req_20_40}),
    .ack_r(ack_20),
    .din({d38, d2}),
    .dout(d20)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_21
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_3_21}),
    .ack_l({ack_3}),
    .req_r({req_21_11}),
    .ack_r(ack_21),
    .din({d3}),
    .dout(d21)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_22
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_13_22}),
    .ack_l({ack_13}),
    .req_r({req_22_37}),
    .ack_r(ack_22),
    .din({d13}),
    .dout(d22)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_23
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_23),
    .ack_l(din_ack_23),
    .req_r({req_23_38}),
    .ack_r(ack_23),
    .din(din_23),
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
    .req_l({req_37_24, req_34_24}),
    .ack_l({ack_37, ack_34}),
    .req_r({req_24_7}),
    .ack_r(ack_24),
    .din({d37, d34}),
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
    .req_l({req_62_25}),
    .ack_l({ack_62}),
    .req_r({req_25_46}),
    .ack_r(ack_25),
    .din({d62}),
    .dout(d25)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("mul"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  mul_26
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_48_26, req_15_26}),
    .ack_l({ack_48, ack_15}),
    .req_r({req_26_35}),
    .ack_r(ack_26),
    .din({d48, d15}),
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
  reg_27
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_31_27}),
    .ack_l({ack_31}),
    .req_r({req_27_50}),
    .ack_r(ack_27),
    .din({d31}),
    .dout(d27)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_28
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_29_28}),
    .ack_l({ack_29}),
    .req_r({req_28_40}),
    .ack_r(ack_28),
    .din({d29}),
    .dout(d28)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  addi_29
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_55_29}),
    .ack_l({ack_55}),
    .req_r({req_29_28}),
    .ack_r(ack_29),
    .din({d55}),
    .dout(d29)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_30
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_19_30}),
    .ack_l({ack_19}),
    .req_r({req_30_32}),
    .ack_r(ack_30),
    .din({d19}),
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
    .req_l({req_59_31}),
    .ack_l({ack_59}),
    .req_r({req_31_27}),
    .ack_r(ack_31),
    .din({d59}),
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
    .req_l({req_30_32, req_18_32}),
    .ack_l({ack_30, ack_18}),
    .req_r({req_32_43}),
    .ack_r(ack_32),
    .din({d30, d18}),
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
    .req_l({req_50_33, req_8_33}),
    .ack_l({ack_50, ack_8}),
    .req_r({req_33_11}),
    .ack_r(ack_33),
    .din({d50, d8}),
    .dout(d33)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_34
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_42_34}),
    .ack_l({ack_42}),
    .req_r({req_34_24}),
    .ack_r(ack_34),
    .din({d42}),
    .dout(d34)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_35
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_26_35, req_4_35}),
    .ack_l({ack_26, ack_4}),
    .req_r({req_35_47}),
    .ack_r(ack_35),
    .din({d26, d4}),
    .dout(d35)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  addi_36
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_58_36}),
    .ack_l({ack_58}),
    .req_r({req_36_0}),
    .ack_r(ack_36),
    .din({d58}),
    .dout(d36)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_37
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_45_37, req_22_37}),
    .ack_l({ack_45, ack_22}),
    .req_r({req_37_24}),
    .ack_r(ack_37),
    .din({d45, d22}),
    .dout(d37)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_38
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_23_38, req_0_38}),
    .ack_l({ack_23, ack_0}),
    .req_r({req_38_20}),
    .ack_r(ack_38),
    .din({d23, d0}),
    .dout(d38)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_39
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_44_39}),
    .ack_l({ack_44}),
    .req_r({req_39_41}),
    .ack_r(ack_39),
    .din({d44}),
    .dout(d39)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_40
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_28_40, req_20_40}),
    .ack_l({ack_28, ack_20}),
    .req_r({req_40_50}),
    .ack_r(ack_40),
    .din({d28, d20}),
    .dout(d40)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(2)
  )
  add_41
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_39_41, req_11_41}),
    .ack_l({ack_39, ack_11}),
    .req_r({req_41_15, req_41_51}),
    .ack_r(ack_41),
    .din({d39, d11}),
    .dout(d41)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  addi_42
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_63_42}),
    .ack_l({ack_63}),
    .req_r({req_42_34}),
    .ack_r(ack_42),
    .din({d63}),
    .dout(d42)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_43
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_32_43, req_1_43}),
    .ack_l({ack_32, ack_1}),
    .req_r({req_43_6}),
    .ack_r(ack_43),
    .din({d32, d1}),
    .dout(d43)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  addi_44
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_54_44}),
    .ack_l({ack_54}),
    .req_r({req_44_39}),
    .ack_r(ack_44),
    .din({d54}),
    .dout(d44)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_45
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_46_45, req_5_45}),
    .ack_l({ack_46, ack_5}),
    .req_r({req_45_37}),
    .ack_r(ack_45),
    .din({d46, d5}),
    .dout(d45)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_46
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_25_46}),
    .ack_l({ack_25}),
    .req_r({req_46_45}),
    .ack_r(ack_46),
    .din({d25}),
    .dout(d46)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_47
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_35_47, req_6_47}),
    .ack_l({ack_35, ack_6}),
    .req_r({req_47_14}),
    .ack_r(ack_47),
    .din({d35, d6}),
    .dout(d47)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_48
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_9_48, req_7_48}),
    .ack_l({ack_9, ack_7}),
    .req_r({req_48_26}),
    .ack_r(ack_48),
    .din({d9, d7}),
    .dout(d48)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_49
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_14_49),
    .ack_l(ack_14),
    .req_r(dout_req_49),
    .ack_r(dout_ack_49),
    .din(d14),
    .dout(dout_49)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_50
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_40_50, req_27_50}),
    .ack_l({ack_40, ack_27}),
    .req_r({req_50_33}),
    .ack_r(ack_50),
    .din({d40, d27}),
    .dout(d50)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_51
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_41_51, req_9_51}),
    .ack_l({ack_41, ack_9}),
    .req_r({req_51_7}),
    .ack_r(ack_51),
    .din({d41, d9}),
    .dout(d51)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_52
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_52),
    .ack_l(din_ack_52),
    .req_r({req_52_19}),
    .ack_r(ack_52),
    .din(din_52),
    .dout(d52)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_53
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_53),
    .ack_l(din_ack_53),
    .req_r({req_53_10}),
    .ack_r(ack_53),
    .din(din_53),
    .dout(d53)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_54
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_54),
    .ack_l(din_ack_54),
    .req_r({req_54_44}),
    .ack_r(ack_54),
    .din(din_54),
    .dout(d54)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_55
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_55),
    .ack_l(din_ack_55),
    .req_r({req_55_29}),
    .ack_r(ack_55),
    .din(din_55),
    .dout(d55)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_56
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_56),
    .ack_l(din_ack_56),
    .req_r({req_56_13}),
    .ack_r(ack_56),
    .din(din_56),
    .dout(d56)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_57
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_57),
    .ack_l(din_ack_57),
    .req_r({req_57_12}),
    .ack_r(ack_57),
    .din(din_57),
    .dout(d57)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_58
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_58),
    .ack_l(din_ack_58),
    .req_r({req_58_36}),
    .ack_r(ack_58),
    .din(din_58),
    .dout(d58)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_59
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_59),
    .ack_l(din_ack_59),
    .req_r({req_59_31}),
    .ack_r(ack_59),
    .din(din_59),
    .dout(d59)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_60
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_60),
    .ack_l(din_ack_60),
    .req_r({req_60_17}),
    .ack_r(ack_60),
    .din(din_60),
    .dout(d60)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_61
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_61),
    .ack_l(din_ack_61),
    .req_r({req_61_3}),
    .ack_r(ack_61),
    .din(din_61),
    .dout(d61)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_62
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_62),
    .ack_l(din_ack_62),
    .req_r({req_62_25}),
    .ack_r(ack_62),
    .din(din_62),
    .dout(d62)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_63
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_63),
    .ack_l(din_ack_63),
    .req_r({req_63_42}),
    .ack_r(ack_63),
    .din(din_63),
    .dout(d63)
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

