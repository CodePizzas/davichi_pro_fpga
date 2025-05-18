create_clock -period 20.000 -name i_clk -waveform {0.000 10.000} [get_ports i_clk];

set_property -dict {PACKAGE_PIN R4  IOSTANDARD LVCMOS15} [get_ports i_clk];

set_property -dict {PACKAGE_PIN L14 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[0]}];
set_property -dict {PACKAGE_PIN L13 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[1]}];
set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[2]}];
set_property -dict {PACKAGE_PIN K19 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[3]}];
set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[4]}];
set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[5]}];
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[6]}];
set_property -dict {PACKAGE_PIN M16 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[7]}];
set_property -dict {PACKAGE_PIN H14 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[8]}];
set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[9]}];
set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[10]}];
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[11]}];
set_property -dict {PACKAGE_PIN J16 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[12]}];
set_property -dict {PACKAGE_PIN K14 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[13]}];
set_property -dict {PACKAGE_PIN K13 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[14]}];
set_property -dict {PACKAGE_PIN L15 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[15]}];
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[16]}];
set_property -dict {PACKAGE_PIN G18 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[17]}];
set_property -dict {PACKAGE_PIN G15 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[18]}];
set_property -dict {PACKAGE_PIN G16 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[19]}];
set_property -dict {PACKAGE_PIN H19 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[20]}];
set_property -dict {PACKAGE_PIN J19 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[21]}];
set_property -dict {PACKAGE_PIN G13 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[22]}];
set_property -dict {PACKAGE_PIN H13 IOSTANDARD LVCMOS33} [get_ports {o_lcd_rgb[23]}];

set_property -dict {PACKAGE_PIN H18 IOSTANDARD LVCMOS33} [get_ports o_lcd_hs  ];
set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS33} [get_ports o_lcd_vs  ];
set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVCMOS33} [get_ports o_lcd_de  ];
set_property -dict {PACKAGE_PIN W9  IOSTANDARD LVCMOS15} [get_ports o_lcd_bl  ];
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports o_lcd_clk ];
set_property -dict {PACKAGE_PIN Y9  IOSTANDARD LVCMOS15} [get_ports o_lcd_rst ];
