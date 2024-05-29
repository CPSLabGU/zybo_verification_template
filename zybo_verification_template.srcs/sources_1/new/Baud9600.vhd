library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Baud9600 is
port(
    clk: in std_logic;
    pulse: out std_logic
);
end Baud9600;

architecture Behavioral of Baud9600 is
    signal periodCounter: integer range 0 to 260 := 0;
    signal baudPulse: std_logic := '0';
begin

    pulse <= baudPulse;

process(clk)
begin
if rising_edge(clk) then
    if periodCounter = 260 then
        baudPulse <= not baudPulse;
        periodCounter <= 1;
    else
        periodCounter <= periodCounter + 1;
    end if;
end if;
end process;

end Behavioral;