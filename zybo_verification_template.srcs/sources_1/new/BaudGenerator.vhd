library IEEE;
use IEEE.std_logic_1164.all;

entity BaudGenerator is
    port(
        clk: in std_logic;
        pulse: out std_logic
    );
end BaudGenerator;

architecture Behavioral of BaudGenerator is
    signal periodCounter: integer range 0 to 260 := 0;
    signal baudPulse: std_logic := '0';
begin
    pulse <= baudPulse;
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (periodCounter = 260) then
                baudPulse <= not baudPulse;
                periodCounter <= 1;
            else
                periodCounter <= periodCounter + 1;
            end if;
        end if;
    end process;
end Behavioral;
