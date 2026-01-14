module input_detector(
    input clk,                // 时钟信号
    input rst_n,              // 异步复位信号，低电平有效
    input [9:0] switch_input, // 开关输入信号
    output reg  seg_sel,      //连一个数码管
    output reg [6:0]    seg_led,//段选信号
    output reg [9:0]    led
);
    integer i; // 用于循环的整型数
    reg[3:0] error_count;
    reg [9:0] zero_switch_state; // 全关闭的开关状态
    reg [9:0] last_switch_state;
    // 声明一个一维数组，大小为0到27,解决了整数数组无法表示的问题
    reg [3:0] correct_pattern [27:0];   //1271271271712067567567565670共28位数据
    // 初始状态定义
    initial begin
        i=0;
        seg_sel=1'b0;          //单个数码管亮
        error_count<=4'd0;
        seg_led <= 7'b0111111; //初始化0
        zero_switch_state = 10'b0000000000;
        last_switch_state = 10'b0000000000;
        led=10'b0000000000;
        correct_pattern[0]=8;
        correct_pattern[1]=9;
        correct_pattern[2]=7;
        correct_pattern[3]=8;
        correct_pattern[4]=9;
        correct_pattern[5]=7;
        correct_pattern[6]=8;
        correct_pattern[7]=9;
        correct_pattern[8]=7;
        correct_pattern[9]=8;
        correct_pattern[10]=7;
        correct_pattern[11]=8;
        correct_pattern[12]=9;
        correct_pattern[13]=10;
        correct_pattern[14]=6;
        correct_pattern[15]=7;
        correct_pattern[16]=5;
        correct_pattern[17]=6;
        correct_pattern[18]=7;
        correct_pattern[19]=5;
        correct_pattern[20]=6;
        correct_pattern[21]=7;
        correct_pattern[22]=5;
        correct_pattern[23]=6;
        correct_pattern[24]=5;
        correct_pattern[25]=6;
        correct_pattern[26]=7;
        correct_pattern[27]=10;
    end

 //reg [15:0]a;//延时消抖
 
reg [25:0] count;
reg [9:0] key;
//取键值
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        count <= 0;
    end else begin
        if(count == 10000000)begin
        key <= switch_input;
        count <= 0;
        end else begin
        count <= count +1'b1;
        end
    end
end
always @(posedge clk or negedge rst_n) begin
    //clk上升沿触发：每次出现上升沿，运行一次，频率要求：高
        if (!rst_n) begin//rst_n低电平重置，如果rst_n显示为0，即抬起按键（或者按下，具体根据板子标准），重置电路
            i <= 0;
            error_count<=4'd0;
            seg_led <= 7'b0111111; //显示0
            last_switch_state = 10'b0000000000;
            led=10'b0000000000;
            end 
        else if ((key !== zero_switch_state)&&(key !== last_switch_state))begin 
        case(key)//防止同时拨动一位以上开关
        10'b0000000001,10'b0000000010,10'b0000000100,10'b0000001000,
        10'b0000010000,10'b0000100000,10'b0010000000,10'b0100000000,
        10'b1000000000,10'b0001000000:
            begin
            //一旦检测按键变化，此段代码开始运行,每次按完都得把它按回去！
            //for(a=16'd2000;a>0;a=a-1)
            last_switch_state<=key;
            led[10-correct_pattern[i-1]]<=1'b0;// 灭掉前一个灯
            if (i < 28) begin
                    //通过匹配的方式验证，缺点是其他位数的按键有没有变化并不清楚，只能要求玩家一次只能按下一个按键
                    // 检查对应位数上的开关是否匹配
                    if (last_switch_state[correct_pattern[i-1]-1] == 1'b1) begin
                        led[10-correct_pattern[i]]<=1'b1;// 找到正确的led使其闪烁             
                    end else begin
                       // 匹配失败，错误计数器加一
                        //加入匹配失败部分
                        error_count<=error_count+1'b1;
                        led[10-correct_pattern[i]]<=1'b1;// 找到正确的led使其闪烁
                        case(error_count)
                           4'b0000 :    seg_led <= 7'b0111111;
                           4'b0001 :    seg_led <= 7'b0000110;
                           4'b0010 :    seg_led <= 7'b1011011;
                           4'b0011 :    seg_led <= 7'b1001111;
                           4'b0100 :    seg_led <= 7'b1100110;
                           4'b0101 :    seg_led <= 7'b1101101;
                           4'b0110 :    seg_led <= 7'b1111101;
                           4'b0111 :    seg_led <= 7'b0000111;
                           4'b1000 :    seg_led <= 7'b1111111;
                           4'b1001 :    seg_led <= 7'b1101111;
			               4'b1010 : 	seg_led <= 7'b1110111;   
                           4'b1011 :    seg_led <= 7'b1111100;
                           4'b1100 :    seg_led <= 7'b0111001;
                           4'b1101 :    seg_led <= 7'b1011110;
                           4'b1110 :    seg_led <= 7'b1111001;
			               4'b1111 : 	seg_led <= 7'b1110001; 
                           default :    seg_led <= 7'b0000000;
                         endcase
                              end
                    i <= i + 1; //进行下一次按键的匹配
                          end
              end
         endcase
        end
end   
endmodule