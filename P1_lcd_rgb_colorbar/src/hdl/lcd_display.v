/************************************ Copyright(c) 2025 *******************************

   Project name  : lcd_colorbar
   File name     : lcd_display.v
   Module name   : lcd_display
   Generated     : 2024-05-07 20:41:00
   Last modified : 2024-05-07 20:41:00
   Target Device : Xilinx XC7A35TFGG484-2
   Tool Versions : Vivado ML 2024.1
   Author        : Code Pizzas
   E-Mail        : code.pizzas@gmail.cn
   Description   : RGB-888 LCD colorbar example program 

********************************** All rights reserved ******************************/
//*************************** Module, Parameters & Ports ******************************
module lcd_display#(
    parameter        P_H_DISP   = 11'd800,   // 行有效数据 
                     P_V_DISP   =  11'd480   // 场有效数据            
) (
    // 时钟与复位接口                                     
    input                                       i_lcd_pclk          ,// 时钟
    input                                       i_rst               ,// 复位，高电平有效
                                           
    // 数据接口
    input             [  10: 0]                 i_pixel_xpos        ,// 当前像素点横坐标
    input             [  10: 0]                 i_pixel_ypos        ,// 当前像素点纵坐标

    output            [  23: 0]                 o_pixel_data         // LCD RGB888颜色数据 
);

//*********************************** Localparams *************************************
localparam           LP_WHITE = 24'hFFFFFF,  // 白色
                     LP_BLACK = 24'h000000,  // 黑色
                     LP_RED   = 24'hFF0000,  // 红色
                     LP_GREEN = 24'h00FF00,  // 绿色
                     LP_BLUE  = 24'h0000FF;  // 蓝色

//************************************** Reg ******************************************
// Output binding regs
reg      [23:0]  ro_pixel_data; 

//************************************ Always *****************************************
always@ (posedge i_lcd_pclk, posedge i_rst) 
begin
    if(i_rst)
        ro_pixel_data <= LP_BLACK;
    else if((i_pixel_xpos >= 11'd0       ) && (i_pixel_xpos < P_H_DISP/5*1))
        ro_pixel_data <= LP_WHITE;
    else if((i_pixel_xpos >= P_H_DISP/5*1) && (i_pixel_xpos < P_H_DISP/5*2))    
        ro_pixel_data <= LP_BLACK;    
    else if((i_pixel_xpos >= P_H_DISP/5*2) && (i_pixel_xpos < P_H_DISP/5*3))    
        ro_pixel_data <= LP_RED  ;        
    else if((i_pixel_xpos >= P_H_DISP/5*3) && (i_pixel_xpos < P_H_DISP/5*4))    
        ro_pixel_data <= LP_GREEN;       
    else
        ro_pixel_data <= LP_BLUE ; 
end

//************************************ Assign *****************************************
// Bind regs to output 
assign o_pixel_data = ro_pixel_data;

endmodule
