----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 09:41:37 PM
-- Design Name: 
-- Module Name: function_unit_16bit - Behavioral
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

entity function_unit_16bit is
    port (  A, B : in std_logic_vector ( 15 downto 0);
            FS : in std_logic_vector ( 4 downto 0);
            V, C, N, Z : out std_logic;
            G : out std_logic_vector ( 15 downto 0));
end function_unit_16bit;

architecture Behavioral of function_unit_16bit is

    component ALU_16bit
        port (  A, B : in std_logic_Vector ( 15 downto 0);
               S0, S1, S2, C0 : in std_logic;
               G : out std_logic_vector( 15 downto 0);
               Cout, V : out std_logic);
    end component;           

    component shifter_unit_16bit
        port (  B : in std_logic_vector(15 downto 0);
                S : in std_logic_vector(1 downto 0);
                Ir, Il : in std_logic;
                H : out std_logic_vector(15 downto 0));
    end component;

    component mux2_1_16bit
        port ( s : in std_logic;
              In0 : in std_logic_vector(15 downto 0);
              In1 : in std_logic_vector(15 downto 0);
              Z : out std_logic_vector(15 downto 0));
    end component;          

    signal S0, S1, S2, Smux, Carry_In : stD_logic;
    signal ALU_out, shifter_out, mux_out : std_logic_vector ( 15 downto 0);
    
begin

    S0 <= FS(1);
    S1 <= FS(2);
    S2 <= FS(3);
    Smux <= FS(4);
    Carry_In <= FS(0);
    
    ALU : ALU_16bit PORT MAP ( A => A, B=>B, S0 => S0, S1 => S1, S2 => S2, C0 => Carry_In, G => ALU_out, Cout => C, V=> V);
    Shifter : shifter_unit_16bit PORT MAP ( B => B, S(1) => S2, S(0) => S1, Ir => '0', Il => '0', H => shifter_out);
    mux : mux2_1_16bit PORT MAP ( s=> Smux, In0 => ALU_out, In1 => shifter_out, Z => mux_out);
    
    G <= mux_out;
    
    N <= ALU_out(15);
    
    Z <= not(ALU_out(15) or ALU_out(14) or ALU_out(13) or ALU_out(12) or ALU_out(11) or ALU_out(10) or ALU_out(9) or ALU_out(8) or ALU_out(7) or ALU_out(6) or ALU_out(5) or ALU_out(4) or ALU_out(3) or ALU_out(2) or ALU_out(1) or ALU_out(0));
    
end Behavioral;
