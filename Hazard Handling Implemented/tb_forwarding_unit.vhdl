library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Forwarding_Unit_TB is
end Forwarding_Unit_TB;

architecture Behavioral of Forwarding_Unit_TB is

    -- Component Declaration for the Unit Under Test (UUT)
    component Forwarding_Unit
        Port (
            MEM_Rd  : in  std_logic_vector(4 downto 0);
            WB_Rd   : in  std_logic_vector(4 downto 0);
            EX_Rs1  : in  std_logic_vector(4 downto 0);
            EX_Rs2  : in  std_logic_vector(4 downto 0);
            EX_ASel : out std_logic_vector(1 downto 0);
            EX_BSel : out std_logic_vector(1 downto 0)
        );
    end component;

    -- Signals for connecting to UUT
    signal MEM_Rd_tb  : std_logic_vector(4 downto 0);
    signal WB_Rd_tb   : std_logic_vector(4 downto 0);
    signal EX_Rs1_tb  : std_logic_vector(4 downto 0);
    signal EX_Rs2_tb  : std_logic_vector(4 downto 0);
    signal EX_ASel_tb : std_logic_vector(1 downto 0);
    signal EX_BSel_tb : std_logic_vector(1 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: Forwarding_Unit
        port map (
            MEM_Rd  => MEM_Rd_tb,
            WB_Rd   => WB_Rd_tb,
            EX_Rs1  => EX_Rs1_tb,
            EX_Rs2  => EX_Rs2_tb,
            EX_ASel => EX_ASel_tb,
            EX_BSel => EX_BSel_tb
        );

    -- Test Process
    process
    begin
        -- Test Case 1: No Forwarding (Default)
        MEM_Rd_tb  <= "00000";  -- No valid register
        WB_Rd_tb   <= "00000";
        EX_Rs1_tb  <= "00001";
        EX_Rs2_tb  <= "00010";
        wait for 10 ns;

        -- Test Case 2: Forward from EX/MEM
        MEM_Rd_tb  <= "00001";  -- Matches EX_Rs1
        WB_Rd_tb   <= "00000";
        EX_Rs1_tb  <= "00001";
        EX_Rs2_tb  <= "00010";
        wait for 10 ns;

        -- Test Case 3: Forward from EX/MEM to EX_Rs2
        MEM_Rd_tb  <= "00010";  -- Matches EX_Rs2
        WB_Rd_tb   <= "00000";
        EX_Rs1_tb  <= "00001";
        EX_Rs2_tb  <= "00010";
        wait for 10 ns;

        -- Test Case 4: Forward from MEM/WB
        MEM_Rd_tb  <= "00000";
        WB_Rd_tb   <= "00001";  -- Matches EX_Rs1
        EX_Rs1_tb  <= "00001";
        EX_Rs2_tb  <= "00010";
        wait for 10 ns;

        -- Test Case 5: Forward from MEM/WB to EX_Rs2
        MEM_Rd_tb  <= "00000";
        WB_Rd_tb   <= "00010";  -- Matches EX_Rs2
        EX_Rs1_tb  <= "00001";
        EX_Rs2_tb  <= "00010";
        wait for 10 ns;

        -- End of Simulation
        wait;
    end process;
end Behavioral;
