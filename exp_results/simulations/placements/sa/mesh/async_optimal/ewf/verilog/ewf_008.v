

module ewf_008
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

  integer i;

  always @(posedge clk) begin
    if(rst) begin
      count_clock <= 0;
    end 
    count_clock <= count_clock + 1;
    if(done) begin
      for(i=0; i<5; i=i+1) begin
        $display("ewf_008 throughput: %d : %5.2f%%", i, (100.0 * (count_consumer[i] / (count_clock / 4.0))));
      end
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
  wire req_0_71;
  wire ack_0;
  wire [data_width-1:0] d0;
  wire req_1_47;
  wire req_1_1_4_0;
  wire ack_1;
  wire [data_width-1:0] d1;
  wire req_2_3;
  wire req_2_67;
  wire ack_2;
  wire [data_width-1:0] d2;
  wire req_3_3_4_0;
  wire ack_3;
  wire [data_width-1:0] d3;
  wire req_4_5;
  wire req_4_50;
  wire req_4_4_6_0;
  wire ack_4;
  wire [data_width-1:0] d4;
  wire req_5_5_7_0;
  wire ack_5;
  wire [data_width-1:0] d5;
  wire req_6_8;
  wire ack_6;
  wire [data_width-1:0] d6;
  wire req_7_9;
  wire req_7_59;
  wire req_7_7_10_0;
  wire ack_7;
  wire [data_width-1:0] d7;
  wire req_8_11;
  wire req_8_8_56_0;
  wire ack_8;
  wire [data_width-1:0] d8;
  wire req_9_9_12_0;
  wire ack_9;
  wire [data_width-1:0] d9;
  wire req_10_13;
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
  wire req_14_14_16_0;
  wire ack_14;
  wire [data_width-1:0] d14;
  wire req_15_17;
  wire req_15_64;
  wire req_15_15_18_0;
  wire ack_15;
  wire [data_width-1:0] d15;
  wire req_16_19;
  wire req_16_20;
  wire req_16_52;
  wire ack_16;
  wire [data_width-1:0] d16;
  wire req_17_21;
  wire ack_17;
  wire [data_width-1:0] d17;
  wire req_18_18_22_0;
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
  wire req_22_62;
  wire ack_22;
  wire [data_width-1:0] d22;
  wire req_23_27;
  wire req_23_54;
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
  wire req_47_48;
  wire ack_47;
  wire [data_width-1:0] d47;
  wire req_48_8;
  wire req_48_49;
  wire ack_48;
  wire [data_width-1:0] d48;
  wire req_49_11;
  wire ack_49;
  wire [data_width-1:0] d49;
  wire req_50_51;
  wire ack_50;
  wire [data_width-1:0] d50;
  wire req_51_10;
  wire ack_51;
  wire [data_width-1:0] d51;
  wire req_52_53;
  wire ack_52;
  wire [data_width-1:0] d52;
  wire req_53_28;
  wire ack_53;
  wire [data_width-1:0] d53;
  wire req_54_55;
  wire ack_54;
  wire [data_width-1:0] d54;
  wire req_55_33;
  wire ack_55;
  wire [data_width-1:0] d55;
  wire req_56_13;
  wire req_56_57;
  wire ack_56;
  wire [data_width-1:0] d56;
  wire req_57_58;
  wire ack_57;
  wire [data_width-1:0] d57;
  wire req_58_19;
  wire ack_58;
  wire [data_width-1:0] d58;
  wire req_59_60;
  wire ack_59;
  wire [data_width-1:0] d59;
  wire req_60_61;
  wire ack_60;
  wire [data_width-1:0] d60;
  wire req_61_18;
  wire ack_61;
  wire [data_width-1:0] d61;
  wire req_62_63;
  wire ack_62;
  wire [data_width-1:0] d62;
  wire req_63_32;
  wire ack_63;
  wire [data_width-1:0] d63;
  wire req_64_65;
  wire ack_64;
  wire [data_width-1:0] d64;
  wire req_65_66;
  wire ack_65;
  wire [data_width-1:0] d65;
  wire req_66_29;
  wire ack_66;
  wire [data_width-1:0] d66;
  wire req_67_68;
  wire ack_67;
  wire [data_width-1:0] d67;
  wire req_68_69;
  wire ack_68;
  wire [data_width-1:0] d68;
  wire req_69_7;
  wire req_69_70;
  wire ack_69;
  wire [data_width-1:0] d69;
  wire req_70_9;
  wire ack_70;
  wire [data_width-1:0] d70;
  wire req_71_72;
  wire ack_71;
  wire [data_width-1:0] d71;
  wire req_72_73;
  wire ack_72;
  wire [data_width-1:0] d72;
  wire req_73_74;
  wire ack_73;
  wire [data_width-1:0] d73;
  wire req_74_75;
  wire ack_74;
  wire [data_width-1:0] d74;
  wire req_75_76;
  wire ack_75;
  wire [data_width-1:0] d75;
  wire req_76_76_77_0;
  wire ack_76;
  wire [data_width-1:0] d76;
  wire req_77_15;
  wire req_77_78;
  wire ack_77;
  wire [data_width-1:0] d77;
  wire req_78_17;
  wire ack_78;
  wire [data_width-1:0] d78;
  wire req_1_4_0_4;
  wire ack_1_4_0;
  wire [data_width-1:0] d1_4_0;
  wire req_3_4_0_4;
  wire ack_3_4_0;
  wire [data_width-1:0] d3_4_0;
  wire req_4_6_0_6;
  wire ack_4_6_0;
  wire [data_width-1:0] d4_6_0;
  wire req_5_7_0_7;
  wire ack_5_7_0;
  wire [data_width-1:0] d5_7_0;
  wire req_7_10_0_10;
  wire ack_7_10_0;
  wire [data_width-1:0] d7_10_0;
  wire req_8_56_0_56;
  wire ack_8_56_0;
  wire [data_width-1:0] d8_56_0;
  wire req_9_12_0_12;
  wire ack_9_12_0;
  wire [data_width-1:0] d9_12_0;
  wire req_14_16_0_16;
  wire ack_14_16_0;
  wire [data_width-1:0] d14_16_0;
  wire req_15_18_0_18;
  wire ack_15_18_0;
  wire [data_width-1:0] d15_18_0;
  wire req_18_22_0_18_22_1;
  wire ack_18_22_0;
  wire [data_width-1:0] d18_22_0;
  wire req_18_22_1_22;
  wire ack_18_22_1;
  wire [data_width-1:0] d18_22_1;
  wire req_19_23_0_19_23_1;
  wire ack_19_23_0;
  wire [data_width-1:0] d19_23_0;
  wire req_19_23_1_19_23_2;
  wire ack_19_23_1;
  wire [data_width-1:0] d19_23_1;
  wire req_19_23_2_19_23_3;
  wire ack_19_23_2;
  wire [data_width-1:0] d19_23_2;
  wire req_19_23_3_23;
  wire ack_19_23_3;
  wire [data_width-1:0] d19_23_3;
  wire req_76_77_0_77;
  wire ack_76_77_0;
  wire [data_width-1:0] d76_77_0;

  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  addi_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_40_0}),
    .ack_l({ack_40}),
    .req_r({req_0_2, req_0_71}),
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
    .output_size(2)
  )
  addi_1
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_41_1}),
    .ack_l({ack_41}),
    .req_r({req_1_47, req_1_1_4_0}),
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
    .output_size(2)
  )
  addi_2
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_0_2}),
    .ack_l({ack_0}),
    .req_r({req_2_3, req_2_67}),
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
    .req_r({req_3_3_4_0}),
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
    .req_l({req_3_4_0_4, req_1_4_0_4}),
    .ack_l({ack_3_4_0, ack_1_4_0}),
    .req_r({req_4_5, req_4_50, req_4_4_6_0}),
    .ack_r(ack_4),
    .din({d3_4_0, d1_4_0}),
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
    .req_r({req_5_5_7_0}),
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
    .req_l({req_69_7, req_5_7_0_7}),
    .ack_l({ack_69, ack_5_7_0}),
    .req_r({req_7_9, req_7_59, req_7_7_10_0}),
    .ack_r(ack_7),
    .din({d69, d5_7_0}),
    .dout(d7)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(2)
  )
  add_8
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_48_8, req_6_8}),
    .ack_l({ack_48, ack_6}),
    .req_r({req_8_11, req_8_8_56_0}),
    .ack_r(ack_8),
    .din({d48, d6}),
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
    .req_l({req_70_9, req_7_9}),
    .ack_l({ack_70, ack_7}),
    .req_r({req_9_9_12_0}),
    .ack_r(ack_9),
    .din({d70, d7}),
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
    .req_l({req_51_10, req_7_10_0_10}),
    .ack_l({ack_51, ack_7_10_0}),
    .req_r({req_10_13}),
    .ack_r(ack_10),
    .din({d51, d7_10_0}),
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
    .req_l({req_49_11, req_8_11}),
    .ack_l({ack_49, ack_8}),
    .req_r({req_11_14}),
    .ack_r(ack_11),
    .din({d49, d8}),
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
    .req_l({req_9_12_0_12}),
    .ack_l({ack_9_12_0}),
    .req_r({req_12_15}),
    .ack_r(ack_12),
    .din({d9_12_0}),
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
    .req_l({req_56_13, req_10_13}),
    .ack_l({ack_56, ack_10}),
    .req_r({req_13_44}),
    .ack_r(ack_13),
    .din({d56, d10}),
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
    .req_r({req_14_14_16_0}),
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
    .req_l({req_77_15, req_12_15}),
    .ack_l({ack_77, ack_12}),
    .req_r({req_15_17, req_15_64, req_15_15_18_0}),
    .ack_r(ack_15),
    .din({d77, d12}),
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
    .req_l({req_14_16_0_16}),
    .ack_l({ack_14_16_0}),
    .req_r({req_16_19, req_16_20, req_16_52}),
    .ack_r(ack_16),
    .din({d14_16_0}),
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
    .req_l({req_78_17, req_15_17}),
    .ack_l({ack_78, ack_15}),
    .req_r({req_17_21}),
    .ack_r(ack_17),
    .din({d78, d15}),
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
    .req_l({req_61_18, req_15_18_0_18}),
    .ack_l({ack_61, ack_15_18_0}),
    .req_r({req_18_18_22_0}),
    .ack_r(ack_18),
    .din({d61, d15_18_0}),
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
    .req_l({req_58_19, req_16_19}),
    .ack_l({ack_58, ack_16}),
    .req_r({req_19_19_23_0}),
    .ack_r(ack_19),
    .din({d58, d16}),
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
    .req_l({req_16_20}),
    .ack_l({ack_16}),
    .req_r({req_20_24}),
    .ack_r(ack_20),
    .din({d16}),
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
    .req_l({req_18_22_1_22}),
    .ack_l({ack_18_22_1}),
    .req_r({req_22_26, req_22_62}),
    .ack_r(ack_22),
    .din({d18_22_1}),
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
    .req_l({req_19_23_3_23}),
    .ack_l({ack_19_23_3}),
    .req_r({req_23_27, req_23_54}),
    .ack_r(ack_23),
    .din({d19_23_3}),
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
    .req_l({req_53_28, req_24_28}),
    .ack_l({ack_53, ack_24}),
    .req_r({req_28_42}),
    .ack_r(ack_28),
    .din({d53, d24}),
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
    .req_l({req_66_29, req_25_29}),
    .ack_l({ack_66, ack_25}),
    .req_r({req_29_46}),
    .ack_r(ack_29),
    .din({d66, d25}),
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
    .req_l({req_63_32, req_30_32}),
    .ack_l({ack_63, ack_30}),
    .req_r({req_32_45}),
    .ack_r(ack_32),
    .din({d63, d30}),
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
    .req_l({req_55_33, req_31_33}),
    .ack_l({ack_55, ack_31}),
    .req_r({req_33_43}),
    .ack_r(ack_33),
    .din({d55, d31}),
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
  reg_47
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_1_47}),
    .ack_l({ack_1}),
    .req_r({req_47_48}),
    .ack_r(ack_47),
    .din({d1}),
    .dout(d47)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(2)
  )
  reg_48
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_47_48}),
    .ack_l({ack_47}),
    .req_r({req_48_8, req_48_49}),
    .ack_r(ack_48),
    .din({d47}),
    .dout(d48)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_49
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_48_49}),
    .ack_l({ack_48}),
    .req_r({req_49_11}),
    .ack_r(ack_49),
    .din({d48}),
    .dout(d49)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_50
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_4_50}),
    .ack_l({ack_4}),
    .req_r({req_50_51}),
    .ack_r(ack_50),
    .din({d4}),
    .dout(d50)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_51
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_50_51}),
    .ack_l({ack_50}),
    .req_r({req_51_10}),
    .ack_r(ack_51),
    .din({d50}),
    .dout(d51)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_52
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_16_52}),
    .ack_l({ack_16}),
    .req_r({req_52_53}),
    .ack_r(ack_52),
    .din({d16}),
    .dout(d52)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_53
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_52_53}),
    .ack_l({ack_52}),
    .req_r({req_53_28}),
    .ack_r(ack_53),
    .din({d52}),
    .dout(d53)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_54
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_23_54}),
    .ack_l({ack_23}),
    .req_r({req_54_55}),
    .ack_r(ack_54),
    .din({d23}),
    .dout(d54)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_55
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_54_55}),
    .ack_l({ack_54}),
    .req_r({req_55_33}),
    .ack_r(ack_55),
    .din({d54}),
    .dout(d55)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(2)
  )
  reg_56
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_8_56_0_56}),
    .ack_l({ack_8_56_0}),
    .req_r({req_56_13, req_56_57}),
    .ack_r(ack_56),
    .din({d8_56_0}),
    .dout(d56)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_57
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_56_57}),
    .ack_l({ack_56}),
    .req_r({req_57_58}),
    .ack_r(ack_57),
    .din({d56}),
    .dout(d57)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_58
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_57_58}),
    .ack_l({ack_57}),
    .req_r({req_58_19}),
    .ack_r(ack_58),
    .din({d57}),
    .dout(d58)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_59
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_7_59}),
    .ack_l({ack_7}),
    .req_r({req_59_60}),
    .ack_r(ack_59),
    .din({d7}),
    .dout(d59)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_60
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_59_60}),
    .ack_l({ack_59}),
    .req_r({req_60_61}),
    .ack_r(ack_60),
    .din({d59}),
    .dout(d60)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_61
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_60_61}),
    .ack_l({ack_60}),
    .req_r({req_61_18}),
    .ack_r(ack_61),
    .din({d60}),
    .dout(d61)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_62
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_22_62}),
    .ack_l({ack_22}),
    .req_r({req_62_63}),
    .ack_r(ack_62),
    .din({d22}),
    .dout(d62)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_63
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_62_63}),
    .ack_l({ack_62}),
    .req_r({req_63_32}),
    .ack_r(ack_63),
    .din({d62}),
    .dout(d63)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_64
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_15_64}),
    .ack_l({ack_15}),
    .req_r({req_64_65}),
    .ack_r(ack_64),
    .din({d15}),
    .dout(d64)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_65
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_64_65}),
    .ack_l({ack_64}),
    .req_r({req_65_66}),
    .ack_r(ack_65),
    .din({d64}),
    .dout(d65)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_66
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_65_66}),
    .ack_l({ack_65}),
    .req_r({req_66_29}),
    .ack_r(ack_66),
    .din({d65}),
    .dout(d66)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_67
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_2_67}),
    .ack_l({ack_2}),
    .req_r({req_67_68}),
    .ack_r(ack_67),
    .din({d2}),
    .dout(d67)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_68
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_67_68}),
    .ack_l({ack_67}),
    .req_r({req_68_69}),
    .ack_r(ack_68),
    .din({d67}),
    .dout(d68)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(2)
  )
  reg_69
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_68_69}),
    .ack_l({ack_68}),
    .req_r({req_69_7, req_69_70}),
    .ack_r(ack_69),
    .din({d68}),
    .dout(d69)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_70
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_69_70}),
    .ack_l({ack_69}),
    .req_r({req_70_9}),
    .ack_r(ack_70),
    .din({d69}),
    .dout(d70)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_71
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_0_71}),
    .ack_l({ack_0}),
    .req_r({req_71_72}),
    .ack_r(ack_71),
    .din({d0}),
    .dout(d71)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_72
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_71_72}),
    .ack_l({ack_71}),
    .req_r({req_72_73}),
    .ack_r(ack_72),
    .din({d71}),
    .dout(d72)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_73
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_72_73}),
    .ack_l({ack_72}),
    .req_r({req_73_74}),
    .ack_r(ack_73),
    .din({d72}),
    .dout(d73)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_74
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_73_74}),
    .ack_l({ack_73}),
    .req_r({req_74_75}),
    .ack_r(ack_74),
    .din({d73}),
    .dout(d74)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_75
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_74_75}),
    .ack_l({ack_74}),
    .req_r({req_75_76}),
    .ack_r(ack_75),
    .din({d74}),
    .dout(d75)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_76
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_75_76}),
    .ack_l({ack_75}),
    .req_r({req_76_76_77_0}),
    .ack_r(ack_76),
    .din({d75}),
    .dout(d76)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(2)
  )
  reg_77
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_76_77_0_77}),
    .ack_l({ack_76_77_0}),
    .req_r({req_77_15, req_77_78}),
    .ack_r(ack_77),
    .din({d76_77_0}),
    .dout(d77)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_78
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_77_78}),
    .ack_l({ack_77}),
    .req_r({req_78_17}),
    .ack_r(ack_78),
    .din({d77}),
    .dout(d78)
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
  reg_3_4_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_3_3_4_0}),
    .ack_l({ack_3}),
    .req_r({req_3_4_0_4}),
    .ack_r(ack_3_4_0),
    .din({d3}),
    .dout(d3_4_0)
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
  reg_5_7_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_5_5_7_0}),
    .ack_l({ack_5}),
    .req_r({req_5_7_0_7}),
    .ack_r(ack_5_7_0),
    .din({d5}),
    .dout(d5_7_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_7_10_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_7_7_10_0}),
    .ack_l({ack_7}),
    .req_r({req_7_10_0_10}),
    .ack_r(ack_7_10_0),
    .din({d7}),
    .dout(d7_10_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_8_56_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_8_8_56_0}),
    .ack_l({ack_8}),
    .req_r({req_8_56_0_56}),
    .ack_r(ack_8_56_0),
    .din({d8}),
    .dout(d8_56_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_9_12_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_9_9_12_0}),
    .ack_l({ack_9}),
    .req_r({req_9_12_0_12}),
    .ack_r(ack_9_12_0),
    .din({d9}),
    .dout(d9_12_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_14_16_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_14_14_16_0}),
    .ack_l({ack_14}),
    .req_r({req_14_16_0_16}),
    .ack_r(ack_14_16_0),
    .din({d14}),
    .dout(d14_16_0)
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
  reg_18_22_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_18_18_22_0}),
    .ack_l({ack_18}),
    .req_r({req_18_22_0_18_22_1}),
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
  reg_18_22_1
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_18_22_0_18_22_1}),
    .ack_l({ack_18_22_0}),
    .req_r({req_18_22_1_22}),
    .ack_r(ack_18_22_1),
    .din({d18_22_0}),
    .dout(d18_22_1)
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
    .req_r({req_19_23_0_19_23_1}),
    .ack_r(ack_19_23_0),
    .din({d19}),
    .dout(d19_23_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_19_23_1
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_19_23_0_19_23_1}),
    .ack_l({ack_19_23_0}),
    .req_r({req_19_23_1_19_23_2}),
    .ack_r(ack_19_23_1),
    .din({d19_23_0}),
    .dout(d19_23_1)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_19_23_2
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_19_23_1_19_23_2}),
    .ack_l({ack_19_23_1}),
    .req_r({req_19_23_2_19_23_3}),
    .ack_r(ack_19_23_2),
    .din({d19_23_1}),
    .dout(d19_23_2)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_19_23_3
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_19_23_2_19_23_3}),
    .ack_l({ack_19_23_2}),
    .req_r({req_19_23_3_23}),
    .ack_r(ack_19_23_3),
    .din({d19_23_2}),
    .dout(d19_23_3)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_76_77_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_76_76_77_0}),
    .ack_l({ack_76}),
    .req_r({req_76_77_0_77}),
    .ack_r(ack_76_77_0),
    .din({d76}),
    .dout(d76_77_0)
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

