library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Branch_Jump_Decoder_tb is
end entity;

architecture Testbench of Branch_Jump_Decoder_tb is
    -- Component declaration
    component Branch_Jump_Decoder
        port(
            -- inputs
            Branch_in : in std_logic;
            Jump_in : in std_logic;
            Func3_in : in std_logic_vector(2 downto 0);
            Register_1_in : in std_logic_vector(31 downto 0);
            Register_2_in : in std_logic_vector(31 downto 0);
            Next_PC_in : in std_logic_vector(31 downto 0);

            -- outputs
            Reset_out : out std_logic;
            Mux_PC_out : out std_logic;
            Write_Enable_out : out std_logic;
            Next_PC_out : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Signals for inputs
    signal Branch_in : std_logic := '0';
    signal Jump_in : std_logic := '0';
    signal Func3_in : std_logic_vector(2 downto 0) := (others => '0');
    signal Register_1_in : std_logic_vector(31 downto 0) := (others => '0');
    signal Register_2_in : std_logic_vector(31 downto 0) := (others => '0');
    signal Next_PC_in : std_logic_vector(31 downto 0) := (others => '0');

    -- Signals for outputs
    signal Reset_out : std_logic;
    signal Mux_PC_out : std_logic;
    signal Write_Enable_out : std_logic;
    signal Next_PC_out : std_logic_vector(31 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: Branch_Jump_Decoder
        port map(
            Branch_in => Branch_in,
            Jump_in => Jump_in,
            Func3_in => Func3_in,
            Register_1_in => Register_1_in,
            Register_2_in => Register_2_in,
            Next_PC_in => Next_PC_in,

            Reset_out => Reset_out,
            Mux_PC_out => Mux_PC_out,
            Write_Enable_out => Write_Enable_out,
            Next_PC_out => Next_PC_out
        );

    -- Test process
    process
    begin
        -- Test 1.1: BEQ instruction, Register_1_in = Register_2_in
        Branch_in <= '1';
        Jump_in <= '0';
        Func3_in <= "000"; -- BEQ
        Register_1_in <= x"00000005";
        Register_2_in <= x"00000005";
        Next_PC_in <= x"00000011";
        wait for 10 ps;

        -- Test 1.2: BEQ instruction, Register_1_in != Register_2_in
        Branch_in <= '1';
        Jump_in <= '0';
        Func3_in <= "000"; -- BEQ
        Register_1_in <= x"00000005";
        Register_2_in <= x"00000004";
        Next_PC_in <= x"00000011";
        wait for 10 ps;

        -- Test 2.1: BNE instruction, Register_1_in != Register_2_in
        Func3_in <= "001"; -- BNE
        Register_1_in <= x"00000005";
        Register_2_in <= x"00000003";
        wait for 10 ps;

        -- Test 2.2: BNE instruction, Register_1_in = Register_2_in
        Func3_in <= "001"; -- BNE
        Register_1_in <= x"00000005";
        Register_2_in <= x"00000005";
        wait for 10 ps;

        -- Test 3.1: BLT instruction, Register_1_in < Register_2_in (signed)
        Func3_in <= "100"; -- BLT
        Register_1_in <= x"00000003";
        Register_2_in <= x"00000005";
        wait for 10 ps;

        -- Test 3.2: BLT instruction, Register_1_in = Register_2_in (signed)
        Func3_in <= "100"; -- BLT
        Register_1_in <= x"00000003";
        Register_2_in <= x"00000003";
        wait for 10 ps;

        -- Test 3.3: BLT instruction, Register_1_in > Register_2_in (signed)
        Func3_in <= "100"; -- BLT
        Register_1_in <= x"00000008";
        Register_2_in <= x"00000005";
        wait for 10 ps;

        -- Test 4.1: BGE instruction, Register_1_in >= Register_2_in (signed)
        Func3_in <= "101"; -- BGE
        Register_1_in <= x"00000005";
        Register_2_in <= x"00000003";
        wait for 10 ps;

        -- Test 4.2: BGE instruction, Register_1_in = Register_2_in (signed)
        Func3_in <= "101"; -- BGE
        Register_1_in <= x"00000003";
        Register_2_in <= x"00000003";
        wait for 10 ps;

        -- Test 4.3: BGE instruction, Register_1_in < Register_2_in (signed)
        Func3_in <= "101"; -- BGE
        Register_1_in <= x"00000002";
        Register_2_in <= x"00000003";
        wait for 10 ps;

        -- Test 5.1: BLTU instruction, Register_1_in < Register_2_in (unsigned)
        Func3_in <= "110"; -- BLTU
        Register_1_in <= x"00000001";
        Register_2_in <= x"00000005";
        wait for 10 ps;

        -- Test 5.2: BLTU instruction, Register_1_in > Register_2_in (unsigned)
        Func3_in <= "110"; -- BLTU
        Register_1_in <= x"00000006";
        Register_2_in <= x"00000005";
        wait for 10 ps;

        -- Test 5.3: BLTU instruction, Register_1_in = Register_2_in (unsigned)
        Func3_in <= "110"; -- BLTU
        Register_1_in <= x"00000005";
        Register_2_in <= x"00000005";
        wait for 10 ps;

        -- Test 6.1: BGEU instruction, Register_1_in >= Register_2_in (unsigned)
        Func3_in <= "111"; -- BGEU
        Register_1_in <= x"00000005";
        Register_2_in <= x"00000001";
        wait for 10 ps;

        -- Test 6.2: BGEU instruction, Register_1_in = Register_2_in (unsigned)
        Func3_in <= "111"; -- BGEU
        Register_1_in <= x"00000001";
        Register_2_in <= x"00000001";
        wait for 10 ps;

        -- Test 6.3: BGEU instruction, Register_1_in < Register_2_in (unsigned)
        Func3_in <= "111"; -- BGEU
        Register_1_in <= x"00000000";
        Register_2_in <= x"00000001";
        wait for 10 ps;

        -- Test 7: JUMP instruction
        Branch_in <= '0';
        Jump_in <= '1';
        wait for 10 ps;

        -- Stop the simulation
        wait;
    end process;

end architecture Testbench;
