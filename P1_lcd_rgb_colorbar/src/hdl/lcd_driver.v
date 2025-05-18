/************************************ Copyright(c) 2025 *******************************

   Project name  : lcd_colorbar
   File name     : lcd_driver.v
   Module name   : lcd_driver
   Generated     : 2024-05-07 20:41:00
   Last modified : 2024-05-07 20:41:00
   Target Device : Xilinx XC7A35TFGG484-2
   Tool Versions : Vivado ML 2024.1
   Author        : Code Pizzas
   E-Mail        : code.pizzas@gmail.cn
   Description   : RGB-888 LCD colorbar example program 

********************************** All rights reserved ******************************/
   
//*************************** Module, Parameters & Ports ******************************
module lcd_driver #(
    parameter                  P_H_SYNC   =  11'd128 ,// 行同步 
                               P_H_BACK   =  11'd88  ,// 行显示后沿 
                               P_H_DISP   =  11'd800 ,// 行有效数据 
                               P_H_FRONT  =  11'd40  ,// 行显示前沿 
                               P_H_TOTAL  =  11'd1056,// 行扫描周期   
                                         
                               P_V_SYNC   =  11'd2   ,// 场同步 
                               P_V_BACK   =  11'd33  ,// 场显示后沿 
                               P_V_DISP   =  11'd480 ,// 场有效数据 
                               P_V_FRONT  =  11'd10  ,// 场显示前沿 
                               P_V_TOTAL  =  11'd525  // 场扫描周期               
) (
    // 时钟与复位接口                                     
    input                        i_lcd_pclk          ,// 时钟
    input                        i_rst               ,// 复位，高电平有效
                                           
    input        [23: 0]         i_pixel_data        ,// 像素数据

    output       [10: 0]         o_pixel_xpos        ,// 当前像素点横坐标
    output       [10: 0]         o_pixel_ypos        ,// 当前像素点纵坐标   
    output                       o_data_req          ,// 数据请求信号
    // RGB LCD接口                          
    output                       o_lcd_de            ,// LCD 数据使能信号
    output                       o_lcd_hs            ,// LCD 行同步信号
    output                       o_lcd_vs            ,// LCD 场同步信号
    output                       o_lcd_bl            ,// LCD 背光控制信号
    output                       o_lcd_clk           ,// LCD 像素时钟
    output                       o_lcd_rst           ,// LCD 复位
    output       [23: 0]         o_lcd_rgb            // LCD RGB888颜色数据 
);

//************************************** Regs ******************************************
    reg          [10: 0]         ro_pixel_xpos       ;
    reg          [10: 0]         ro_pixel_ypos       ;
    reg                          ro_data_req         ;
    reg                          ro_lcd_de           ;
                
    reg          [10: 0]         r_h_cnt             ;
    reg          [10: 0]         r_v_cnt             ;
 
//************************************ Always *****************************************

//行计数器对像素时钟计数
always@ (posedge i_lcd_pclk, posedge i_rst)  
begin
    if(i_rst)
        r_h_cnt <= 11'd0;
    else if(r_h_cnt == P_H_TOTAL - 1'b1)
        r_h_cnt <= 11'd0;
    else
        r_h_cnt <= r_h_cnt + 1'b1;
end

//场计数器对行计数
always@ (posedge i_lcd_pclk, posedge i_rst)  
begin
    if(i_rst)
        r_v_cnt <= 11'd0;
    else if((r_h_cnt == P_H_TOTAL - 1'b1) && (r_v_cnt == P_V_TOTAL - 1'b1))
        r_v_cnt <= 11'd0;
    else if((r_h_cnt == P_H_TOTAL - 1'b1) && (r_v_cnt != P_V_TOTAL - 1'b1))
        r_v_cnt <= r_v_cnt + 1'b1;
    else
        r_v_cnt <= r_v_cnt;    
end

//像素点x坐标
always@ (posedge i_lcd_pclk, posedge i_rst) 
begin
    if(i_rst)
        ro_pixel_xpos <= 11'd0;
    else if(ro_data_req)
        ro_pixel_xpos <= r_h_cnt + 2'd2 - P_H_SYNC - P_H_BACK ;
    else 
        ro_pixel_xpos <= 11'd0; 
end

//像素点y坐标
always@ (posedge i_lcd_pclk, posedge i_rst) 
begin
    if(i_rst)
        ro_pixel_ypos <= 11'd0;
    else if(r_v_cnt >= (P_V_SYNC + P_V_BACK) && r_v_cnt < (P_V_SYNC + P_V_BACK + P_V_DISP))
        ro_pixel_ypos <= r_v_cnt + 1'b1 - (P_V_SYNC + P_V_BACK) ;
    else 
        ro_pixel_ypos <= 11'd0;
end

//数据使能信号	
always@ (posedge i_lcd_pclk, posedge i_rst)  
begin
    if(i_rst)
        ro_lcd_de <= 1'b0;
    else
        ro_lcd_de <= ro_data_req;
end

//请求像素点颜色数据输入 
always@ (posedge i_lcd_pclk, posedge i_rst)  
begin
    if(i_rst)
        ro_data_req <= 1'b0;
    else if((r_h_cnt >= P_H_SYNC + P_H_BACK - 2'd2           ) &&
            (r_h_cnt <  P_H_SYNC + P_H_BACK + P_H_DISP - 2'd2) && 
            (r_v_cnt >= P_V_SYNC + P_V_BACK                  ) && 
            (r_v_cnt <  P_V_SYNC + P_V_BACK + P_H_DISP       ))
        ro_data_req <= 1'b1;
    else
        ro_data_req <= 1'b0;
end

//************************************ Assign *****************************************
assign o_pixel_xpos = ro_pixel_xpos;
assign o_pixel_ypos = ro_pixel_ypos;
assign o_data_req   = ro_data_req  ;
assign o_lcd_de     = ro_lcd_de    ;
    
//RGB LCD 采用DE模式时，行场同步信号需要拉高  
assign o_lcd_hs     = 1'b1         ;    //LCD行同步信号
assign o_lcd_vs     = 1'b1         ;    //LCD场同步信号
assign o_lcd_bl     = 1'b1         ;    //LCD背光控制信号  
assign o_lcd_clk    = i_lcd_pclk   ;    //LCD像素时钟
assign o_lcd_rst    = 1'b1         ;    //LCD复位    

//RGB888数据输出
assign o_lcd_rgb    = ro_lcd_de ? i_pixel_data : 24'd0;

endmodule
