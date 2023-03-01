

module bench_test_bench_assincrono_optimal_cosine1
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
  wire dout_req_1;
  wire dout_ack_1;
  wire [data_width-1:0] dout_1;
  wire din_req_3;
  wire din_ack_3;
  wire [data_width-1:0] din_3;
  wire din_req_9;
  wire din_ack_9;
  wire [data_width-1:0] din_9;
  wire din_req_10;
  wire din_ack_10;
  wire [data_width-1:0] din_10;
  wire din_req_11;
  wire din_ack_11;
  wire [data_width-1:0] din_11;
  wire dout_req_13;
  wire dout_ack_13;
  wire [data_width-1:0] dout_13;
  wire din_req_17;
  wire din_ack_17;
  wire [data_width-1:0] din_17;
  wire dout_req_18;
  wire dout_ack_18;
  wire [data_width-1:0] dout_18;
  wire din_req_19;
  wire din_ack_19;
  wire [data_width-1:0] din_19;
  wire din_req_20;
  wire din_ack_20;
  wire [data_width-1:0] din_20;
  wire din_req_30;
  wire din_ack_30;
  wire [data_width-1:0] din_30;
  wire din_req_35;
  wire din_ack_35;
  wire [data_width-1:0] din_35;
  wire din_req_38;
  wire din_ack_38;
  wire [data_width-1:0] din_38;
  wire dout_req_40;
  wire dout_ack_40;
  wire [data_width-1:0] dout_40;
  wire dout_req_43;
  wire dout_ack_43;
  wire [data_width-1:0] dout_43;
  wire din_req_44;
  wire din_ack_44;
  wire [data_width-1:0] din_44;
  wire din_req_45;
  wire din_ack_45;
  wire [data_width-1:0] din_45;
  wire din_req_46;
  wire din_ack_46;
  wire [data_width-1:0] din_46;
  wire dout_req_47;
  wire dout_ack_47;
  wire [data_width-1:0] dout_47;
  wire dout_req_50;
  wire dout_ack_50;
  wire [data_width-1:0] dout_50;
  wire dout_req_51;
  wire dout_ack_51;
  wire [data_width-1:0] dout_51;
  wire din_req_54;
  wire din_ack_54;
  wire [data_width-1:0] din_54;
  wire din_req_55;
  wire din_ack_55;
  wire [data_width-1:0] din_55;
  wire din_req_56;
  wire din_ack_56;
  wire [data_width-1:0] din_56;
  wire [32-1:0] count_producer [0:16-1];
  wire [32-1:0] count_consumer [0:8-1];
  real count_clock;

  wire [8-1:0] consumers_done;
  wire done;
  assign consumers_done[0] = count_consumer[0] >= max_data_size;
  assign consumers_done[1] = count_consumer[1] >= max_data_size;
  assign consumers_done[2] = count_consumer[2] >= max_data_size;
  assign consumers_done[3] = count_consumer[3] >= max_data_size;
  assign consumers_done[4] = count_consumer[4] >= max_data_size;
  assign consumers_done[5] = count_consumer[5] >= max_data_size;
  assign consumers_done[6] = count_consumer[6] >= max_data_size;
  assign consumers_done[7] = count_consumer[7] >= max_data_size;
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
      $display("bench_test_bench_assincrono_optimal_cosine1 throughput: %5.2f%%", (100.0 * (count_consumer[0] / (count_clock / 4.0))));
      $finish;
    end 
  end


  consumer
  #(
    .consumer_id(1),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_1
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_1),
    .ack(dout_ack_1),
    .din(dout_1),
    .count(count_consumer[0])
  );


  producer
  #(
    .producer_id(3),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_3
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_3),
    .ack(din_ack_3),
    .dout(din_3),
    .count(count_producer[0])
  );


  producer
  #(
    .producer_id(9),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_9
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_9),
    .ack(din_ack_9),
    .dout(din_9),
    .count(count_producer[1])
  );


  producer
  #(
    .producer_id(10),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_10
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_10),
    .ack(din_ack_10),
    .dout(din_10),
    .count(count_producer[2])
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
    .count(count_producer[3])
  );


  consumer
  #(
    .consumer_id(13),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_13
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_13),
    .ack(dout_ack_13),
    .din(dout_13),
    .count(count_consumer[1])
  );


  producer
  #(
    .producer_id(17),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_17
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_17),
    .ack(din_ack_17),
    .dout(din_17),
    .count(count_producer[4])
  );


  consumer
  #(
    .consumer_id(18),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_18
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_18),
    .ack(dout_ack_18),
    .din(dout_18),
    .count(count_consumer[2])
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
    .count(count_producer[5])
  );


  producer
  #(
    .producer_id(20),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_20
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_20),
    .ack(din_ack_20),
    .dout(din_20),
    .count(count_producer[6])
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
    .count(count_producer[7])
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
    .count(count_producer[8])
  );


  producer
  #(
    .producer_id(38),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_38
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_38),
    .ack(din_ack_38),
    .dout(din_38),
    .count(count_producer[9])
  );


  consumer
  #(
    .consumer_id(40),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_40
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_40),
    .ack(dout_ack_40),
    .din(dout_40),
    .count(count_consumer[3])
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
    .count(count_consumer[4])
  );


  producer
  #(
    .producer_id(44),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_44
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_44),
    .ack(din_ack_44),
    .dout(din_44),
    .count(count_producer[10])
  );


  producer
  #(
    .producer_id(45),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_45
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_45),
    .ack(din_ack_45),
    .dout(din_45),
    .count(count_producer[11])
  );


  producer
  #(
    .producer_id(46),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_46
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_46),
    .ack(din_ack_46),
    .dout(din_46),
    .count(count_producer[12])
  );


  consumer
  #(
    .consumer_id(47),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_47
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_47),
    .ack(dout_ack_47),
    .din(dout_47),
    .count(count_consumer[5])
  );


  consumer
  #(
    .consumer_id(50),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_50
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_50),
    .ack(dout_ack_50),
    .din(dout_50),
    .count(count_consumer[6])
  );


  consumer
  #(
    .consumer_id(51),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_51
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_51),
    .ack(dout_ack_51),
    .din(dout_51),
    .count(count_consumer[7])
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
    .count(count_producer[13])
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
    .count(count_producer[14])
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
    .count(count_producer[15])
  );


  cosine1
  #(
    .data_width(data_width)
  )
  cosine1
  (
    .clk(clk),
    .rst(rst),
    .dout_req_1(dout_req_1),
    .dout_ack_1(dout_ack_1),
    .dout_1(dout_1),
    .din_req_3(din_req_3),
    .din_ack_3(din_ack_3),
    .din_3(din_3),
    .din_req_9(din_req_9),
    .din_ack_9(din_ack_9),
    .din_9(din_9),
    .din_req_10(din_req_10),
    .din_ack_10(din_ack_10),
    .din_10(din_10),
    .din_req_11(din_req_11),
    .din_ack_11(din_ack_11),
    .din_11(din_11),
    .dout_req_13(dout_req_13),
    .dout_ack_13(dout_ack_13),
    .dout_13(dout_13),
    .din_req_17(din_req_17),
    .din_ack_17(din_ack_17),
    .din_17(din_17),
    .dout_req_18(dout_req_18),
    .dout_ack_18(dout_ack_18),
    .dout_18(dout_18),
    .din_req_19(din_req_19),
    .din_ack_19(din_ack_19),
    .din_19(din_19),
    .din_req_20(din_req_20),
    .din_ack_20(din_ack_20),
    .din_20(din_20),
    .din_req_30(din_req_30),
    .din_ack_30(din_ack_30),
    .din_30(din_30),
    .din_req_35(din_req_35),
    .din_ack_35(din_ack_35),
    .din_35(din_35),
    .din_req_38(din_req_38),
    .din_ack_38(din_ack_38),
    .din_38(din_38),
    .dout_req_40(dout_req_40),
    .dout_ack_40(dout_ack_40),
    .dout_40(dout_40),
    .dout_req_43(dout_req_43),
    .dout_ack_43(dout_ack_43),
    .dout_43(dout_43),
    .din_req_44(din_req_44),
    .din_ack_44(din_ack_44),
    .din_44(din_44),
    .din_req_45(din_req_45),
    .din_ack_45(din_ack_45),
    .din_45(din_45),
    .din_req_46(din_req_46),
    .din_ack_46(din_ack_46),
    .din_46(din_46),
    .dout_req_47(dout_req_47),
    .dout_ack_47(dout_ack_47),
    .dout_47(dout_47),
    .dout_req_50(dout_req_50),
    .dout_ack_50(dout_ack_50),
    .dout_50(dout_50),
    .dout_req_51(dout_req_51),
    .dout_ack_51(dout_ack_51),
    .dout_51(dout_51),
    .din_req_54(din_req_54),
    .din_ack_54(din_ack_54),
    .din_54(din_54),
    .din_req_55(din_req_55),
    .din_ack_55(din_ack_55),
    .din_55(din_55),
    .din_req_56(din_req_56),
    .din_ack_56(din_ack_56),
    .din_56(din_56)
  );


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



module cosine1 #
(
  parameter data_width = 32
)
(
  input clk,
  input rst,
  input dout_req_1,
  output dout_ack_1,
  output [data_width-1:0] dout_1,
  output din_req_3,
  input din_ack_3,
  input [data_width-1:0] din_3,
  output din_req_9,
  input din_ack_9,
  input [data_width-1:0] din_9,
  output din_req_10,
  input din_ack_10,
  input [data_width-1:0] din_10,
  output din_req_11,
  input din_ack_11,
  input [data_width-1:0] din_11,
  input dout_req_13,
  output dout_ack_13,
  output [data_width-1:0] dout_13,
  output din_req_17,
  input din_ack_17,
  input [data_width-1:0] din_17,
  input dout_req_18,
  output dout_ack_18,
  output [data_width-1:0] dout_18,
  output din_req_19,
  input din_ack_19,
  input [data_width-1:0] din_19,
  output din_req_20,
  input din_ack_20,
  input [data_width-1:0] din_20,
  output din_req_30,
  input din_ack_30,
  input [data_width-1:0] din_30,
  output din_req_35,
  input din_ack_35,
  input [data_width-1:0] din_35,
  output din_req_38,
  input din_ack_38,
  input [data_width-1:0] din_38,
  input dout_req_40,
  output dout_ack_40,
  output [data_width-1:0] dout_40,
  input dout_req_43,
  output dout_ack_43,
  output [data_width-1:0] dout_43,
  output din_req_44,
  input din_ack_44,
  input [data_width-1:0] din_44,
  output din_req_45,
  input din_ack_45,
  input [data_width-1:0] din_45,
  output din_req_46,
  input din_ack_46,
  input [data_width-1:0] din_46,
  input dout_req_47,
  output dout_ack_47,
  output [data_width-1:0] dout_47,
  input dout_req_50,
  output dout_ack_50,
  output [data_width-1:0] dout_50,
  input dout_req_51,
  output dout_ack_51,
  output [data_width-1:0] dout_51,
  output din_req_54,
  input din_ack_54,
  input [data_width-1:0] din_54,
  output din_req_55,
  input din_ack_55,
  input [data_width-1:0] din_55,
  output din_req_56,
  input din_ack_56,
  input [data_width-1:0] din_56
);

  wire req_0_59;
  wire req_0_0_21_0;
  wire ack_0;
  wire [data_width-1:0] d0;
  wire req_2_47;
  wire ack_2;
  wire [data_width-1:0] d2;
  wire req_3_24;
  wire ack_3;
  wire [data_width-1:0] d3;
  wire req_4_4_28_0;
  wire ack_4;
  wire [data_width-1:0] d4;
  wire req_5_42;
  wire req_5_16;
  wire ack_5;
  wire [data_width-1:0] d5;
  wire req_6_43;
  wire ack_6;
  wire [data_width-1:0] d6;
  wire req_7_42;
  wire req_7_16;
  wire ack_7;
  wire [data_width-1:0] d7;
  wire req_8_6;
  wire ack_8;
  wire [data_width-1:0] d8;
  wire req_9_36;
  wire ack_9;
  wire [data_width-1:0] d9;
  wire req_10_25;
  wire ack_10;
  wire [data_width-1:0] d10;
  wire req_11_39;
  wire ack_11;
  wire [data_width-1:0] d11;
  wire req_12_48;
  wire req_12_29;
  wire ack_12;
  wire [data_width-1:0] d12;
  wire req_14_14_15_0;
  wire ack_14;
  wire [data_width-1:0] d14;
  wire req_15_49;
  wire req_15_2;
  wire ack_15;
  wire [data_width-1:0] d15;
  wire req_16_0;
  wire req_16_37;
  wire ack_16;
  wire [data_width-1:0] d16;
  wire req_17_25;
  wire ack_17;
  wire [data_width-1:0] d17;
  wire req_19_34;
  wire ack_19;
  wire [data_width-1:0] d19;
  wire req_20_39;
  wire ack_20;
  wire [data_width-1:0] d20;
  wire req_21_64;
  wire ack_21;
  wire [data_width-1:0] d21;
  wire req_22_22_5_0;
  wire ack_22;
  wire [data_width-1:0] d22;
  wire req_23_53;
  wire ack_23;
  wire [data_width-1:0] d23;
  wire req_24_62;
  wire req_24_12;
  wire ack_24;
  wire [data_width-1:0] d24;
  wire req_25_27;
  wire req_25_25_60_0;
  wire ack_25;
  wire [data_width-1:0] d25;
  wire req_26_49;
  wire req_26_2;
  wire ack_26;
  wire [data_width-1:0] d26;
  wire req_27_63;
  wire req_27_57;
  wire ack_27;
  wire [data_width-1:0] d27;
  wire req_28_18;
  wire ack_28;
  wire [data_width-1:0] d28;
  wire req_29_31;
  wire ack_29;
  wire [data_width-1:0] d29;
  wire req_30_24;
  wire ack_30;
  wire [data_width-1:0] d30;
  wire req_31_40;
  wire ack_31;
  wire [data_width-1:0] d31;
  wire req_32_64;
  wire ack_32;
  wire [data_width-1:0] d32;
  wire req_33_50;
  wire ack_33;
  wire [data_width-1:0] d33;
  wire req_34_37;
  wire req_34_0;
  wire ack_34;
  wire [data_width-1:0] d34;
  wire req_35_34;
  wire ack_35;
  wire [data_width-1:0] d35;
  wire req_36_7;
  wire ack_36;
  wire [data_width-1:0] d36;
  wire req_37_41;
  wire req_37_37_58_0;
  wire ack_37;
  wire [data_width-1:0] d37;
  wire req_38_22;
  wire ack_38;
  wire [data_width-1:0] d38;
  wire req_39_60;
  wire req_39_27;
  wire ack_39;
  wire [data_width-1:0] d39;
  wire req_41_41_33_0;
  wire ack_41;
  wire [data_width-1:0] d41;
  wire req_42_62;
  wire req_42_42_12_0;
  wire ack_42;
  wire [data_width-1:0] d42;
  wire req_44_22;
  wire ack_44;
  wire [data_width-1:0] d44;
  wire req_45_52;
  wire ack_45;
  wire [data_width-1:0] d45;
  wire req_46_61;
  wire ack_46;
  wire [data_width-1:0] d46;
  wire req_48_48_33_0;
  wire ack_48;
  wire [data_width-1:0] d48;
  wire req_49_1;
  wire ack_49;
  wire [data_width-1:0] d49;
  wire req_52_65;
  wire req_52_14;
  wire ack_52;
  wire [data_width-1:0] d52;
  wire req_53_13;
  wire ack_53;
  wire [data_width-1:0] d53;
  wire req_54_36;
  wire ack_54;
  wire [data_width-1:0] d54;
  wire req_55_61;
  wire ack_55;
  wire [data_width-1:0] d55;
  wire req_56_52;
  wire ack_56;
  wire [data_width-1:0] d56;
  wire req_57_28;
  wire ack_57;
  wire [data_width-1:0] d57;
  wire req_58_31;
  wire ack_58;
  wire [data_width-1:0] d58;
  wire req_59_6;
  wire ack_59;
  wire [data_width-1:0] d59;
  wire req_60_26;
  wire ack_60;
  wire [data_width-1:0] d60;
  wire req_61_14;
  wire req_61_61_65_0;
  wire ack_61;
  wire [data_width-1:0] d61;
  wire req_62_62_8_0;
  wire req_62_62_32_0;
  wire ack_62;
  wire [data_width-1:0] d62;
  wire req_63_53;
  wire ack_63;
  wire [data_width-1:0] d63;
  wire req_64_51;
  wire ack_64;
  wire [data_width-1:0] d64;
  wire req_65_23;
  wire req_65_4;
  wire ack_65;
  wire [data_width-1:0] d65;
  wire req_0_21_0_21;
  wire ack_0_21_0;
  wire [data_width-1:0] d0_21_0;
  wire req_4_28_0_4_28_1;
  wire ack_4_28_0;
  wire [data_width-1:0] d4_28_0;
  wire req_4_28_1_28;
  wire ack_4_28_1;
  wire [data_width-1:0] d4_28_1;
  wire req_14_15_0_14_15_1;
  wire ack_14_15_0;
  wire [data_width-1:0] d14_15_0;
  wire req_14_15_1_15;
  wire ack_14_15_1;
  wire [data_width-1:0] d14_15_1;
  wire req_22_5_0_22_5_1;
  wire ack_22_5_0;
  wire [data_width-1:0] d22_5_0;
  wire req_22_5_1_5;
  wire ack_22_5_1;
  wire [data_width-1:0] d22_5_1;
  wire req_25_60_0_25_60_1;
  wire ack_25_60_0;
  wire [data_width-1:0] d25_60_0;
  wire req_25_60_1_60;
  wire ack_25_60_1;
  wire [data_width-1:0] d25_60_1;
  wire req_37_58_0_37_58_1;
  wire ack_37_58_0;
  wire [data_width-1:0] d37_58_0;
  wire req_37_58_1_58;
  wire ack_37_58_1;
  wire [data_width-1:0] d37_58_1;
  wire req_41_33_0_33;
  wire ack_41_33_0;
  wire [data_width-1:0] d41_33_0;
  wire req_42_12_0_42_12_1;
  wire ack_42_12_0;
  wire [data_width-1:0] d42_12_0;
  wire req_42_12_1_12;
  wire ack_42_12_1;
  wire [data_width-1:0] d42_12_1;
  wire req_48_33_0_33;
  wire ack_48_33_0;
  wire [data_width-1:0] d48_33_0;
  wire req_61_65_0_61_65_1;
  wire ack_61_65_0;
  wire [data_width-1:0] d61_65_0;
  wire req_61_65_1_65;
  wire ack_61_65_1;
  wire [data_width-1:0] d61_65_1;
  wire req_62_8_0_62_8_1;
  wire ack_62_8_0;
  wire [data_width-1:0] d62_8_0;
  wire req_62_8_1_8;
  wire ack_62_8_1;
  wire [data_width-1:0] d62_8_1;
  wire req_62_32_0_32;
  wire ack_62_32_0;
  wire [data_width-1:0] d62_32_0;

  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(2)
  )
  add_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_34_0, req_16_0}),
    .ack_l({ack_34, ack_16}),
    .req_r({req_0_59, req_0_0_21_0}),
    .ack_r(ack_0),
    .din({d34, d16}),
    .dout(d0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_1
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_49_1),
    .ack_l(ack_49),
    .req_r(dout_req_1),
    .ack_r(dout_ack_1),
    .din(d49),
    .dout(dout_1)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("sub"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  sub_2
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_26_2, req_15_2}),
    .ack_l({ack_26, ack_15}),
    .req_r({req_2_47}),
    .ack_r(ack_2),
    .din({d26, d15}),
    .dout(d2)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_3
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_3),
    .ack_l(din_ack_3),
    .req_r({req_3_24}),
    .ack_r(ack_3),
    .din(din_3),
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
    .req_l({req_65_4}),
    .ack_l({ack_65}),
    .req_r({req_4_4_28_0}),
    .ack_r(ack_4),
    .din({d65}),
    .dout(d4)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  muli_5
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_22_5_1_5}),
    .ack_l({ack_22_5_1}),
    .req_r({req_5_42, req_5_16}),
    .ack_r(ack_5),
    .din({d22_5_1}),
    .dout(d5)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_6
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_59_6, req_8_6}),
    .ack_l({ack_59, ack_8}),
    .req_r({req_6_43}),
    .ack_r(ack_6),
    .din({d59, d8}),
    .dout(d6)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  muli_7
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_36_7}),
    .ack_l({ack_36}),
    .req_r({req_7_42, req_7_16}),
    .ack_r(ack_7),
    .din({d36}),
    .dout(d7)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_8
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_62_8_1_8}),
    .ack_l({ack_62_8_1}),
    .req_r({req_8_6}),
    .ack_r(ack_8),
    .din({d62_8_1}),
    .dout(d8)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_9
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_9),
    .ack_l(din_ack_9),
    .req_r({req_9_36}),
    .ack_r(ack_9),
    .din(din_9),
    .dout(d9)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_10
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_10),
    .ack_l(din_ack_10),
    .req_r({req_10_25}),
    .ack_r(ack_10),
    .din(din_10),
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
    .req_r({req_11_39}),
    .ack_r(ack_11),
    .din(din_11),
    .dout(d11)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("sub"),
    .immediate(0),
    .input_size(2),
    .output_size(2)
  )
  sub_12
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_42_12_1_12, req_24_12}),
    .ack_l({ack_42_12_1, ack_24}),
    .req_r({req_12_48, req_12_29}),
    .ack_r(ack_12),
    .din({d42_12_1, d24}),
    .dout(d12)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_13
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_53_13),
    .ack_l(ack_53),
    .req_r(dout_req_13),
    .ack_r(dout_ack_13),
    .din(d53),
    .dout(dout_13)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_14
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_61_14, req_52_14}),
    .ack_l({ack_61, ack_52}),
    .req_r({req_14_14_15_0}),
    .ack_r(ack_14),
    .din({d61, d52}),
    .dout(d14)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  muli_15
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_14_15_1_15}),
    .ack_l({ack_14_15_1}),
    .req_r({req_15_49, req_15_2}),
    .ack_r(ack_15),
    .din({d14_15_1}),
    .dout(d15)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("sub"),
    .immediate(0),
    .input_size(2),
    .output_size(2)
  )
  sub_16
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_7_16, req_5_16}),
    .ack_l({ack_7, ack_5}),
    .req_r({req_16_0, req_16_37}),
    .ack_r(ack_16),
    .din({d7, d5}),
    .dout(d16)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_17
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_17),
    .ack_l(din_ack_17),
    .req_r({req_17_25}),
    .ack_r(ack_17),
    .din(din_17),
    .dout(d17)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_18
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_28_18),
    .ack_l(ack_28),
    .req_r(dout_req_18),
    .ack_r(dout_ack_18),
    .din(d28),
    .dout(dout_18)
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
    .req_r({req_19_34}),
    .ack_r(ack_19),
    .din(din_19),
    .dout(d19)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_20
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_20),
    .ack_l(din_ack_20),
    .req_r({req_20_39}),
    .ack_r(ack_20),
    .din(din_20),
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
    .req_l({req_0_21_0_21}),
    .ack_l({ack_0_21_0}),
    .req_r({req_21_64}),
    .ack_r(ack_21),
    .din({d0_21_0}),
    .dout(d21)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("sub"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  sub_22
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_44_22, req_38_22}),
    .ack_l({ack_44, ack_38}),
    .req_r({req_22_22_5_0}),
    .ack_r(ack_22),
    .din({d44, d38}),
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
    .req_l({req_65_23}),
    .ack_l({ack_65}),
    .req_r({req_23_53}),
    .ack_r(ack_23),
    .din({d65}),
    .dout(d23)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("sub"),
    .immediate(0),
    .input_size(2),
    .output_size(2)
  )
  sub_24
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_30_24, req_3_24}),
    .ack_l({ack_30, ack_3}),
    .req_r({req_24_62, req_24_12}),
    .ack_r(ack_24),
    .din({d30, d3}),
    .dout(d24)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(2)
  )
  add_25
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_17_25, req_10_25}),
    .ack_l({ack_17, ack_10}),
    .req_r({req_25_27, req_25_25_60_0}),
    .ack_r(ack_25),
    .din({d17, d10}),
    .dout(d25)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  muli_26
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_60_26}),
    .ack_l({ack_60}),
    .req_r({req_26_49, req_26_2}),
    .ack_r(ack_26),
    .din({d60}),
    .dout(d26)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("sub"),
    .immediate(0),
    .input_size(2),
    .output_size(2)
  )
  sub_27
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_39_27, req_25_27}),
    .ack_l({ack_39, ack_25}),
    .req_r({req_27_63, req_27_57}),
    .ack_r(ack_27),
    .din({d39, d25}),
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
    .req_l({req_57_28, req_4_28_1_28}),
    .ack_l({ack_57, ack_4_28_1}),
    .req_r({req_28_18}),
    .ack_r(ack_28),
    .din({d57, d4_28_1}),
    .dout(d28)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_29
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_12_29}),
    .ack_l({ack_12}),
    .req_r({req_29_31}),
    .ack_r(ack_29),
    .din({d12}),
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
    .req_r({req_30_24}),
    .ack_r(ack_30),
    .din(din_30),
    .dout(d30)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("sub"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  sub_31
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_58_31, req_29_31}),
    .ack_l({ack_58, ack_29}),
    .req_r({req_31_40}),
    .ack_r(ack_31),
    .din({d58, d29}),
    .dout(d31)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_32
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_62_32_0_32}),
    .ack_l({ack_62_32_0}),
    .req_r({req_32_64}),
    .ack_r(ack_32),
    .din({d62_32_0}),
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
    .req_l({req_48_33_0_33, req_41_33_0_33}),
    .ack_l({ack_48_33_0, ack_41_33_0}),
    .req_r({req_33_50}),
    .ack_r(ack_33),
    .din({d48_33_0, d41_33_0}),
    .dout(d33)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("sub"),
    .immediate(0),
    .input_size(2),
    .output_size(2)
  )
  sub_34
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_35_34, req_19_34}),
    .ack_l({ack_35, ack_19}),
    .req_r({req_34_37, req_34_0}),
    .ack_r(ack_34),
    .din({d35, d19}),
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
    .req_r({req_35_34}),
    .ack_r(ack_35),
    .din(din_35),
    .dout(d35)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("sub"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  sub_36
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_54_36, req_9_36}),
    .ack_l({ack_54, ack_9}),
    .req_r({req_36_7}),
    .ack_r(ack_36),
    .din({d54, d9}),
    .dout(d36)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("sub"),
    .immediate(0),
    .input_size(2),
    .output_size(2)
  )
  sub_37
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_34_37, req_16_37}),
    .ack_l({ack_34, ack_16}),
    .req_r({req_37_41, req_37_37_58_0}),
    .ack_r(ack_37),
    .din({d34, d16}),
    .dout(d37)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_38
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_38),
    .ack_l(din_ack_38),
    .req_r({req_38_22}),
    .ack_r(ack_38),
    .din(din_38),
    .dout(d38)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(2)
  )
  add_39
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_20_39, req_11_39}),
    .ack_l({ack_20, ack_11}),
    .req_r({req_39_60, req_39_27}),
    .ack_r(ack_39),
    .din({d20, d11}),
    .dout(d39)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_40
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_31_40),
    .ack_l(ack_31),
    .req_r(dout_req_40),
    .ack_r(dout_ack_40),
    .din(d31),
    .dout(dout_40)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_41
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_37_41}),
    .ack_l({ack_37}),
    .req_r({req_41_41_33_0}),
    .ack_r(ack_41),
    .din({d37}),
    .dout(d41)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(2)
  )
  add_42
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_7_42, req_5_42}),
    .ack_l({ack_7, ack_5}),
    .req_r({req_42_62, req_42_42_12_0}),
    .ack_r(ack_42),
    .din({d7, d5}),
    .dout(d42)
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
    .req_l(req_6_43),
    .ack_l(ack_6),
    .req_r(dout_req_43),
    .ack_r(dout_ack_43),
    .din(d6),
    .dout(dout_43)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_44
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_44),
    .ack_l(din_ack_44),
    .req_r({req_44_22}),
    .ack_r(ack_44),
    .din(din_44),
    .dout(d44)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_45
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_45),
    .ack_l(din_ack_45),
    .req_r({req_45_52}),
    .ack_r(ack_45),
    .din(din_45),
    .dout(d45)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_46
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_46),
    .ack_l(din_ack_46),
    .req_r({req_46_61}),
    .ack_r(ack_46),
    .din(din_46),
    .dout(d46)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_47
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_2_47),
    .ack_l(ack_2),
    .req_r(dout_req_47),
    .ack_r(dout_ack_47),
    .din(d2),
    .dout(dout_47)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_48
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_12_48}),
    .ack_l({ack_12}),
    .req_r({req_48_48_33_0}),
    .ack_r(ack_48),
    .din({d12}),
    .dout(d48)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_49
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_26_49, req_15_49}),
    .ack_l({ack_26, ack_15}),
    .req_r({req_49_1}),
    .ack_r(ack_49),
    .din({d26, d15}),
    .dout(d49)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_50
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_33_50),
    .ack_l(ack_33),
    .req_r(dout_req_50),
    .ack_r(dout_ack_50),
    .din(d33),
    .dout(dout_50)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_51
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_64_51),
    .ack_l(ack_64),
    .req_r(dout_req_51),
    .ack_r(dout_ack_51),
    .din(d64),
    .dout(dout_51)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(2)
  )
  add_52
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_56_52, req_45_52}),
    .ack_l({ack_56, ack_45}),
    .req_r({req_52_65, req_52_14}),
    .ack_r(ack_52),
    .din({d56, d45}),
    .dout(d52)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("sub"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  sub_53
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_63_53, req_23_53}),
    .ack_l({ack_63, ack_23}),
    .req_r({req_53_13}),
    .ack_r(ack_53),
    .din({d63, d23}),
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
    .req_r({req_54_36}),
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
    .req_r({req_55_61}),
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
    .req_r({req_56_52}),
    .ack_r(ack_56),
    .din(din_56),
    .dout(d56)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_57
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_27_57}),
    .ack_l({ack_27}),
    .req_r({req_57_28}),
    .ack_r(ack_57),
    .din({d27}),
    .dout(d57)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_58
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_37_58_1_58}),
    .ack_l({ack_37_58_1}),
    .req_r({req_58_31}),
    .ack_r(ack_58),
    .din({d37_58_1}),
    .dout(d58)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_59
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_0_59}),
    .ack_l({ack_0}),
    .req_r({req_59_6}),
    .ack_r(ack_59),
    .din({d0}),
    .dout(d59)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_60
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_39_60, req_25_60_1_60}),
    .ack_l({ack_39, ack_25_60_1}),
    .req_r({req_60_26}),
    .ack_r(ack_60),
    .din({d39, d25_60_1}),
    .dout(d60)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(2)
  )
  add_61
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_55_61, req_46_61}),
    .ack_l({ack_55, ack_46}),
    .req_r({req_61_14, req_61_61_65_0}),
    .ack_r(ack_61),
    .din({d55, d46}),
    .dout(d61)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(2)
  )
  add_62
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_42_62, req_24_62}),
    .ack_l({ack_42, ack_24}),
    .req_r({req_62_62_8_0, req_62_62_32_0}),
    .ack_r(ack_62),
    .din({d42, d24}),
    .dout(d62)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_63
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_27_63}),
    .ack_l({ack_27}),
    .req_r({req_63_53}),
    .ack_r(ack_63),
    .din({d27}),
    .dout(d63)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("sub"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  sub_64
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_32_64, req_21_64}),
    .ack_l({ack_32, ack_21}),
    .req_r({req_64_51}),
    .ack_r(ack_64),
    .din({d32, d21}),
    .dout(d64)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("sub"),
    .immediate(0),
    .input_size(2),
    .output_size(2)
  )
  sub_65
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_61_65_1_65, req_52_65}),
    .ack_l({ack_61_65_1, ack_52}),
    .req_r({req_65_23, req_65_4}),
    .ack_r(ack_65),
    .din({d61_65_1, d52}),
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
  reg_0_21_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_0_0_21_0}),
    .ack_l({ack_0}),
    .req_r({req_0_21_0_21}),
    .ack_r(ack_0_21_0),
    .din({d0}),
    .dout(d0_21_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_4_28_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_4_4_28_0}),
    .ack_l({ack_4}),
    .req_r({req_4_28_0_4_28_1}),
    .ack_r(ack_4_28_0),
    .din({d4}),
    .dout(d4_28_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_4_28_1
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_4_28_0_4_28_1}),
    .ack_l({ack_4_28_0}),
    .req_r({req_4_28_1_28}),
    .ack_r(ack_4_28_1),
    .din({d4_28_0}),
    .dout(d4_28_1)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_14_15_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_14_14_15_0}),
    .ack_l({ack_14}),
    .req_r({req_14_15_0_14_15_1}),
    .ack_r(ack_14_15_0),
    .din({d14}),
    .dout(d14_15_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_14_15_1
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_14_15_0_14_15_1}),
    .ack_l({ack_14_15_0}),
    .req_r({req_14_15_1_15}),
    .ack_r(ack_14_15_1),
    .din({d14_15_0}),
    .dout(d14_15_1)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_22_5_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_22_22_5_0}),
    .ack_l({ack_22}),
    .req_r({req_22_5_0_22_5_1}),
    .ack_r(ack_22_5_0),
    .din({d22}),
    .dout(d22_5_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_22_5_1
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_22_5_0_22_5_1}),
    .ack_l({ack_22_5_0}),
    .req_r({req_22_5_1_5}),
    .ack_r(ack_22_5_1),
    .din({d22_5_0}),
    .dout(d22_5_1)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_25_60_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_25_25_60_0}),
    .ack_l({ack_25}),
    .req_r({req_25_60_0_25_60_1}),
    .ack_r(ack_25_60_0),
    .din({d25}),
    .dout(d25_60_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_25_60_1
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_25_60_0_25_60_1}),
    .ack_l({ack_25_60_0}),
    .req_r({req_25_60_1_60}),
    .ack_r(ack_25_60_1),
    .din({d25_60_0}),
    .dout(d25_60_1)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_37_58_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_37_37_58_0}),
    .ack_l({ack_37}),
    .req_r({req_37_58_0_37_58_1}),
    .ack_r(ack_37_58_0),
    .din({d37}),
    .dout(d37_58_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_37_58_1
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_37_58_0_37_58_1}),
    .ack_l({ack_37_58_0}),
    .req_r({req_37_58_1_58}),
    .ack_r(ack_37_58_1),
    .din({d37_58_0}),
    .dout(d37_58_1)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_41_33_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_41_41_33_0}),
    .ack_l({ack_41}),
    .req_r({req_41_33_0_33}),
    .ack_r(ack_41_33_0),
    .din({d41}),
    .dout(d41_33_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_42_12_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_42_42_12_0}),
    .ack_l({ack_42}),
    .req_r({req_42_12_0_42_12_1}),
    .ack_r(ack_42_12_0),
    .din({d42}),
    .dout(d42_12_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_42_12_1
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_42_12_0_42_12_1}),
    .ack_l({ack_42_12_0}),
    .req_r({req_42_12_1_12}),
    .ack_r(ack_42_12_1),
    .din({d42_12_0}),
    .dout(d42_12_1)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_48_33_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_48_48_33_0}),
    .ack_l({ack_48}),
    .req_r({req_48_33_0_33}),
    .ack_r(ack_48_33_0),
    .din({d48}),
    .dout(d48_33_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_61_65_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_61_61_65_0}),
    .ack_l({ack_61}),
    .req_r({req_61_65_0_61_65_1}),
    .ack_r(ack_61_65_0),
    .din({d61}),
    .dout(d61_65_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_61_65_1
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_61_65_0_61_65_1}),
    .ack_l({ack_61_65_0}),
    .req_r({req_61_65_1_65}),
    .ack_r(ack_61_65_1),
    .din({d61_65_0}),
    .dout(d61_65_1)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_62_8_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_62_62_8_0}),
    .ack_l({ack_62}),
    .req_r({req_62_8_0_62_8_1}),
    .ack_r(ack_62_8_0),
    .din({d62}),
    .dout(d62_8_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_62_8_1
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_62_8_0_62_8_1}),
    .ack_l({ack_62_8_0}),
    .req_r({req_62_8_1_8}),
    .ack_r(ack_62_8_1),
    .din({d62_8_0}),
    .dout(d62_8_1)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_62_32_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_62_62_32_0}),
    .ack_l({ack_62}),
    .req_r({req_62_32_0_32}),
    .ack_r(ack_62_32_0),
    .din({d62}),
    .dout(d62_32_0)
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

