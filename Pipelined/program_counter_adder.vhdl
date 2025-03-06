library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC_Adder is
    port (
        pc_in  : in  std_logic_vector(31 downto 0); -- Input PC value
        pc_out : out std_logic_vector(31 downto 0)  -- Incremented PC value
    );
end PC_Adder;

architecture Behavioral of PC_Adder is
begin
    -- Increment the PC by 4
    pc_out <= std_logic_vector(unsigned(pc_in) + 4);
end Behavioral;
