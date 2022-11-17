
## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project
 
## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]
    set_property IOSTANDARD LVCMOS33 [get_ports clk]
    create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## Switches
## 6*8 => 6 multiplicando y 8 multiplicador
## Multiplicandor (osea el 8)
set_property PACKAGE_PIN V17 [get_ports {mp[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {mp[0]}]
    
set_property PACKAGE_PIN V16 [get_ports {mp[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {mp[1]}]
    
set_property PACKAGE_PIN W16 [get_ports {mp[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {mp[2]}]
    
set_property PACKAGE_PIN W17 [get_ports {mp[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {mp[3]}]
    
    
 set_property PACKAGE_PIN W15 [get_ports {mp[4]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {mp[4]}]
        
set_property PACKAGE_PIN V15 [get_ports {mp[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {mp[5]}]
    
set_property PACKAGE_PIN W14 [get_ports {mp[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {mp[6]}]
    
set_property PACKAGE_PIN W13 [get_ports {mp[7]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {mp[7]}]   
    
    
    
## Multiplicando (osea el 6)
set_property PACKAGE_PIN V2 [get_ports {mc[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {mc[0]}]
    
set_property PACKAGE_PIN T3 [get_ports {mc[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {mc[1]}]
    
set_property PACKAGE_PIN T2 [get_ports {mc[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {mc[2]}]
    
set_property PACKAGE_PIN R3 [get_ports {mc[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {mc[3]}]
    
    
 set_property PACKAGE_PIN W2 [get_ports {mc[4]}]
        set_property IOSTANDARD LVCMOS33 [get_ports {mc[4]}]
        
set_property PACKAGE_PIN U1 [get_ports {mc[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {mc[5]}]
    
set_property PACKAGE_PIN T1 [get_ports {mc[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {mc[6]}]
    
set_property PACKAGE_PIN R2 [get_ports {mc[7]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {mc[7]}] 


##Buttons
set_property PACKAGE_PIN U18 [get_ports start]                        
    set_property IOSTANDARD LVCMOS33 [get_ports start]
   
    
## LEDs
set_property PACKAGE_PIN U16 [get_ports {prod[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {prod[0]}]
	
set_property PACKAGE_PIN E19 [get_ports {prod[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {prod[1]}]
	
set_property PACKAGE_PIN U19 [get_ports {prod[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {prod[2]}]
	
set_property PACKAGE_PIN V19 [get_ports {prod[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {prod[3]}]
	
set_property PACKAGE_PIN W18 [get_ports {prod[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {prod[4]}]
	
set_property PACKAGE_PIN U15 [get_ports {prod[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {prod[5]}]
	
set_property PACKAGE_PIN U14 [get_ports {prod[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {prod[6]}]
	
set_property PACKAGE_PIN V14 [get_ports {prod[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {prod[7]}]
	
set_property PACKAGE_PIN V13 [get_ports {prod[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {prod[8]}]
	
set_property PACKAGE_PIN V3 [get_ports {prod[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {prod[9]}]
	
set_property PACKAGE_PIN W3 [get_ports {prod[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {prod[10]}]
	
set_property PACKAGE_PIN U3 [get_ports {prod[11]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {prod[11]}]
	
set_property PACKAGE_PIN P3 [get_ports {prod[12]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {prod[12]}]
	
set_property PACKAGE_PIN N3 [get_ports {prod[13]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {prod[13]}]
	
set_property PACKAGE_PIN P1 [get_ports {prod[14]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {prod[14]}]
	
set_property PACKAGE_PIN L1 [get_ports {prod[15]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {prod[15]}]


## Display

set_property PACKAGE_PIN U7 [get_ports busy]
    set_property IOSTANDARD LVCMOS33 [get_ports busy]
