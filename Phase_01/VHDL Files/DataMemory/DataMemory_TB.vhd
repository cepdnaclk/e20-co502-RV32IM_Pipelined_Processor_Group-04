--- Instruction     DMEMOP     
--- lb              000
--- lh              001
--- lw              010
--- lbu             011
--- lhu             100
--- sb              101
--- sh              110
--- sw              111


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity DataMemory_TB is
end DataMemory_TB;


architecture DataMemory_Architecture of DataMemory_TB is

    -- Declaration of Signals

    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal DMEMOP : std_logic_vector(2 downto 0);
    signal input_Address : std_logic_vector (31 downto 0) := (others => '0');
    signal input_Data : std_logic_vector (31 downto 0) := (others => '0');
    signal write_enable : std_logic := '0';
    signal read_enable : std_logic := '0';
    signal output_Data : std_logic_vector (31 downto 0) := (others => '0');

    -- Declaration of Components
    
    -- Data Memory Component
    component Data_Memory is
        Port (
            --input control signals
        Clock : in std_logic;
        Reset : in std_logic;
        DMEMOP : in std_logic_vector(2 downto 0);
        MemRead : in std_logic;
        MemWrite : in std_logic;

        --Inpud Addresses
        MemReadAddress : in std_logic_vector(31 downto 0);

        --Input Data
        MemDataInput : in std_logic_vector(31 downto 0);

        --Output Data
        MemDataOutput : out std_logic_vector(31 downto 0)

    );
    end component Data_Memory;

    begin

        DataMEME_IMPL : Data_Memory
            port map(
                Clock => clk,
                Reset => reset,
                DMEMOP => DMEMOP,
                MemRead => read_enable,
                MemWrite => write_enable,
                MemReadAddress => input_Address,
                MemDataInput => input_Data,
                MemDataOutput => output_Data
            );


    process   
        begin

            -- Initialize the clock
            wait for 5 ps;
            clk <= not clk;

        end process;


    process
        begin
            -- Initialize the reset
            
            wait for 10 ps;
            reset <= '1';
            
            wait for 10 ps;
            reset <= '0';
            wait for 10 ps;


            -- Initialize the input address
            --sw instruction
            write_enable <= '1';
            DMEMOP <= "111";
            input_Address <= "00000000000000000000000000000000";
            input_Data <= "00000000000000000000000000000001";

            wait for 10 ps;
            write_enable <= '1';
            DMEMOP <= "111";
            input_Address <= "00000000000000000000000000000100";
            input_Data <= "00000000000000000000000000000011";

            wait for 10 ps;
            write_enable <= '1';
            DMEMOP <= "111";
            input_Address <= "00000000000000000000000000001100";
            input_Data <= "00000000000000000000000000000111";

            --sb instruction
            wait for 10 ps;
            write_enable <= '1';
            DMEMOP <= "101";
            input_Address <= "00000000000000000000000000000011";
            input_Data <= "00000000000000000000000000000111";

            --sh instruction
            wait for 10 ps;
            write_enable <= '1';
            DMEMOP <= "110";
            input_Address <= "00000000000000000000000000000010";
            input_Data <= "11111111111111110110000011000000";



            --lb instruction
            wait for 10 ps;
            write_enable <= '0';
            read_enable <= '1';
            DMEMOP <= "000";
            input_Address <= "00000000000000000000000000000010";

            --lh instruction
            wait for 10 ps;
            read_enable <= '1';
            DMEMOP <= "001";
            input_Address <= "00000000000000000000000000000010";

            --lw instruction
            wait for 10 ps;
            read_enable <= '1';
            DMEMOP <= "010";
            input_Address <= "00000000000000000000000000001100";








            
        end process;
    
        end architecture;

    