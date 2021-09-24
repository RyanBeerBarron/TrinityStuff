----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2018 05:47:13 PM
-- Design Name: 
-- Module Name: tb_mux2_1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_mux2_1 is
--  Port ( );
end tb_mux2_1;

architecture Behavioral of tb_mux2_1 is

    CONSTANT CLOCK_PERIOD : TIME := 10 ns;
    
    Component mux2_1
    port (  B, S0, S1 : in std_logic;
                Bout : out std_logic);
    end component;
    
    signal B, S0, S1, Bout : std_logic;
    
begin

    dut : mux2_1 PORT MAP (B=> B, S0=> S0, S1=> S1, Bout=> Bout);
    
    simulation : process
    
        procedure test ( constant selector, in1, in2 : in std_logic) is
        begin
            B <= selector;
            S0 <= in1;
            S1 <= in2;
            wait for CLOCK_PERIOD;
        end procedure test;
        
    begin
    
        L1 : for B in stD_logic range '0' to '1' loop
            L2 : for S0 in std_logic range '0' to '1' loop
                L3 : for S1 in std_logic range '0' to '1' loop
                    test(B, S0, S1);
                end loop L3;
            end loop L2;
        end loop L1;
        
    end process simulation;                    
            
end Behavioral;
