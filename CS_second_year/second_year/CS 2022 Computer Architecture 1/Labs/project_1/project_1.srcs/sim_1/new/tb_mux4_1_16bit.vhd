----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 05:18:47 PM
-- Design Name: 
-- Module Name: tb_mux4_1_16bit - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_mux4_1_16bit is
--  Port ( );
end tb_mux4_1_16bit;

architecture Behavioral of tb_mux4_1_16bit is



     constant CLOCK_PERIOD : time := 100 ns;
     
     component mux4_1_16bit
            port (  src : in std_logic_vector(1 downto 0);
                    In1, In2, In3, In4 : in std_logic_vector ( 15 downto 0);
                    Out1 : out std_logic_vector ( 15 downto 0));
    end component;
    
    signal src : std_logic_vector ( 1 downto 0);
    signal In1, In2, In3, In4, Out1 : std_logic_vector ( 15 downto 0 );


begin

    dut : mux4_1_16bit PORT MAP ( src => src, In1 => In1, In2 => In2, In3 => In3, In4 => In4, Out1 => Out1);

    simulation : process 
        procedure test (    constant selector : std_logic_vector ( 1 downto 0)) is
        begin
            src <= selector;
            wait for CLOCK_PERIOD;
        end procedure test;                        

    begin
        In1 <= x"1111";
        In2 <= x"2222";
        In3 <= x"3333";
        In4 <= x"4444";
        wait for CLOCK_PERIOD;
        L1 : for index0 in 0 to 3 loop
            test(std_logic_vector(to_unsigned(index0,2)));
        end loop L1;
    end process simulation;    


end Behavioral;
