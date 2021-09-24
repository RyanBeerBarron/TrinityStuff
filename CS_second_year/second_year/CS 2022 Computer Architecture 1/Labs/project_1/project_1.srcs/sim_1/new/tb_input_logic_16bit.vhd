----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2018 06:46:35 PM
-- Design Name: 
-- Module Name: tb_input_logic_16bit - Behavioral
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

entity tb_input_logic_16bit is
--  Port ( );
end tb_input_logic_16bit;

architecture Behavioral of tb_input_logic_16bit is

    constant CLOCK_PERIOD : time := 15 ns;
    
    Component input_logic_16bit
    port (  B : in std_logic_vector ( 15 downto 0);
               S0, S1 : in std_logic;
               Bout : out std_logic_vector ( 15 downto 0));
    end component;
    
    signal B, Bout : std_logic_vector ( 15 downto 0);
    signal S0, S1 : std_logic;           

begin
    
    dut : input_logic_16bit PORT MAP ( B => B, Bout => Bout, S0 => S0, S1=> S1);
    
    simulation : process
        
        procedure test( constant vectorIn : std_logic_vector ( 15 downto 0 );
                        constant selector1, selector2 : std_logic) is
                        begin
                            B <= vectorIn;
                            S0 <= selector1;
                            S1 <= selector2;
                            wait for CLOCK_PERIOD;    
        end procedure test;
    
    
    begin
        L1 : for index0 in std_logic range '0' to '1' loop
            L2 : for index1 in std_logic range '0' to '1' loop
                test(x"5678", index0, index1);
            end loop L2;
        end loop L1;
    end process simulation;        
    
end Behavioral;
