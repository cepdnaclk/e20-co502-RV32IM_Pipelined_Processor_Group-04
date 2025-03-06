library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ImmGen is
    port (
        inst   : in  std_logic_vector(31 downto 0); -- Instruction (input)
        ImmSel : in  std_logic_vector(2 downto 0); -- Immediate select signal
        imm    : out std_logic_vector(31 downto 0) -- Immediate output
    );
end ImmGen;

architecture Behavioral of ImmGen is
begin
    process(inst, ImmSel)
        variable immediate : std_logic_vector(31 downto 0); -- Immediate value
    begin
        case ImmSel is
            -- I-Type
            when "000" =>
                immediate := (31 downto 12 => inst(31)) & inst(31 downto 20);

            -- S-Type
            when "001" =>
                immediate := (31 downto 11 => inst(31)) & inst(30 downto 25) & inst(11 downto 7);

            -- B-Type
            when "010" =>
                immediate := (31 downto 13 => inst(31)) & inst(31) & inst(7) & inst(30 downto 25) & inst(11 downto 8) & '0';

            -- J-Type
            when "011" =>
                immediate := (31 downto 20 => inst(31)) & inst(19 downto 12) & inst(11) & inst(20) & inst(30 downto 21);

            -- U-Type
            when "100" =>
                immediate := inst(31 downto 12) & (11 downto 0 => '0');

            -- Default case: Immediate is zero
            when others =>
                immediate := (others => '0');
        end case;

        imm <= immediate; -- Assign the computed immediate to the output
    end process;
end Behavioral;
