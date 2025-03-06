library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_unit is
  port (
    clk_out : out std_logic -- Clock output
  );
end clock_unit;

architecture Behavioral of clock_unit is
  constant clk_period : time := 50 ns;
  signal clk_signal : std_logic := '0'; -- Internal clock signal
begin
  -- Clock generation process
  clock_process: process
  begin
    while True loop
      clk_signal <= '0'; -- Set clock high
      wait for clk_period / 2; -- Half the clock period
      clk_signal <= '1'; -- Set clock low
      wait for clk_period / 2; -- Half the clock period
    end loop;
  end process;

  -- Assign the internal clock signal to the output
  clk_out <= clk_signal;
end Behavioral;
