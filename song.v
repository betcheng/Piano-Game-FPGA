//示例乐曲播放模块，播放一次，灯光对应音调，有复位重播功能
module song(clk,rst_n, out,led);
input clk;
input rst_n;
output out;
output reg[9:0] led;
wire beep;
assign out = beep;
reg beep_r;
assign beep=beep_r;
reg [7:0] state;
reg[15:0] count, count_end;
reg [23:0] count1,count2;
//频率(音调）
parameter	M_5=16'd31928,
            M_6=16'd28441,
            M_7=16'd25329,
            H_1=16'd23923,
            H_2=16'd21277,
            R_0=16'd20000;//消音信号
parameter 	TIME=10000000;

always @(posedge clk or negedge rst_n)
if(!rst_n) begin
count<=16'h0;
end
else begin
    count <= count+1'b1;
    if (count==count_end)
    begin
        if(count==R_0)
        begin
        count <= 16'h0;
        end
        else
        begin
        count <= 16'h0;
        beep_r <= !beep_r;
        end
    end
end

always @(posedge clk or negedge rst_n)
if(!rst_n) begin
count1<=24'd0;
state<=8'd0;
end
else begin
	if (count1 < TIME)
		count1 = count1 + 1'b1;
	else
	begin
		count1 = 24'd0;
		if (state<8'd63)
		//else
			state = state + 1'b1;
		//----------------------------
		case (state)
            8'd0,8'd1:
            begin                            
            count_end=H_1;led<=10'b0000000100;
            end
            8'd2,8'd3:
            begin                            
            count_end=H_2;led<=10'b0000000010;
            end
            8'd4,8'd5:
            begin                            
            count_end=M_7;led<=10'b0000001000;
            end
            8'd6,8'd7:
            begin                            
            count_end=H_1;led<=10'b0000000100;
            end
            8'd8,8'd9:
            begin                            
            count_end=H_2;led<=10'b0000000010;
            end
            8'd10,8'd11:
            begin                        
            count_end=M_7;led<=10'b0000001000;
            end
            8'd12,8'd13:
            begin                        
            count_end=H_1;led<=10'b0000000100;
            end
            8'd14,8'd15:
            begin                  
            count_end=H_2;led<=10'b0000000010;
            end
            8'd16,8'd17,8'd18:
            begin                    
            count_end=M_7;led<=10'b0000001000;
            end
            8'd19:
            begin                                
            count_end=H_1;led<=10'b0000000100;
            end
            8'd20,8'd21:
            begin                        
            count_end=M_7;led<=10'b0000000010;
            end
            8'd23,8'd22:
            begin                        
            count_end=H_1;led<=10'b0000000100;
            end
            8'd24,8'd25,8'd26,8'd27:
            begin    
            count_end=H_2;led<=10'b0000000010;
            end
            8'd28,8'd29,8'd30,8'd31:
             begin    
            count_end=R_0;led<=10'b0000000001;
            end
            
            
            8'd32,8'd33:
            begin                        
            count_end=M_6;led<=10'b0000010000;
            end
            8'd34,8'd35:
            begin                        
            count_end=M_7;led<=10'b0000001000;
            end
            8'd36,8'd37:
            begin                        
            count_end=M_5;led<=10'b0000100000;
            end
            8'd38,8'd39:
            begin                        
            count_end=M_6;led<=10'b0000010000;
            end
            8'd40,8'd41:
            begin                        
            count_end=M_7;led<=10'b0000001000;
            end
            8'd42,8'd43:
            begin                        
            count_end=M_5;led<=10'b0000100000;
            end
            8'd44,8'd45:
            begin                        
            count_end=M_6;led<=10'b0000010000;
            end
            8'd46,8'd47:
            begin                        
            count_end=M_7;led<=10'b0000001000;
            end
            
            8'd48,8'd49,8'd50:
            begin                    
            count_end=M_5;led<=10'b0000100000;
            end
            8'd51:
            begin                                
            count_end=M_6;led<=10'b0000010000;
            end
            8'd52,8'd53:
            begin                        
            count_end=M_5;led<=10'b0000100000;
            end
            8'd54,8'd55:
            begin                        
            count_end=M_6;led<=10'b0000010000;
            end
            8'd56,8'd57,8'd58,8'd59:
            begin    
            count_end=M_7;led<=10'b0000001000;
            end
            8'd60,8'd61,8'd62,8'd63:
            begin    
            count_end=R_0;led<=10'b0000000001;
            end
            default: count_end=R_0;
        endcase
	end
end
endmodule