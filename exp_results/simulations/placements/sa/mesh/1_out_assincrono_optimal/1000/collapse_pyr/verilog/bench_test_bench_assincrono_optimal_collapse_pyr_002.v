

module bench_test_bench_assincrono_optimal_collapse_pyr
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
  wire dout_req_12;
  wire dout_ack_12;
  wire [data_width-1:0] dout_12;
  wire dout_req_16;
  wire dout_ack_16;
  wire [data_width-1:0] dout_16;
  wire dout_req_23;
  wire dout_ack_23;
  wire [data_width-1:0] dout_23;
  wire dout_req_25;
  wire dout_ack_25;
  wire [data_width-1:0] dout_25;
  wire dout_req_39;
  wire dout_ack_39;
  wire [data_width-1:0] dout_39;
  wire dout_req_40;
  wire dout_ack_40;
  wire [data_width-1:0] dout_40;
  wire dout_req_61;
  wire dout_ack_61;
  wire [data_width-1:0] dout_61;
  wire dout_req_67;
  wire dout_ack_67;
  wire [data_width-1:0] dout_67;
  wire dout_req_71;
  wire dout_ack_71;
  wire [data_width-1:0] dout_71;
  wire din_req_72;
  wire din_ack_72;
  wire [data_width-1:0] din_72;
  wire din_req_73;
  wire din_ack_73;
  wire [data_width-1:0] din_73;
  wire din_req_74;
  wire din_ack_74;
  wire [data_width-1:0] din_74;
  wire din_req_75;
  wire din_ack_75;
  wire [data_width-1:0] din_75;
  wire din_req_76;
  wire din_ack_76;
  wire [data_width-1:0] din_76;
  wire dout_req_78;
  wire dout_ack_78;
  wire [data_width-1:0] dout_78;
  wire dout_req_79;
  wire dout_ack_79;
  wire [data_width-1:0] dout_79;
  wire dout_req_80;
  wire dout_ack_80;
  wire [data_width-1:0] dout_80;
  wire dout_req_81;
  wire dout_ack_81;
  wire [data_width-1:0] dout_81;
  wire dout_req_82;
  wire dout_ack_82;
  wire [data_width-1:0] dout_82;
  wire dout_req_83;
  wire dout_ack_83;
  wire [data_width-1:0] dout_83;
  wire dout_req_84;
  wire dout_ack_84;
  wire [data_width-1:0] dout_84;
  wire dout_req_85;
  wire dout_ack_85;
  wire [data_width-1:0] dout_85;
  wire [32-1:0] count_producer [0:5-1];
  wire [32-1:0] count_consumer [0:17-1];
  real count_clock;

  wire [17-1:0] consumers_done;
  wire done;
  assign consumers_done[0] = count_consumer[0] >= max_data_size;
  assign consumers_done[1] = count_consumer[1] >= max_data_size;
  assign consumers_done[2] = count_consumer[2] >= max_data_size;
  assign consumers_done[3] = count_consumer[3] >= max_data_size;
  assign consumers_done[4] = count_consumer[4] >= max_data_size;
  assign consumers_done[5] = count_consumer[5] >= max_data_size;
  assign consumers_done[6] = count_consumer[6] >= max_data_size;
  assign consumers_done[7] = count_consumer[7] >= max_data_size;
  assign consumers_done[8] = count_consumer[8] >= max_data_size;
  assign consumers_done[9] = count_consumer[9] >= max_data_size;
  assign consumers_done[10] = count_consumer[10] >= max_data_size;
  assign consumers_done[11] = count_consumer[11] >= max_data_size;
  assign consumers_done[12] = count_consumer[12] >= max_data_size;
  assign consumers_done[13] = count_consumer[13] >= max_data_size;
  assign consumers_done[14] = count_consumer[14] >= max_data_size;
  assign consumers_done[15] = count_consumer[15] >= max_data_size;
  assign consumers_done[16] = count_consumer[16] >= max_data_size;
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
      $display("bench_test_bench_assincrono_optimal_collapse_pyr throughput: %5.2f%%", (100.0 * (count_consumer[0] / (count_clock / 4.0))));
      $finish;
    end 
  end


  consumer
  #(
    .consumer_id(12),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_12
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_12),
    .ack(dout_ack_12),
    .din(dout_12),
    .count(count_consumer[0])
  );


  consumer
  #(
    .consumer_id(16),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_16
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_16),
    .ack(dout_ack_16),
    .din(dout_16),
    .count(count_consumer[1])
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
    .count(count_consumer[2])
  );


  consumer
  #(
    .consumer_id(25),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_25
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_25),
    .ack(dout_ack_25),
    .din(dout_25),
    .count(count_consumer[3])
  );


  consumer
  #(
    .consumer_id(39),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_39
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_39),
    .ack(dout_ack_39),
    .din(dout_39),
    .count(count_consumer[4])
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
    .count(count_consumer[5])
  );


  consumer
  #(
    .consumer_id(61),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_61
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_61),
    .ack(dout_ack_61),
    .din(dout_61),
    .count(count_consumer[6])
  );


  consumer
  #(
    .consumer_id(67),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_67
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_67),
    .ack(dout_ack_67),
    .din(dout_67),
    .count(count_consumer[7])
  );


  consumer
  #(
    .consumer_id(71),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_71
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_71),
    .ack(dout_ack_71),
    .din(dout_71),
    .count(count_consumer[8])
  );


  producer
  #(
    .producer_id(72),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_72
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_72),
    .ack(din_ack_72),
    .dout(din_72),
    .count(count_producer[0])
  );


  producer
  #(
    .producer_id(73),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_73
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_73),
    .ack(din_ack_73),
    .dout(din_73),
    .count(count_producer[1])
  );


  producer
  #(
    .producer_id(74),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_74
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_74),
    .ack(din_ack_74),
    .dout(din_74),
    .count(count_producer[2])
  );


  producer
  #(
    .producer_id(75),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_75
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_75),
    .ack(din_ack_75),
    .dout(din_75),
    .count(count_producer[3])
  );


  producer
  #(
    .producer_id(76),
    .data_width(data_width),
    .fail_rate(fail_rate_producer),
    .initial_value(initial_value),
    .is_const(is_const)
  )
  producer_76
  (
    .clk(clk),
    .rst(rst),
    .req(din_req_76),
    .ack(din_ack_76),
    .dout(din_76),
    .count(count_producer[4])
  );


  consumer
  #(
    .consumer_id(78),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_78
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_78),
    .ack(dout_ack_78),
    .din(dout_78),
    .count(count_consumer[9])
  );


  consumer
  #(
    .consumer_id(79),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_79
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_79),
    .ack(dout_ack_79),
    .din(dout_79),
    .count(count_consumer[10])
  );


  consumer
  #(
    .consumer_id(80),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_80
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_80),
    .ack(dout_ack_80),
    .din(dout_80),
    .count(count_consumer[11])
  );


  consumer
  #(
    .consumer_id(81),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_81
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_81),
    .ack(dout_ack_81),
    .din(dout_81),
    .count(count_consumer[12])
  );


  consumer
  #(
    .consumer_id(82),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_82
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_82),
    .ack(dout_ack_82),
    .din(dout_82),
    .count(count_consumer[13])
  );


  consumer
  #(
    .consumer_id(83),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_83
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_83),
    .ack(dout_ack_83),
    .din(dout_83),
    .count(count_consumer[14])
  );


  consumer
  #(
    .consumer_id(84),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_84
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_84),
    .ack(dout_ack_84),
    .din(dout_84),
    .count(count_consumer[15])
  );


  consumer
  #(
    .consumer_id(85),
    .data_width(data_width),
    .fail_rate(fail_rate_consumer)
  )
  consumer_85
  (
    .clk(clk),
    .rst(rst),
    .req(dout_req_85),
    .ack(dout_ack_85),
    .din(dout_85),
    .count(count_consumer[16])
  );


  collapse_pyr
  #(
    .data_width(data_width)
  )
  collapse_pyr
  (
    .clk(clk),
    .rst(rst),
    .dout_req_12(dout_req_12),
    .dout_ack_12(dout_ack_12),
    .dout_12(dout_12),
    .dout_req_16(dout_req_16),
    .dout_ack_16(dout_ack_16),
    .dout_16(dout_16),
    .dout_req_23(dout_req_23),
    .dout_ack_23(dout_ack_23),
    .dout_23(dout_23),
    .dout_req_25(dout_req_25),
    .dout_ack_25(dout_ack_25),
    .dout_25(dout_25),
    .dout_req_39(dout_req_39),
    .dout_ack_39(dout_ack_39),
    .dout_39(dout_39),
    .dout_req_40(dout_req_40),
    .dout_ack_40(dout_ack_40),
    .dout_40(dout_40),
    .dout_req_61(dout_req_61),
    .dout_ack_61(dout_ack_61),
    .dout_61(dout_61),
    .dout_req_67(dout_req_67),
    .dout_ack_67(dout_ack_67),
    .dout_67(dout_67),
    .dout_req_71(dout_req_71),
    .dout_ack_71(dout_ack_71),
    .dout_71(dout_71),
    .din_req_72(din_req_72),
    .din_ack_72(din_ack_72),
    .din_72(din_72),
    .din_req_73(din_req_73),
    .din_ack_73(din_ack_73),
    .din_73(din_73),
    .din_req_74(din_req_74),
    .din_ack_74(din_ack_74),
    .din_74(din_74),
    .din_req_75(din_req_75),
    .din_ack_75(din_ack_75),
    .din_75(din_75),
    .din_req_76(din_req_76),
    .din_ack_76(din_ack_76),
    .din_76(din_76),
    .dout_req_78(dout_req_78),
    .dout_ack_78(dout_ack_78),
    .dout_78(dout_78),
    .dout_req_79(dout_req_79),
    .dout_ack_79(dout_ack_79),
    .dout_79(dout_79),
    .dout_req_80(dout_req_80),
    .dout_ack_80(dout_ack_80),
    .dout_80(dout_80),
    .dout_req_81(dout_req_81),
    .dout_ack_81(dout_ack_81),
    .dout_81(dout_81),
    .dout_req_82(dout_req_82),
    .dout_ack_82(dout_ack_82),
    .dout_82(dout_82),
    .dout_req_83(dout_req_83),
    .dout_ack_83(dout_ack_83),
    .dout_83(dout_83),
    .dout_req_84(dout_req_84),
    .dout_ack_84(dout_ack_84),
    .dout_84(dout_84),
    .dout_req_85(dout_req_85),
    .dout_ack_85(dout_ack_85),
    .dout_85(dout_85)
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



module collapse_pyr #
(
  parameter data_width = 32
)
(
  input clk,
  input rst,
  input dout_req_12,
  output dout_ack_12,
  output [data_width-1:0] dout_12,
  input dout_req_16,
  output dout_ack_16,
  output [data_width-1:0] dout_16,
  input dout_req_23,
  output dout_ack_23,
  output [data_width-1:0] dout_23,
  input dout_req_25,
  output dout_ack_25,
  output [data_width-1:0] dout_25,
  input dout_req_39,
  output dout_ack_39,
  output [data_width-1:0] dout_39,
  input dout_req_40,
  output dout_ack_40,
  output [data_width-1:0] dout_40,
  input dout_req_61,
  output dout_ack_61,
  output [data_width-1:0] dout_61,
  input dout_req_67,
  output dout_ack_67,
  output [data_width-1:0] dout_67,
  input dout_req_71,
  output dout_ack_71,
  output [data_width-1:0] dout_71,
  output din_req_72,
  input din_ack_72,
  input [data_width-1:0] din_72,
  output din_req_73,
  input din_ack_73,
  input [data_width-1:0] din_73,
  output din_req_74,
  input din_ack_74,
  input [data_width-1:0] din_74,
  output din_req_75,
  input din_ack_75,
  input [data_width-1:0] din_75,
  output din_req_76,
  input din_ack_76,
  input [data_width-1:0] din_76,
  input dout_req_78,
  output dout_ack_78,
  output [data_width-1:0] dout_78,
  input dout_req_79,
  output dout_ack_79,
  output [data_width-1:0] dout_79,
  input dout_req_80,
  output dout_ack_80,
  output [data_width-1:0] dout_80,
  input dout_req_81,
  output dout_ack_81,
  output [data_width-1:0] dout_81,
  input dout_req_82,
  output dout_ack_82,
  output [data_width-1:0] dout_82,
  input dout_req_83,
  output dout_ack_83,
  output [data_width-1:0] dout_83,
  input dout_req_84,
  output dout_ack_84,
  output [data_width-1:0] dout_84,
  input dout_req_85,
  output dout_ack_85,
  output [data_width-1:0] dout_85
);

  wire req_0_0_24_0;
  wire ack_0;
  wire [data_width-1:0] d0;
  wire req_1_4;
  wire ack_1;
  wire [data_width-1:0] d1;
  wire req_2_12;
  wire ack_2;
  wire [data_width-1:0] d2;
  wire req_3_16;
  wire ack_3;
  wire [data_width-1:0] d3;
  wire req_4_38;
  wire ack_4;
  wire [data_width-1:0] d4;
  wire req_6_11;
  wire ack_6;
  wire [data_width-1:0] d6;
  wire req_7_86;
  wire req_7_87;
  wire ack_7;
  wire [data_width-1:0] d7;
  wire req_8_40;
  wire ack_8;
  wire [data_width-1:0] d8;
  wire req_9_9_63_0;
  wire ack_9;
  wire [data_width-1:0] d9;
  wire req_11_19;
  wire ack_11;
  wire [data_width-1:0] d11;
  wire req_15_8;
  wire req_15_57;
  wire ack_15;
  wire [data_width-1:0] d15;
  wire req_17_25;
  wire ack_17;
  wire [data_width-1:0] d17;
  wire req_18_26;
  wire req_18_41;
  wire ack_18;
  wire [data_width-1:0] d18;
  wire req_19_23;
  wire req_19_37;
  wire ack_19;
  wire [data_width-1:0] d19;
  wire req_20_61;
  wire ack_20;
  wire [data_width-1:0] d20;
  wire req_21_2;
  wire ack_21;
  wire [data_width-1:0] d21;
  wire req_24_64;
  wire ack_24;
  wire [data_width-1:0] d24;
  wire req_26_42;
  wire ack_26;
  wire [data_width-1:0] d26;
  wire req_27_67;
  wire ack_27;
  wire [data_width-1:0] d27;
  wire req_28_53;
  wire ack_28;
  wire [data_width-1:0] d28;
  wire req_29_28;
  wire ack_29;
  wire [data_width-1:0] d29;
  wire req_30_70;
  wire ack_30;
  wire [data_width-1:0] d30;
  wire req_34_35;
  wire ack_34;
  wire [data_width-1:0] d34;
  wire req_35_9;
  wire req_35_71;
  wire ack_35;
  wire [data_width-1:0] d35;
  wire req_37_78;
  wire ack_37;
  wire [data_width-1:0] d37;
  wire req_38_2;
  wire req_38_81;
  wire ack_38;
  wire [data_width-1:0] d38;
  wire req_41_1;
  wire ack_41;
  wire [data_width-1:0] d41;
  wire req_42_42_52_0;
  wire ack_42;
  wire [data_width-1:0] d42;
  wire req_43_15;
  wire ack_43;
  wire [data_width-1:0] d43;
  wire req_45_34;
  wire ack_45;
  wire [data_width-1:0] d45;
  wire req_48_94;
  wire ack_48;
  wire [data_width-1:0] d48;
  wire req_49_17;
  wire req_49_49_80_0;
  wire ack_49;
  wire [data_width-1:0] d49;
  wire req_50_27;
  wire req_50_82;
  wire ack_50;
  wire [data_width-1:0] d50;
  wire req_51_51_20_0;
  wire ack_51;
  wire [data_width-1:0] d51;
  wire req_52_51;
  wire req_52_85;
  wire ack_52;
  wire [data_width-1:0] d52;
  wire req_53_79;
  wire req_53_53_3_0;
  wire ack_53;
  wire [data_width-1:0] d53;
  wire req_57_49;
  wire ack_57;
  wire [data_width-1:0] d57;
  wire req_63_84;
  wire ack_63;
  wire [data_width-1:0] d63;
  wire req_64_39;
  wire req_64_64_30_0;
  wire ack_64;
  wire [data_width-1:0] d64;
  wire req_65_43;
  wire ack_65;
  wire [data_width-1:0] d65;
  wire req_70_83;
  wire ack_70;
  wire [data_width-1:0] d70;
  wire req_72_6;
  wire ack_72;
  wire [data_width-1:0] d72;
  wire req_73_29;
  wire ack_73;
  wire [data_width-1:0] d73;
  wire req_74_7;
  wire ack_74;
  wire [data_width-1:0] d74;
  wire req_75_18;
  wire ack_75;
  wire [data_width-1:0] d75;
  wire req_76_89;
  wire req_76_76_88_0;
  wire ack_76;
  wire [data_width-1:0] d76;
  wire req_86_0;
  wire req_86_45;
  wire req_86_86_26_0;
  wire ack_86;
  wire [data_width-1:0] d86;
  wire req_87_48;
  wire req_87_65;
  wire ack_87;
  wire [data_width-1:0] d87;
  wire req_88_92;
  wire req_88_88_91_0;
  wire req_88_88_95_0;
  wire ack_88;
  wire [data_width-1:0] d88;
  wire req_89_93;
  wire ack_89;
  wire [data_width-1:0] d89;
  wire req_90_3;
  wire req_90_20;
  wire req_90_70;
  wire ack_90;
  wire [data_width-1:0] d90;
  wire req_91_21;
  wire req_91_30;
  wire req_91_96;
  wire ack_91;
  wire [data_width-1:0] d91;
  wire req_92_8;
  wire req_92_9;
  wire req_92_51;
  wire ack_92;
  wire [data_width-1:0] d92;
  wire req_93_37;
  wire req_93_93_27_0;
  wire ack_93;
  wire [data_width-1:0] d93;
  wire req_94_50;
  wire ack_94;
  wire [data_width-1:0] d94;
  wire req_95_90;
  wire ack_95;
  wire [data_width-1:0] d95;
  wire req_96_63;
  wire ack_96;
  wire [data_width-1:0] d96;
  wire req_0_24_0_0_24_1;
  wire ack_0_24_0;
  wire [data_width-1:0] d0_24_0;
  wire req_0_24_1_0_24_2;
  wire ack_0_24_1;
  wire [data_width-1:0] d0_24_1;
  wire req_0_24_2_24;
  wire ack_0_24_2;
  wire [data_width-1:0] d0_24_2;
  wire req_9_63_0_63;
  wire ack_9_63_0;
  wire [data_width-1:0] d9_63_0;
  wire req_42_52_0_52;
  wire ack_42_52_0;
  wire [data_width-1:0] d42_52_0;
  wire req_49_80_0_80;
  wire ack_49_80_0;
  wire [data_width-1:0] d49_80_0;
  wire req_51_20_0_20;
  wire ack_51_20_0;
  wire [data_width-1:0] d51_20_0;
  wire req_53_3_0_3;
  wire ack_53_3_0;
  wire [data_width-1:0] d53_3_0;
  wire req_64_30_0_64_30_1;
  wire ack_64_30_0;
  wire [data_width-1:0] d64_30_0;
  wire req_64_30_1_30;
  wire ack_64_30_1;
  wire [data_width-1:0] d64_30_1;
  wire req_76_88_0_88;
  wire ack_76_88_0;
  wire [data_width-1:0] d76_88_0;
  wire req_86_26_0_26;
  wire ack_86_26_0;
  wire [data_width-1:0] d86_26_0;
  wire req_88_91_0_91;
  wire ack_88_91_0;
  wire [data_width-1:0] d88_91_0;
  wire req_88_95_0_95;
  wire ack_88_95_0;
  wire [data_width-1:0] d88_95_0;
  wire req_93_27_0_27;
  wire ack_93_27_0;
  wire [data_width-1:0] d93_27_0;

  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  addi_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_86_0}),
    .ack_l({ack_86}),
    .req_r({req_0_0_24_0}),
    .ack_r(ack_0),
    .din({d86}),
    .dout(d0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_1
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_41_1}),
    .ack_l({ack_41}),
    .req_r({req_1_4}),
    .ack_r(ack_1),
    .din({d41}),
    .dout(d1)
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
    .req_l({req_38_2, req_21_2}),
    .ack_l({ack_38, ack_21}),
    .req_r({req_2_12}),
    .ack_r(ack_2),
    .din({d38, d21}),
    .dout(d2)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("sub"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  sub_3
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_90_3, req_53_3_0_3}),
    .ack_l({ack_90, ack_53_3_0}),
    .req_r({req_3_16}),
    .ack_r(ack_3),
    .din({d90, d53_3_0}),
    .dout(d3)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_4
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_1_4}),
    .ack_l({ack_1}),
    .req_r({req_4_38}),
    .ack_r(ack_4),
    .din({d1}),
    .dout(d4)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("subi"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  subi_6
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_72_6}),
    .ack_l({ack_72}),
    .req_r({req_6_11}),
    .ack_r(ack_6),
    .din({d72}),
    .dout(d6)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("subi"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  subi_7
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_74_7}),
    .ack_l({ack_74}),
    .req_r({req_7_86, req_7_87}),
    .ack_r(ack_7),
    .din({d74}),
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
    .req_l({req_92_8, req_15_8}),
    .ack_l({ack_92, ack_15}),
    .req_r({req_8_40}),
    .ack_r(ack_8),
    .din({d92, d15}),
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
    .req_l({req_92_9, req_35_9}),
    .ack_l({ack_92, ack_35}),
    .req_r({req_9_9_63_0}),
    .ack_r(ack_9),
    .din({d92, d35}),
    .dout(d9)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_11
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_6_11}),
    .ack_l({ack_6}),
    .req_r({req_11_19}),
    .ack_r(ack_11),
    .din({d6}),
    .dout(d11)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_12
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_2_12),
    .ack_l(ack_2),
    .req_r(dout_req_12),
    .ack_r(dout_ack_12),
    .din(d2),
    .dout(dout_12)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  addi_15
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_43_15}),
    .ack_l({ack_43}),
    .req_r({req_15_8, req_15_57}),
    .ack_r(ack_15),
    .din({d43}),
    .dout(d15)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_16
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_3_16),
    .ack_l(ack_3),
    .req_r(dout_req_16),
    .ack_r(dout_ack_16),
    .din(d3),
    .dout(dout_16)
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
    .req_l({req_49_17}),
    .ack_l({ack_49}),
    .req_r({req_17_25}),
    .ack_r(ack_17),
    .din({d49}),
    .dout(d17)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  addi_18
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_75_18}),
    .ack_l({ack_75}),
    .req_r({req_18_26, req_18_41}),
    .ack_r(ack_18),
    .din({d75}),
    .dout(d18)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  addi_19
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_11_19}),
    .ack_l({ack_11}),
    .req_r({req_19_23, req_19_37}),
    .ack_r(ack_19),
    .din({d11}),
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
    .req_l({req_90_20, req_51_20_0_20}),
    .ack_l({ack_90, ack_51_20_0}),
    .req_r({req_20_61}),
    .ack_r(ack_20),
    .din({d90, d51_20_0}),
    .dout(d20)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  addi_21
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_91_21}),
    .ack_l({ack_91}),
    .req_r({req_21_2}),
    .ack_r(ack_21),
    .din({d91}),
    .dout(d21)
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
    .req_l(req_19_23),
    .ack_l(ack_19),
    .req_r(dout_req_23),
    .ack_r(dout_ack_23),
    .din(d19),
    .dout(dout_23)
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
    .req_l({req_0_24_2_24}),
    .ack_l({ack_0_24_2}),
    .req_r({req_24_64}),
    .ack_r(ack_24),
    .din({d0_24_2}),
    .dout(d24)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_25
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_17_25),
    .ack_l(ack_17),
    .req_r(dout_req_25),
    .ack_r(dout_ack_25),
    .din(d17),
    .dout(dout_25)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("sub"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  sub_26
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_86_26_0_26, req_18_26}),
    .ack_l({ack_86_26_0, ack_18}),
    .req_r({req_26_42}),
    .ack_r(ack_26),
    .din({d86_26_0, d18}),
    .dout(d26)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("sub"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  sub_27
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_93_27_0_27, req_50_27}),
    .ack_l({ack_93_27_0, ack_50}),
    .req_r({req_27_67}),
    .ack_r(ack_27),
    .din({d93_27_0, d50}),
    .dout(d27)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_28
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_29_28}),
    .ack_l({ack_29}),
    .req_r({req_28_53}),
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
    .req_l({req_73_29}),
    .ack_l({ack_73}),
    .req_r({req_29_28}),
    .ack_r(ack_29),
    .din({d73}),
    .dout(d29)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_30
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_91_30, req_64_30_1_30}),
    .ack_l({ack_91, ack_64_30_1}),
    .req_r({req_30_70}),
    .ack_r(ack_30),
    .din({d91, d64_30_1}),
    .dout(d30)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_34
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_45_34}),
    .ack_l({ack_45}),
    .req_r({req_34_35}),
    .ack_r(ack_34),
    .din({d45}),
    .dout(d34)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  addi_35
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_34_35}),
    .ack_l({ack_34}),
    .req_r({req_35_9, req_35_71}),
    .ack_r(ack_35),
    .din({d34}),
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
  sub_37
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_93_37, req_19_37}),
    .ack_l({ack_93, ack_19}),
    .req_r({req_37_78}),
    .ack_r(ack_37),
    .din({d93, d19}),
    .dout(d37)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  addi_38
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_4_38}),
    .ack_l({ack_4}),
    .req_r({req_38_2, req_38_81}),
    .ack_r(ack_38),
    .din({d4}),
    .dout(d38)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_39
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_64_39),
    .ack_l(ack_64),
    .req_r(dout_req_39),
    .ack_r(dout_ack_39),
    .din(d64),
    .dout(dout_39)
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
    .req_l(req_8_40),
    .ack_l(ack_8),
    .req_r(dout_req_40),
    .ack_r(dout_ack_40),
    .din(d8),
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
    .req_l({req_18_41}),
    .ack_l({ack_18}),
    .req_r({req_41_1}),
    .ack_r(ack_41),
    .din({d18}),
    .dout(d41)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_42
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_26_42}),
    .ack_l({ack_26}),
    .req_r({req_42_42_52_0}),
    .ack_r(ack_42),
    .din({d26}),
    .dout(d42)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("muli"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  muli_43
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_65_43}),
    .ack_l({ack_65}),
    .req_r({req_43_15}),
    .ack_r(ack_43),
    .din({d65}),
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
  addi_45
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_86_45}),
    .ack_l({ack_86}),
    .req_r({req_45_34}),
    .ack_r(ack_45),
    .din({d86}),
    .dout(d45)
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
    .req_l({req_87_48}),
    .ack_l({ack_87}),
    .req_r({req_48_94}),
    .ack_r(ack_48),
    .din({d87}),
    .dout(d48)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  addi_49
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_57_49}),
    .ack_l({ack_57}),
    .req_r({req_49_17, req_49_49_80_0}),
    .ack_r(ack_49),
    .din({d57}),
    .dout(d49)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  addi_50
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_94_50}),
    .ack_l({ack_94}),
    .req_r({req_50_27, req_50_82}),
    .ack_r(ack_50),
    .din({d94}),
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
    .req_l({req_92_51, req_52_51}),
    .ack_l({ack_92, ack_52}),
    .req_r({req_51_51_20_0}),
    .ack_r(ack_51),
    .din({d92, d52}),
    .dout(d51)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  addi_52
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_42_52_0_52}),
    .ack_l({ack_42_52_0}),
    .req_r({req_52_51, req_52_85}),
    .ack_r(ack_52),
    .din({d42_52_0}),
    .dout(d52)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  addi_53
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_28_53}),
    .ack_l({ack_28}),
    .req_r({req_53_79, req_53_53_3_0}),
    .ack_r(ack_53),
    .din({d28}),
    .dout(d53)
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
    .req_l({req_15_57}),
    .ack_l({ack_15}),
    .req_r({req_57_49}),
    .ack_r(ack_57),
    .din({d15}),
    .dout(d57)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_61
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_20_61),
    .ack_l(ack_20),
    .req_r(dout_req_61),
    .ack_r(dout_ack_61),
    .din(d20),
    .dout(dout_61)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_63
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_96_63, req_9_63_0_63}),
    .ack_l({ack_96, ack_9_63_0}),
    .req_r({req_63_84}),
    .ack_r(ack_63),
    .din({d96, d9_63_0}),
    .dout(d63)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("addi"),
    .immediate(2),
    .input_size(1),
    .output_size(2)
  )
  addi_64
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_24_64}),
    .ack_l({ack_24}),
    .req_r({req_64_39, req_64_64_30_0}),
    .ack_r(ack_64),
    .din({d24}),
    .dout(d64)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("subi"),
    .immediate(2),
    .input_size(1),
    .output_size(1)
  )
  subi_65
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_87_65}),
    .ack_l({ack_87}),
    .req_r({req_65_43}),
    .ack_r(ack_65),
    .din({d87}),
    .dout(d65)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_67
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_27_67),
    .ack_l(ack_27),
    .req_r(dout_req_67),
    .ack_r(dout_ack_67),
    .din(d27),
    .dout(dout_67)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("add"),
    .immediate(0),
    .input_size(2),
    .output_size(1)
  )
  add_70
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_90_70, req_30_70}),
    .ack_l({ack_90, ack_30}),
    .req_r({req_70_83}),
    .ack_r(ack_70),
    .din({d90, d30}),
    .dout(d70)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_71
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_35_71),
    .ack_l(ack_35),
    .req_r(dout_req_71),
    .ack_r(dout_ack_71),
    .din(d35),
    .dout(dout_71)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_72
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_72),
    .ack_l(din_ack_72),
    .req_r({req_72_6}),
    .ack_r(ack_72),
    .din(din_72),
    .dout(d72)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_73
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_73),
    .ack_l(din_ack_73),
    .req_r({req_73_29}),
    .ack_r(ack_73),
    .din(din_73),
    .dout(d73)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_74
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_74),
    .ack_l(din_ack_74),
    .req_r({req_74_7}),
    .ack_r(ack_74),
    .din(din_74),
    .dout(d74)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  in_75
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_75),
    .ack_l(din_ack_75),
    .req_r({req_75_18}),
    .ack_r(ack_75),
    .din(din_75),
    .dout(d75)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("in"),
    .immediate(0),
    .input_size(1),
    .output_size(2)
  )
  in_76
  (
    .clk(clk),
    .rst(rst),
    .req_l(din_req_76),
    .ack_l(din_ack_76),
    .req_r({req_76_89, req_76_76_88_0}),
    .ack_r(ack_76),
    .din(din_76),
    .dout(d76)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_78
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_37_78),
    .ack_l(ack_37),
    .req_r(dout_req_78),
    .ack_r(dout_ack_78),
    .din(d37),
    .dout(dout_78)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_79
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_53_79),
    .ack_l(ack_53),
    .req_r(dout_req_79),
    .ack_r(dout_ack_79),
    .din(d53),
    .dout(dout_79)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_80
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_49_80_0_80),
    .ack_l(ack_49_80_0),
    .req_r(dout_req_80),
    .ack_r(dout_ack_80),
    .din(d49_80_0),
    .dout(dout_80)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_81
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_38_81),
    .ack_l(ack_38),
    .req_r(dout_req_81),
    .ack_r(dout_ack_81),
    .din(d38),
    .dout(dout_81)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_82
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_50_82),
    .ack_l(ack_50),
    .req_r(dout_req_82),
    .ack_r(dout_ack_82),
    .din(d50),
    .dout(dout_82)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_83
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_70_83),
    .ack_l(ack_70),
    .req_r(dout_req_83),
    .ack_r(dout_ack_83),
    .din(d70),
    .dout(dout_83)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_84
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_63_84),
    .ack_l(ack_63),
    .req_r(dout_req_84),
    .ack_r(dout_ack_84),
    .din(d63),
    .dout(dout_84)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("out"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  out_85
  (
    .clk(clk),
    .rst(rst),
    .req_l(req_52_85),
    .ack_l(ack_52),
    .req_r(dout_req_85),
    .ack_r(dout_ack_85),
    .din(d52),
    .dout(dout_85)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(3)
  )
  reg_86
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_7_86}),
    .ack_l({ack_7}),
    .req_r({req_86_0, req_86_45, req_86_86_26_0}),
    .ack_r(ack_86),
    .din({d7}),
    .dout(d86)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(2)
  )
  reg_87
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_7_87}),
    .ack_l({ack_7}),
    .req_r({req_87_48, req_87_65}),
    .ack_r(ack_87),
    .din({d7}),
    .dout(d87)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(3)
  )
  reg_88
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_76_88_0_88}),
    .ack_l({ack_76_88_0}),
    .req_r({req_88_92, req_88_88_91_0, req_88_88_95_0}),
    .ack_r(ack_88),
    .din({d76_88_0}),
    .dout(d88)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_89
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_76_89}),
    .ack_l({ack_76}),
    .req_r({req_89_93}),
    .ack_r(ack_89),
    .din({d76}),
    .dout(d89)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(3)
  )
  reg_90
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_95_90}),
    .ack_l({ack_95}),
    .req_r({req_90_3, req_90_20, req_90_70}),
    .ack_r(ack_90),
    .din({d95}),
    .dout(d90)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(3)
  )
  reg_91
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_88_91_0_91}),
    .ack_l({ack_88_91_0}),
    .req_r({req_91_21, req_91_30, req_91_96}),
    .ack_r(ack_91),
    .din({d88_91_0}),
    .dout(d91)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(3)
  )
  reg_92
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_88_92}),
    .ack_l({ack_88}),
    .req_r({req_92_8, req_92_9, req_92_51}),
    .ack_r(ack_92),
    .din({d88}),
    .dout(d92)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(2)
  )
  reg_93
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_89_93}),
    .ack_l({ack_89}),
    .req_r({req_93_37, req_93_93_27_0}),
    .ack_r(ack_93),
    .din({d89}),
    .dout(d93)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_94
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_48_94}),
    .ack_l({ack_48}),
    .req_r({req_94_50}),
    .ack_r(ack_94),
    .din({d48}),
    .dout(d94)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_95
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_88_95_0_95}),
    .ack_l({ack_88_95_0}),
    .req_r({req_95_90}),
    .ack_r(ack_95),
    .din({d88_95_0}),
    .dout(d95)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_96
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_91_96}),
    .ack_l({ack_91}),
    .req_r({req_96_63}),
    .ack_r(ack_96),
    .din({d91}),
    .dout(d96)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_0_24_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_0_0_24_0}),
    .ack_l({ack_0}),
    .req_r({req_0_24_0_0_24_1}),
    .ack_r(ack_0_24_0),
    .din({d0}),
    .dout(d0_24_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_0_24_1
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_0_24_0_0_24_1}),
    .ack_l({ack_0_24_0}),
    .req_r({req_0_24_1_0_24_2}),
    .ack_r(ack_0_24_1),
    .din({d0_24_0}),
    .dout(d0_24_1)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_0_24_2
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_0_24_1_0_24_2}),
    .ack_l({ack_0_24_1}),
    .req_r({req_0_24_2_24}),
    .ack_r(ack_0_24_2),
    .din({d0_24_1}),
    .dout(d0_24_2)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_9_63_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_9_9_63_0}),
    .ack_l({ack_9}),
    .req_r({req_9_63_0_63}),
    .ack_r(ack_9_63_0),
    .din({d9}),
    .dout(d9_63_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_42_52_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_42_42_52_0}),
    .ack_l({ack_42}),
    .req_r({req_42_52_0_52}),
    .ack_r(ack_42_52_0),
    .din({d42}),
    .dout(d42_52_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_49_80_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_49_49_80_0}),
    .ack_l({ack_49}),
    .req_r({req_49_80_0_80}),
    .ack_r(ack_49_80_0),
    .din({d49}),
    .dout(d49_80_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_51_20_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_51_51_20_0}),
    .ack_l({ack_51}),
    .req_r({req_51_20_0_20}),
    .ack_r(ack_51_20_0),
    .din({d51}),
    .dout(d51_20_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_53_3_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_53_53_3_0}),
    .ack_l({ack_53}),
    .req_r({req_53_3_0_3}),
    .ack_r(ack_53_3_0),
    .din({d53}),
    .dout(d53_3_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_64_30_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_64_64_30_0}),
    .ack_l({ack_64}),
    .req_r({req_64_30_0_64_30_1}),
    .ack_r(ack_64_30_0),
    .din({d64}),
    .dout(d64_30_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_64_30_1
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_64_30_0_64_30_1}),
    .ack_l({ack_64_30_0}),
    .req_r({req_64_30_1_30}),
    .ack_r(ack_64_30_1),
    .din({d64_30_0}),
    .dout(d64_30_1)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_76_88_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_76_76_88_0}),
    .ack_l({ack_76}),
    .req_r({req_76_88_0_88}),
    .ack_r(ack_76_88_0),
    .din({d76}),
    .dout(d76_88_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_86_26_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_86_86_26_0}),
    .ack_l({ack_86}),
    .req_r({req_86_26_0_26}),
    .ack_r(ack_86_26_0),
    .din({d86}),
    .dout(d86_26_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_88_91_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_88_88_91_0}),
    .ack_l({ack_88}),
    .req_r({req_88_91_0_91}),
    .ack_r(ack_88_91_0),
    .din({d88}),
    .dout(d88_91_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_88_95_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_88_88_95_0}),
    .ack_l({ack_88}),
    .req_r({req_88_95_0_95}),
    .ack_r(ack_88_95_0),
    .din({d88}),
    .dout(d88_95_0)
  );


  async_operator
  #(
    .data_width(data_width),
    .op("reg"),
    .immediate(0),
    .input_size(1),
    .output_size(1)
  )
  reg_93_27_0
  (
    .clk(clk),
    .rst(rst),
    .req_l({req_93_93_27_0}),
    .ack_l({ack_93}),
    .req_r({req_93_27_0_27}),
    .ack_r(ack_93_27_0),
    .din({d93}),
    .dout(d93_27_0)
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

