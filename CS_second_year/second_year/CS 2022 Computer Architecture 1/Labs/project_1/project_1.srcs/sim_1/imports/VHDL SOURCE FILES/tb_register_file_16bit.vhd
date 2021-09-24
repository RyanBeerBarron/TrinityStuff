----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/18/2018 08:53:47 PM
-- Design Name: 
-- Module Name: tb_register_file_16bit - Behavioral
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

entity tb_register_file_16bit is
--  Port ( );
end tb_register_file_16bit;

architecture Behavioral of tb_register_file_16bit is

    CONSTANT CLOCK_PERIOD : TIME := 10 ns;
    
    
    Component register_file_16bit
       port ( select_a, select_b : in std_logic_vector(2 downto 0);
               dest : in std_logic_vector(2 downto 0);
               write_enable : in std_logic;
               data : in std_logic_vector(15 downto 0);
               data_a : out std_logic_vector(15 downto 0);
               data_b : out std_logic_Vector(15 downto 0)); 
    end Component;
    
     signal select_a, select_b, dest : std_logic_vector(2 downto 0);
     signal data, data_a, data_b : std_logic_vector(15 downto 0);
     signal write_enable : std_logic;                  

begin

    dut : register_file_16bit PORT MAP(select_a=>select_a, select_b=>select_b, dest=>dest, write_enable=>write_enable, data => data,
    data_a=>data_a, data_b=>data_b);
    
    
    simulation : process
    variable source : Integer := 0;
    variable destination : Integer := 0;
    variable data_array : std_logic_vector(15 downto 0) := x"AAAA";
    
    procedure test(constant source_a, source_b, destination : std_logic_vector(2 downto 0);
                   constant load : std_logic;
                   constant data_vector : std_logic_vector(15 downto 0)) is
                begin
                select_a <= source_a;
                select_b <= source_b;
                dest <= destination;
                write_enable <= load;
                data <= data_vector;
                wait for CLOCK_PERIOD;
    end procedure test;
                
    begin
        wait for CLOCK_PERIOD;
        test("000", "001", "000", '1', x"1234");
        test("000", "001", "001", '1', x"5678");
        test("000", "001", "000", '0', x"ffff");
        test("000", "001", "000", '0', x"0000");
        wait;
        
    end process simulation;    
        
end Behavioral;
