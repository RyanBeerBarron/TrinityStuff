----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/18/2018 07:15:20 PM
-- Design Name: 
-- Module Name: tb_decoder - Behavioral
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
use IEEE.NUMERIC_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_decoder is
--  Port ( );
end tb_decoder;

architecture Behavioral of tb_decoder is

    constant CLOCK_PERIOD : time := 100 ns;
    
    Component decoder3_8
        port ( A : in std_logic_vector(2 downto 0);
              Q0 : out std_logic;
              Q1 : out std_logic;
              Q2 : out std_logic;
              Q3 : out std_logic;
              Q4 : out std_logic;
              Q5 : out std_logic;
              Q6 : out std_logic;
              Q7 : out std_logic);
    end Component;
    
signal A : std_logic_vector(2 downto 0) := (others =>'0');
signal Q0, q1, q2, q3, q4, q5, q6, q7 : std_logic;                   

begin

dut: decoder3_8 PORT MAP(A=>A,q0=>q0,q1=>q1,q2=>q2,q3=>q3,q4=>q4,q5=>q5,q6=>q6,q7=>q7);

simulation : process

    procedure test(constant in0 : in natural) is 
        begin    
            A <= std_logic_vector(to_unsigned(in0, A'length));
            wait for CLOCK_PERIOD;
    end procedure test;        
    begin
    test(0);
    test(1);
    test(2);
    test(3);
    test(4);
    test(5);
    test(6);
    test(7);
    wait;
    end process simulation;
end Behavioral;
