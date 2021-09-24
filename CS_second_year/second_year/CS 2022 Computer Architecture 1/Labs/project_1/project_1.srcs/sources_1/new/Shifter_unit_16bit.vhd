----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 07:26:50 PM
-- Design Name: 
-- Module Name: Shifter_unit_16bit - Behavioral
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

entity Shifter_unit_16bit is
    port (  B : in std_logic_vector(15 downto 0);
            S : in std_logic_vector(1 downto 0);
            Ir, Il : in std_logic;
            H : out std_logic_vector(15 downto 0));
end Shifter_unit_16bit;

architecture Behavioral of Shifter_unit_16bit is

    component mux3_1
        port (  In1, In2, In3 : in std_logic;
                S : in std_logic_vector (1 downto 0);
                H : out std_logic); 
    end component;
    
begin

mux15 : mux3_1 PORT MAP ( In1 => B(15), In2 => Ir, In3 => B(14), S => S, H => H(15));
mux14 : mux3_1 PORT MAP ( In1 => B(14), In2 => B(15), In3 => B(13), S => S, H => H(14));
mux13 : mux3_1 PORT MAP ( In1 => B(13), In2 => B(14), In3 => B(12), S => S, H => H(13));
mux12 : mux3_1 PORT MAP ( In1 => B(12), In2 => B(13), In3 => B(11), S => S, H => H(12));
mux11 : mux3_1 PORT MAP ( In1 => B(11), In2 => B(12), In3 => B(10), S => S, H => H(11));
mux10 : mux3_1 PORT MAP ( In1 => B(10), In2 => B(11), In3 => B(9), S => S, H => H(10));
mux9 : mux3_1 PORT MAP ( In1 => B(9), In2 => B(10), In3 => B(8), S => S, H => H(9));
mux8 : mux3_1 PORT MAP ( In1 => B(8), In2 => B(9), In3 => B(7), S => S, H => H(8));
mux7 : mux3_1 PORT MAP ( In1 => B(7), In2 => B(8), In3 => B(6), S => S, H => H(7));
mux6 : mux3_1 PORT MAP ( In1 => B(6), In2 => B(7), In3 => B(5), S => S, H => H(6));
mux5 : mux3_1 PORT MAP ( In1 => B(5), In2 => B(6), In3 => B(4), S => S, H => H(5));
mux4 : mux3_1 PORT MAP ( In1 => B(4), In2 => B(5), In3 => B(3), S => S, H => H(4));
mux3 : mux3_1 PORT MAP ( In1 => B(3), In2 => B(4), In3 => B(2), S => S, H => H(3));
mux2 : mux3_1 PORT MAP ( In1 => B(2), In2 => B(3), In3 => B(1), S => S, H => H(2));
mux1 : mux3_1 PORT MAP ( In1 => B(1), In2 => B(2), In3 => B(0), S => S, H => H(1));
mux0 : mux3_1 PORT MAP ( In1 => B(0), In2 => B(1), In3 => Il, S => S, H => H(0));

end Behavioral;
