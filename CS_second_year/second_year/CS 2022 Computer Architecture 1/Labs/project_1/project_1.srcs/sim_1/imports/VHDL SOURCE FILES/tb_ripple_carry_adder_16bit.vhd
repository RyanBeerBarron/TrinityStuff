----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2018 04:32:04 PM
-- Design Name: 
-- Module Name: tb_ripple_carry_adder_16bit - Behavioral
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

entity tb_ripple_carry_adder_16bit is
--  Port ( );
end tb_ripple_carry_adder_16bit;

architecture Behavioral of tb_ripple_carry_adder_16bit is


      constant CLOCK_PERIOD : time := 150 ns;
    
      Component ripple_carry_adder_16bit
      port (  x, y : in std_logic_vector (15 downto 0);
              C0 : in std_logic;
              Cout, V : out std_logic;
              S : out std_logic_vector (15 downto 0)); 
      end component;
      
      signal x, y, s : std_logic_vector (15 downto 0);
      signal C0, Cout, V : std_logic;        
    
begin

dut : ripple_carry_adder_16bit PORT MAP ( x=>x, y=>y, s=>s, c0=>c0, cout =>cout, V => V);

simulation : process 

    procedure test ( constant inV1, inV2 : std_logic_vector(0 to 15);
                     constant in1 : std_logic) is
                     begin
                        x <= inV1;
                        y <= inV2;
                        c0 <= in1;
                        wait for CLOCK_PERIOD;
    end procedure test;
    
begin
   test(x"1234",x"6798",'0');
   test(x"1234",x"6798",'1');
   test(x"1111",x"ffff",'0');
   test(x"5555",x"ffff",'1');
   test(x"3344",x"4433",'0');
   test(x"8000",x"8000",'0');
end process simulation;                        

end Behavioral;
