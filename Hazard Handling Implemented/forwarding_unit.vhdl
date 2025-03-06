library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Forwarding_Unit is
    Port (
        MEM_Rd  : in  std_logic_vector(4 downto 0);  -- Destination register in MEM stage
        WB_Rd   : in  std_logic_vector(4 downto 0);   -- Destination register in WB stage
        EX_Rs1  : in  std_logic_vector(4 downto 0);   -- Source register 1 in EX stage
        EX_Rs2  : in  std_logic_vector(4 downto 0);   -- Source register 2 in EX stage
        EX_ASel : out std_logic_vector(1 downto 0);   -- A select
        EX_BSel : out std_logic_vector(1 downto 0)    -- B select
    );
end Forwarding_Unit;

architecture Behavioral of Forwarding_Unit is
    begin
        process(MEM_Rd, WB_Rd, EX_Rs1, EX_Rs2)
        begin
            -- Default values for outputs
            EX_ASel <= "00";  -- Default: Use register file value for ALU input A
            EX_BSel <= "00";  -- Default: Use register file value for ALU input B
    
            -- Forwarding Logic (prioritize MEM stage over WB stage)
            if MEM_Rd /= "00000" then
                if MEM_Rd = EX_Rs1 then
                    EX_ASel <= "10";  -- Forward from EX/MEM
                end if;
                if MEM_Rd = EX_Rs2 then
                    EX_BSel <= "10"; -- Forward from EX/MEM
                end if;
            elsif WB_Rd /= "00000" then
                if WB_Rd = EX_Rs1 then
                    EX_ASel <= "11";  -- Forward from MEM/WB
                end if;
                if WB_Rd = EX_Rs2 then
                    EX_BSel <= "11"; -- Forward from MEM/WB
                end if;
            end if;
        end process;
    end Behavioral;