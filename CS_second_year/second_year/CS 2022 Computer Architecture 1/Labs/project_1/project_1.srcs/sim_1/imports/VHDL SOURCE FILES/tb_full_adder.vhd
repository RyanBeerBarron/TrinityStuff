----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2018 03:09:53 PM
-- Design Name: 
-- Module Name: tb_full_adder - Behavioral
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

entity tb_full_adder is
--  Port ( );
end tb_full_adder;

architecture Behavioral of tb_full_adder is

constant CLOCK_PERIOD : time := 100ns;

component full_adder
    port (  x : in std_logic;
            y : in std_logic;
            Cin : in std_logic;
            Cout : out std_logic;
            sum : out std_logic);
    end component;
    
 signal x, y, Cin, Cout, sum : std_logic;           

begin

dut : full_adder PORT MAP( x =>x, y =>y, Cin =>Cin, Cout =>Cout, sum =>sum);

simulation : process
    procedure test(constant in1, in2, in3 : std_logic) is 
        begin
            x <= in1;
            y <= in2;
            Cin <= in3;
            wait for CLOCK_PERIOD;
    end procedure test;
    
    begin 
    L1 : for x in std_logic range '0' to '1' loop
        L2 : for y in std_logic range '0' to '1' loop
            L3 : for Cin in std_logic range '0' to '1' loop
                test(x, y, Cin);
            end loop L3;
        end loop L2;
    end loop L1;

end process simulation;                        

end Behavioral;
