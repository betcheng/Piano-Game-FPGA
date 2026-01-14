//琴键发声模块，拨动开关发声，对应灯亮
module speaker(
    input            clk,//时钟
    input            rst_n,//复位信号
    input  [9:0]    key,//按键输入
    output            beep//蜂鸣器输出
);

reg [15:0]count_end,cnt;
reg [13:0]a;   //消抖寄存器；

parameter 
            M_1=16'd47777,
            M_2=16'd42564,
            M_3=16'd37920,
            M_4=16'd35792,
            M_5=16'd31928,
            M_6=16'd28441,
            M_7=16'd25329,
            H_1=16'd23923,
            H_2=16'd21277,
            R_0=16'd20000;//消音键
            
reg wave;
assign beep = wave;
always@(posedge clk)//当clk上升沿触发时
begin
    if (!rst_n)
    begin
        cnt <= 16'h0;
    end else begin
        cnt <= cnt+1'b1;
        if (cnt==count_end)
        begin
            if(cnt==R_0)
            begin
            cnt <= 16'h0;
            end
            else
            begin
            cnt <= 16'h0;
            wave <= !wave;
            end
        end
    end
end


always@(posedge clk or negedge rst_n)
begin
    case(key)
        10'b0000000001 : 
        begin
        count_end<=M_1;
        end
        10'b0000000010 :
        begin 
        count_end<=M_2;
        end
        10'b0000000100 : 
        begin
        count_end<=M_3;
        end
        10'b0000001000 : 
        begin
        count_end<=M_4;
        end
        10'b0000010000 : 
        begin
        count_end<=M_5;
        end
        10'b0000100000 : 
        begin
        count_end<=M_6;
        end
        10'b0001000000 : 
        begin
        count_end<=M_7;
        end
        10'b0010000000 : 
        begin
        count_end<=H_1;
        end
        10'b0100000000 : 
        begin
        count_end<=H_2;
        end
        10'b1000000000 : 
        begin
        count_end<=R_0;
        end
        default     :  
        begin
        count_end <= R_0;
        end
    endcase
end

endmodule