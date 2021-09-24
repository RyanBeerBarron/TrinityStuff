----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 04:48:21 PM
-- Design Name: 
-- Module Name: tb_arithmetic_circuit_16bit - Behavioral
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

entity tb_arithmetic_circuit_16bit is
--  Port ( );
end tb_arithmetic_circuit_16bit;

architecture Behavioral of tb_arithmetic_circuit_16bit is

    constant CLOCK_PERIOD : time := 150 ns;
    
    component Arithmetic_circuit_16bit
         port (  A, B : in std_logic_vector ( 15 downto 0);
               S0, S1, Cin : in std_logic;
               G : out std_logic_vector ( 15 downto 0);
               Cout, V : out std_logic);
    end component;
    
    signal A, B, G : std_logic_vector( 15 downto 0);
    signal S0, S1, Cin, Cout, V : std_logic;           

begin

    dut : Arithmetic_circuit_16bit PORT MAP ( A =>A, B =>B, S0 => S0, S1=>S1, Cin=>Cin, G=>G, Cout=>Cout, V => V);
    
    simulation : process
        
        procedure test( constant selector0, selector1, carryIn : std_logic) is
                        begin
                            S0 <= selector0;
                            S1 <= selector1;
                            Cin <= carryIn;
                            wait for CLOCK_PERIOD;
        end procedure test;    
    
    begin
        A <= x"4680";
        B <= x"2341";
        wait for CLOCK_PERIOD;
        L1 : for index0 in std_logic range '0' to '1' loop
            L2 : for index1 in std_logic range '0' to '1' loop
                L3 : for index2 in std_logic range '0' to '1' loop
                    test(index0, index1, index2);
                end loop L3;
            end loop L2;
        end loop L1;
        A <= x"8000";
        B <= x"8000";
        test('1','0','0');
    end process simulation;                
    
    
end Behavioral;
