library IEEE;
use IEEE.std_logic_1164.all;

entity UARTTransmitter is
    port(
        clk: in std_logic;
        baudPulse: in std_logic;
        word: in std_logic_vector(0 to 7);
        ready: in std_logic;
        tx: out std_logic;
        busy: out std_logic
    );
end UARTTransmitter;

architecture Behavioral of UARTTransmitter is
    signal data: std_logic_vector(0 to 7) := x"00";
    signal bitCount: integer range 0 to 7 := 7;
    type UARTTransmitter_CurrentState_t is (Initial, WaitForReady, WaitForStopLow, WaitForStopPulse, WaitForDataLow, WaitForDataHigh, SentDataBit, WaitForBitPulse);
    signal currentState: UARTTransmitter_CurrentState_t := Initial;
begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            case currentState is
                when Initial =>
                    busy <= '0';
                    tx <= '1';
                    bitCount <= 7;
                    currentState <= WaitForReady;
                when WaitForReady =>
                    if (ready = '1') then
                        busy <= '1';
                        data <= word;
                        tx <= '1';
                        currentState <= WaitForStopLow;
                    else
                        tx <= '1';
                        busy <= '0';
                    end if;
                when WaitForStopLow =>
                    busy <= '1';
                    tx <= '1';
                    if (baudPulse = '0') then
                        currentState <= WaitForStopPulse;
                    end if;
                when WaitForStopPulse =>
                    busy <= '1';
                    if (baudPulse = '1') then
                        tx <= '0';
                        currentState <= WaitForDataLow;
                    else
                        tx <= '1';
                    end if;
                when WaitForDataLow =>
                    busy <= '1';
                    tx <= '0';
                    if (baudPulse = '0') then
                        currentState <= WaitForDataHigh;
                    end if;
                when WaitForDataHigh =>
                    busy <= '1';
                    if (baudPulse = '1') then
                        tx <= data(7);
                        currentState <= SentDataBit;
                    else
                        tx <= '0';
                    end if;
                when SentDataBit =>
                    tx <= data(bitCount);
                    busy <= '1';
                    if (baudPulse = '0') then
                        currentState <= WaitForBitPulse;
                    end if;
                when WaitForBitPulse =>
                    if (baudPulse = '1' and bitCount = 0) then
                        currentState <= WaitForReady;
                        tx <= '1';
                        bitCount <= 7;
                        busy <= '0';
                    elsif (baudPulse = '1') then
                        currentState <= SentDataBit;
                        tx <= data(bitCount - 1);
                        bitCount <= bitCount - 1;
                        busy <= '1';
                    else
                        tx <= data(bitCount);
                        busy <= '1';
                    end if;
                when others =>
                    currentState <= Initial;
            end case;
        end if;
    end process;
end Behavioral;
