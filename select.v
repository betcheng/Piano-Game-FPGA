module select(key_begin,beepa,beepb,leda,
ledb,beep,led,seg_ledo,seg_led,seg_selo,seg_sel);
input key_begin,beepa,beepb;
input [9:0]leda;
input [9:0]ledb;
input [6:0]seg_ledo;
input seg_selo;
output beep;
output [9:0]led;
output [6:0]seg_led;
output seg_sel;
reg key_r;
always @(negedge key_begin)
begin
key_r = ~key_r; //将琴键开关转换为乒乓开关
end
assign beep=(key_r)?beepb:beepa;
assign led=(key_r)?ledb:leda;
assign seg_led=(key_r)?seg_ledo:7'b0000000;
assign seg_sel=(key_r)?seg_selo:1'b1;
endmodule