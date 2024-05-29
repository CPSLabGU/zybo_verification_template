----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.05.2024 09:47:23
-- Design Name: 
-- Module Name: BRAMInterface - Behavioral
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

entity BRAMInterface is
    port(
        clk: in std_logic;
        address: in std_logic_vector(31 downto 0);
        read: in std_logic;
        ready: in std_logic;
        data: out std_logic_vector(31 downto 0);
        finished: out std_logic
    );
end BRAMInterface;

architecture Behavioral of BRAMInterface is

begin


end Behavioral;
