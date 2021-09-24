----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 10:03:07 PM
-- Design Name: 
-- Module Name: tb_function_unit_16bit - Behavioral
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

entity tb_function_unit_16bit is
--  Port ( );
end tb_function_unit_16bit;

architecture Behavioral of tb_function_unit_16bit is

    constant CLOCK_PERIOD : time := 150 ns;

    component function_unit_16bit
        port (  A, B : in std_logic_vector ( 15 downto 0);
               FS : in std_logic_vector ( 4 downto 0);
               V, C, N, Z : out std_logic;
               G : out std_logic_vector ( 15 downto 0));
    end component;
    
    signal A, B, G : std_logic_vector (15 downto 0);
    signal V, C, N, Z : stD_logic;
    signal FS : std_logic_vector ( 4 downto 0);
    
    
begin

    dut : function_unit_16bit PORT MAP (A =>A, B=>B, G=>G, FS=>FS, V=>V, C=>C, N=>N, Z=>Z);

    simulation : process
    
        procedure test( constant input1, input2 : std_logic_vector (15 downto 0);
                        constant selector : std_logic_vector ( 4 downto 0)) is
            begin
                A <= input1;
                B <= input2;
                FS <= selector;
                wait for CLOCK_Period;
        end procedure test;        
    
    begin 
    
        test(x"0000", x"ffff", "00000");
        test(x"0000", x"ffff", "00001");
        test(x"8000", x"8000", "00010");
        test(x"8000", x"8000", "00011");
        test(x"5555", x"4444", "00100");
        test(x"5555", x"4444", "00101");
        test(x"5555", X"4444", "00110");
        test(x"5555", x"4444", "00111");
        test(x"00ff", x"0f0f", "01000");
        test(x"00ff", x"0f0f", "01010");
        test(x"ffff", X"0f0f", "01100");
        test(x"aaaa", x"ffff", "01110");
        test(x"ffff", x"1111", "10000");
        test(x"ffff", x"1111", "10100");
        test(x"ffff", x"1111", "11000");

    end process simulation;
    
end Behavioral;
