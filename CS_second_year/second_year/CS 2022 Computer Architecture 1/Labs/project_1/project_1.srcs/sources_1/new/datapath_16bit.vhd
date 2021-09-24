----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 11:11:45 PM
-- Design Name: 
-- Module Name: datapath_16bit - Behavioral
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

entity datapath_16bit is
    port (  data_in, constant_in : std_logic_vector(15 downto 0);
            Control_word : in std_logic_Vector (16 downto 0);
            address_out, data_out : out std_logic_Vector (15 downto 0);
            V, C, Z, N : out std_logic);
end datapath_16bit;

architecture Behavioral of datapath_16bit is

    component function_unit_16bit
     port (  A, B : in std_logic_vector ( 15 downto 0);
               FS : in std_logic_vector ( 4 downto 0);
               V, C, N, Z : out std_logic;
               G : out std_logic_vector ( 15 downto 0));
    end component;
    
    
    component register_file_16bit
    port ( select_a, select_b : in std_logic_vector(2 downto 0);
               dest : in std_logic_vector(2 downto 0);
               write_enable : in std_logic;
               data : in std_logic_vector(15 downto 0);
               data_a : out std_logic_vector(15 downto 0);
               data_b : out std_logic_Vector(15 downto 0)); 
    end component;           
    
    component mux2_1_16bit
    port ( s : in std_logic;
               In0 : in std_logic_vector(15 downto 0);
               In1 : in std_logic_vector(15 downto 0);
               Z : out std_logic_vector(15 downto 0));
    end component;           
    
    
    signal function_unit_out, register_file_a, register_file_b, mux_b, mux_d : std_logic_vector(15 downto 0);
begin

    function_unit : function_unit_16bit PORT MAP (A => register_file_a, B=> mux_b, FS => Control_word(6 downto 2), V=>V, c=>c, n=>n, z=>z, g=>function_unit_out);
    
    register_file : register_file_16bit PORT MAP ( select_a => Control_word(13 downto 11), select_b => Control_word(10 downto 8), dest => Control_word(16 downto 14), write_enable =>Control_word(0), data =>mux_d, data_a => register_file_a, data_b => register_file_b);
    
    mux1 : mux2_1_16bit PORT MAP (s => Control_word(7), In0 =>constant_in, In1 => register_file_b, Z => mux_b);
    
    mux2 : mux2_1_16bit PORT MAP (s => Control_word(1), In0 => function_unit_out, In1=> data_in, Z => mux_d);
    
    address_out <= register_file_a;
    
    data_out <= register_file_b;
    

end Behavioral;
