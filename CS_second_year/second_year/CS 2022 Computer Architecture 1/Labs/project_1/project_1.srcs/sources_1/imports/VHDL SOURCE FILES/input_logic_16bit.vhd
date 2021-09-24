----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2018 05:40:45 PM
-- Design Name: 
-- Module Name: input_logic_16bit - Behavioral
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

entity input_logic_16bit is
    port (  B : in std_logic_vector ( 15 downto 0);
            S0, S1 : in std_logic;
            Bout : out std_logic_vector ( 15 downto 0));
end input_logic_16bit;

architecture Behavioral of input_logic_16bit is

    component mux2_1
    port (  B, S0, S1 : in std_logic;
                Bout : out std_logic);
    end component;
    
    signal b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15 : std_logic;
    
begin
   
mux0 : mux2_1 PORT MAP(S0 => S0, S1 => S1, B => B(0), Bout => b0);   
mux1 : mux2_1 PORT MAP(S0 => S0, S1 => S1, B => B(1), Bout => b1);
mux2 : mux2_1 PORT MAP(S0 => S0, S1 => S1, B => B(2), Bout => b2);
mux3 : mux2_1 PORT MAP(S0 => S0, S1 => S1, B => B(3), Bout => b3);
mux4 : mux2_1 PORT MAP(S0 => S0, S1 => S1, B => B(4), Bout => b4);
mux5 : mux2_1 PORT MAP(S0 => S0, S1 => S1, B => B(5), Bout => b5);
mux6 : mux2_1 PORT MAP(S0 => S0, S1 => S1, B => B(6), Bout => b6);
mux7 : mux2_1 PORT MAP(S0 => S0, S1 => S1, B => B(7), Bout => b7);
mux8 : mux2_1 PORT MAP(S0 => S0, S1 => S1, B => B(8), Bout => b8);
mux9 : mux2_1 PORT MAP(S0 => S0, S1 => S1, B => B(9), Bout => b9);
mux10 : mux2_1 PORT MAP(S0 => S0, S1 => S1, B => B(10), Bout => b10);
mux11 : mux2_1 PORT MAP(S0 => S0, S1 => S1, B => B(11), Bout => b11);
mux12 : mux2_1 PORT MAP(S0 => S0, S1 => S1, B => B(12), Bout => b12);
mux13 : mux2_1 PORT MAP(S0 => S0, S1 => S1, B => B(13), Bout => b13);
mux14 : mux2_1 PORT MAP(S0 => S0, S1 => S1, B => B(14), Bout => b14);
mux15 : mux2_1 PORT MAP(S0 => S0, S1 => S1, B => B(15), Bout => b15);

Bout(0) <= b0;
Bout(1) <= b1;
Bout(2) <= b2;
Bout(3) <= b3;
Bout(4) <= b4;
Bout(5) <= b5;
Bout(6) <= b6;
Bout(7) <= b7;
Bout(8) <= b8;
Bout(9) <= b9;
Bout(10) <= b10;
Bout(11) <= b11;
Bout(12) <= b12;
Bout(13) <= b13;
Bout(14) <= b14;
Bout(15) <= b15;



end Behavioral;
