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
        port ( src : in std_logic_vector(2 downto 0);
                   dest : in std_logic_vector(2 downto 0);
                   Clk : in std_logic;
                   data_src : in std_logic;
                   data : in std_logic_vector(15 downto 0);
                   reg0 : out std_logic_vector(15 downto 0);
                   reg1 : out std_logic_vector(15 downto 0);
                   reg2 : out std_logic_vector(15 downto 0);
                   reg3 : out std_logic_vector(15 downto 0);
                   reg4 : out std_logic_vector(15 downto 0);
                   reg5 : out std_logic_vector(15 downto 0);
                   reg6 : out std_logic_vector(15 downto 0);
                   reg7  : out std_logic_vector(15 downto 0));
    end Component;
    
     signal src, dest : std_logic_vector(2 downto 0);
     signal data, reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7 : std_logic_vector(15 downto 0);
     signal Clk, data_src : std_logic;                  

begin

    dut : register_file_16bit PORT MAP ( src =>src, dest =>dest, Clk =>Clk, data_src =>data_src, data => data,
    reg0 =>reg0, reg1 =>reg1, reg2 =>reg2, reg3 =>reg3, reg4 =>reg4, reg5 =>reg5, reg6 =>reg6, reg7 =>reg7);
    
    clk_generation : process
    begin 
        CLK <= '1';
        wait for CLOCK_PERIOD/2;
        CLK <= '0';
        wait for CLOCK_PERIOD/2;
    end process clk_generation;
    
    simulation : process
    variable source : Integer := 0;
    variable destination : Integer := 0;
    variable data_array : std_logic_vector(15 downto 0) := x"AAAA";
    
    procedure test(constant source, destination : std_logic_vector(2 downto 0);
                   constant data_source : std_logic;
                   constant data_vector : std_logic_vector(15 downto 0)) is
                begin
                src <= source;
                dest <= destination;
                data_src <= data_source;
                data <= data_vector;
                wait for CLOCK_PERIOD;
    end procedure test;
                
    begin
        wait for CLOCK_PERIOD;
        L1 : for destination in 0 to 7 loop
            test("---", std_logic_vector(to_unsigned(destination, 3)), '0', data_array);
        end loop L1;
        wait for CLOCK_PERIOD;
        
        source := 0;
        destination := 0;
        wait for CLOCK_PERIOD;
        L2 : for source in 0 to 7 loop
            case source is
                when 0 => test("---", std_logic_vector(to_unsigned(source, 3)), '0', x"1111");
                when 1 => test("---", std_logic_vector(to_unsigned(source, 3)), '0', x"2222");
                when 2 => test("---", std_logic_vector(to_unsigned(source, 3)), '0', x"3333");
                when 3 => test("---", std_logic_vector(to_unsigned(source, 3)), '0', x"4444");
                when 4 => test("---", std_logic_vector(to_unsigned(source, 3)), '0', x"5555");
                when 5 => test("---", std_logic_vector(to_unsigned(source, 3)), '0', x"6666");
                when 6 => test("---", std_logic_vector(to_unsigned(source, 3)), '0', x"7777");
                when 7 => test("---", std_logic_vector(to_unsigned(source, 3)), '0', x"8888");
                when others =>test("---", std_logic_vector(to_unsigned(source, 3)), '0', x"ffff");
            end case;        
            L3 : for destination in 0 to 7 loop
            test(std_logic_vector(to_unsigned(source, 3)), std_logic_vector(to_unsigned(destination, 3)), '1', data_array);
            end loop L3;
        end loop L2;      
        wait;
        
    end process simulation;    
        
end Behavioral;
