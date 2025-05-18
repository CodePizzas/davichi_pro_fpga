/************************************ Copyright(c) 202 *******************************

   Project name  : lcd_colorbar
   File name     : lcd_colorbar.v
   Module name   : lcd_colorbar5
   Generated     : 2024-05-07 20:41:00
   Last modified : 2024-05-07 20:41:00
   Target Device : Xilinx XC7A35TFGG484-2
   Tool Versions : Vivado ML 2022.1
   Author        : Code Pizzas
   E-Mail        : code.pizzas@gmail.cn
   Description   : RGB-888 LCD colorbar example program 
   
********************************** All rights reserved ********************************/

//*************************** Module, Parameters & Ports *******************************
module lcd_colorbar #(
    parameter                    P_H_SYNC   =  11'd128 ,            // 行同步 
                                 P_H_BACK   =  11'd88  ,            // 行显示后沿 
                                 P_H_DISP   =  11'd800 ,            // 行有效数据 
                                 P_H_FRONT  =  11'd40  ,            // 行显示前沿 
                                 P_H_TOTAL  =  11'd1056,            // 行扫描周期 
                                                            
                                 P_V_SYNC   =  11'd2   ,            // 场同步 
                                 P_V_BACK   =  11'd33  ,            // 场显示后沿 
                                 P_V_DISP   =  11'd480 ,            // 场有效数据 
                                 P_V_FRONT  =  11'd10  ,            // 场显示前沿 
                                 P_V_TOTAL  =  11'd525              // 场扫描周期  
) (
    input                                       i_clk               ,// System clock:50MHz
    //RGB LCD接口             
    output                                      o_lcd_de            ,// LCD 数据使能信号
    output                                      o_lcd_hs            ,// LCD 行同步信号
    output                                      o_lcd_vs            ,// LCD 场同步信号
    output                                      o_lcd_bl            ,// LCD 背光控制信号
    output                                      o_lcd_clk           ,// LCD 像素时钟
    output                                      o_lcd_rst           ,// LCD 复位
    output            [  23: 0]                 o_lcd_rgb            // LCD RGB888颜色数据
);
    
//************************************ Wires *****************************************
wire                                w_sys_rst                   ;
wire                                w_pclk                      ;
wire               [  10: 0]        w_pixel_xpos                ;//当前像素点横坐标
wire               [  10: 0]        w_pixel_ypos                ;//当前像素点纵坐标   
wire               [  23: 0]        w_pixel_data                ;//像素数据
wire                                w_data_req                  ;

//******************************** Instantiations ************************************
clk_wiz_pclk u_clk_wiz_pclk (
    .sys_clk                            (i_clk                     ),// input: 50MHz
    .lcd_pclk                           (w_pclk                    ),// output：33.3MHz
    .locked                             (w_sys_rst                 ) 
);

lcd_display # (
    .P_H_DISP                           (P_H_DISP                  ),
    .P_V_DISP                           (P_V_DISP                  ) 
)
u_lcd_display (
    .i_lcd_pclk                         (w_pclk                    ),
    .i_rst                              (~w_sys_rst                ),
    .i_pixel_xpos                       (w_pixel_xpos              ),
    .i_pixel_ypos                       (w_pixel_ypos              ),
    .o_pixel_data                       (w_pixel_data              ) 
);

lcd_driver # (
    .P_H_SYNC                           (P_H_SYNC                  ),
    .P_H_BACK                           (P_H_BACK                  ),
    .P_H_DISP                           (P_H_DISP                  ),
    .P_H_FRONT                          (P_H_FRONT                 ),
    .P_H_TOTAL                          (P_H_TOTAL                 ),
    .P_V_SYNC                           (P_V_SYNC                  ),
    .P_V_BACK                           (P_V_BACK                  ),
    .P_V_DISP                           (P_V_DISP                  ),
    .P_V_FRONT                          (P_V_FRONT                 ),
    .P_V_TOTAL                          (P_V_TOTAL                 ) 
)
u_lcd_driver (
    .i_lcd_pclk                         (w_pclk                    ),
    .i_rst                              (~w_sys_rst                ),
    .i_pixel_data                       (w_pixel_data              ),
    .o_pixel_xpos                       (w_pixel_xpos              ),
    .o_pixel_ypos                       (w_pixel_ypos              ),
    .o_data_req                         (o_data_req                ),
    .o_lcd_de                           (o_lcd_de                  ),
    .o_lcd_hs                           (o_lcd_hs                  ),
    .o_lcd_vs                           (o_lcd_vs                  ),
    .o_lcd_bl                           (o_lcd_bl                  ),
    .o_lcd_clk                          (o_lcd_clk                 ),
    .o_lcd_rst                          (o_lcd_rst                 ),
    .o_lcd_rgb                          (o_lcd_rgb                 ) 
);

endmodule
