//一起来学电子琴
module piano(
    input clk,
    input rst_n,//复位键，使当前模式复位
    input [9:0] key,
    input key_begin,//游戏开始按钮（模式切换）
    output buzzer,
    output [9:0]led,
    output seg_sel,
    output [6:0]seg_led
    );
    
    wire [9:0]leda;
    wire [9:0]ledb;
    wire beepa,beepb;
    wire seg_selo;
    wire [6:0]seg_ledo;
    
//1、示例音乐播放模块
    song u1
    (
        .clk    (clk), 
        .rst_n(rst_n),
        .out    (beepa),
        .led    (leda)
    );

//2、按键发声模块（琴键）
    speaker u2(
    .clk(clk),
    .rst_n(rst_n),
    .key(key),
    .beep(beepb)
    );
//3、匹配计数模块
    input_detector u3(
    .clk(clk),
    .rst_n(rst_n),
    .switch_input(key),//输入
    .seg_sel(seg_selo),
    .seg_led(seg_ledo),
    .led(ledb)//输出
    );
//选择模块，执行完播放模块后按开关，变成执行detector+speaker模块
    select u0(
    .key_begin(key_begin),
    .beepa(beepa),//输入两个模块的beep
    .beepb(beepb),
    .beep(buzzer),//选择后输出
    .leda(leda),
    .ledb(ledb),
    .led(led),//选择后输出
    .seg_ledo(seg_ledo),
    .seg_led(seg_led),
    .seg_selo(seg_selo),
    .seg_sel(seg_sel)
    );
endmodule