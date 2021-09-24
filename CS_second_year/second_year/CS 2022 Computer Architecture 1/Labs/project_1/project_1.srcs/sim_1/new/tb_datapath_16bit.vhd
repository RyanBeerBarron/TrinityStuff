----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 11:54:57 PM
-- Design Name: 
-- Module Name: tb_datapath_16bit - Behavioral
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

entity tb_datapath_16bit is
--  Port ( );
end tb_datapath_16bit;

architecture Behavioral of tb_datapath_16bit is

    constant CLOCK_PERIOD : time := 150ns;
    
    component datapath_16bit
     port (  data_in, constant_in : in std_logic_vector(15 downto 0);
               Control_word : in std_logic_Vector (16 downto 0);
               address_out, data_out : out std_logic_Vector (15 downto 0);
               V, C, Z, N : out std_logic);
    end component;
    
    signal data_in, constant_in, address_out, data_out : std_logic_vector(15 downto 0);
    signal Control_word : std_logic_Vector(16 downto 0);
    signal V, c, z, n  : std_logic;

begin


    dut : datapath_16bit PORT MAP ( data_in => data_in, constant_in => constant_in, Control_word =>Control_word,
                                    address_out => address_out, data_out =>data_out, v=>v, c=>c, z=>z, n=>n);
     
     
    
      simulation : process
      
        procedure test (    constant control_vector : std_logic_vector( 16 downto 0);
                            constant data_input, constant_input : std_logic_vector ( 15 downto 0)) is
            begin
                Control_word(16 downto 0) <= control_vector;
                data_in <= data_input;
                constant_in <= constant_input;
                wait for CLOCK_PERIOD;
      end procedure test;
      
      begin
      wait for CLOCK_PERIOD;
      
        test("00111111110000011", x"1111", x"1111");
        test("01000111100000001", x"1111", x"1111");
        test("01101000100001001", x"1111", x"1111");
        test("11101101100000011", X"FFFF", x"0000");
        test("11100000010000011", x"8000", x"0000");
        test("11000000010000011", x"8000", x"0000");
        test("10111111000001001", x"eeee", x"eeee");
        test("10010110110000011", x"0000", x"0000");
        test("00010010000000001", x"1234", x"1234");
      
      end process simulation;        

end Behavioral;
