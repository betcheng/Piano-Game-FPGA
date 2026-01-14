// key #(.KEY_WIDTH(4)) key_inst(
//     /*input                           */.sys_clk     (sys_clk),
//     /*input                           */.sys_rst_n   (sys_rst_n),
//     /*input       [KEY_WIDTH - 1:0]   */.key_in      (),
//     /*output  reg [KEY_WIDTH - 1:0]   */.key_flag    ()
// );

module xiaodou#(
    parameter   KEY_WIDTH = 4'd10,
    parameter  CNT_MAX = 20'd1000_000    //20ms消抖时间
    )(
    input                           sys_clk     ,
    input                           sys_rst_n   ,
    input       [KEY_WIDTH - 1:0]   key_in      ,
    output  reg [KEY_WIDTH - 1:0]   key_flag
);



localparam  IDLE    =   4'b0001,
            DONE    =   4'b0010,
            HOLD    =   4'b0100,
            UP      =   4'b1000;

reg     [3:0]   state;

reg     [KEY_WIDTH - 1:0]   key_in_reg0,
                            key_in_reg1,
                            key_in_reg2;

reg     [KEY_WIDTH - 1:0]   key_reg;

wire                        key_in_negedge,
                            key_in_posedge;

/* 打拍 */
always@(posedge sys_clk or negedge sys_rst_n)
    if(!sys_rst_n) begin
        key_in_reg0 <= {KEY_WIDTH{1'd1}};    /* 同步 */
        key_in_reg1 <= {KEY_WIDTH{1'd1}};    /* 同步 */
        key_in_reg2 <= {KEY_WIDTH{1'd1}};    /* 边沿 */
    end
    else begin
        key_in_reg0 <= key_in;
        key_in_reg1 <= key_in_reg0;
        key_in_reg2 <= key_in_reg1;
    end

/* 按位与，只要有一位出现了下降沿/上升沿，就会将该信号拉高 */
assign key_in_negedge = ((key_in_reg2 & ~key_in_reg1) != 'd0)? 1'b1 : 1'b0;
assign key_in_posedge = ((~key_in_reg2 & key_in_reg1) != 'd0)? 1'b1 : 1'b0;

reg     start_cnt;

reg             cnt_flag;
reg     [19:0]  cnt;
wire            add_cnt,end_cnt;

always@(posedge sys_clk or negedge sys_rst_n)
    if(!sys_rst_n)		
        start_cnt <= 1'b0;
    else    if(end_cnt)
        start_cnt <= 1'b0;
    else    if(key_in_negedge || key_in_posedge)
        start_cnt <= 1'b1;

always@(posedge sys_clk or negedge sys_rst_n)
    if(!sys_rst_n)
        cnt <= 20'd0;
    else    if(add_cnt) begin
        if(end_cnt)
            cnt <= 20'd0;
        else
            cnt <= cnt + 1'b1;
    end
    else
        cnt <= 20'd0;

assign add_cnt = start_cnt;
assign end_cnt = add_cnt && ((cnt == CNT_MAX - 1) || (key_in_negedge));

/* 触发缓存 */
always@(posedge sys_clk or negedge sys_rst_n)	
    if(!sys_rst_n)								
        key_reg <= 'd0;
    else    if(key_in_negedge)
        key_reg <= key_in_reg1;


always@(posedge sys_clk or negedge sys_rst_n)	
    if(!sys_rst_n)								
        state <= IDLE;
    else    case(state)
        IDLE    :   if(key_in_negedge)
                        state <= DONE;
        DONE    :   if(end_cnt) begin
                        if(key_in == key_reg)
                            state <= HOLD;
                        else
                            state <= IDLE;
                    end
        HOLD    :   if(key_in_posedge)
                        state <= UP;
        UP      :   if(end_cnt)
                        state <= IDLE;
        default :   state <= IDLE;
    endcase

always@(posedge sys_clk or negedge sys_rst_n)
    if(!sys_rst_n)
        key_flag <= 'd0;
    else    if(state == HOLD && key_in_posedge)
        key_flag <= ~key_in_reg2;
    else
        key_flag <= 'd0;


endmodule



