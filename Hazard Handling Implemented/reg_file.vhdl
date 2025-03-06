library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity register_file is
  port(
    dataR1      : out std_logic_vector(31 downto 0);
    dataR2      : out std_logic_vector(31 downto 0);
    dataW       : in  std_logic_vector(31 downto 0);
    writeEnable : in  std_logic;
    rsR1        : in  std_logic_vector(4 downto 0);
    rsR2        : in  std_logic_vector(4 downto 0);
    clk         : in  std_logic;
    rsW         : in  std_logic_vector(4 downto 0)
  );
end register_file;

architecture behavioral of register_file is
  type registerFile is array(0 to 31) of std_logic_vector(31 downto 0);
  signal registers : registerFile := (
    others => (others => '0')  -- Initialize other registers to 0
  ); -- Initialize all registers to 0
begin

  -- **Asynchronous Read Process**
  process(rsR1, rsR2, registers)
  begin
    dataR1 <= registers(to_integer(unsigned(rsR1)));  -- Read register rsR1
    dataR2 <= registers(to_integer(unsigned(rsR2)));  -- Read register rsR2
  end process;

  -- **Asynchronous Write Process**
  process(dataW, rsW, writeEnable)
  begin
    if writeEnable = '1' and rsW /= "00000" then  -- Prevent writes to register 0
      registers(to_integer(unsigned(rsW))) <= dataW;
    end if;
  end process;

end behavioral;

