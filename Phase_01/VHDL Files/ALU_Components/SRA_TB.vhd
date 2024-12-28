library ieee;
use ieee.std_logic_1164.all;


entity SRA_TB is
end entity SRA_TB;

architecture SRA_TB_Architecture of SRA_TB is
    component ShiftRightArithmetic is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0)
        );
    end component ShiftRightArithmetic;
    
    signal input_1_tb : std_logic_vector(31 downto 0):= (others => '0');
    signal input_2_tb : std_logic_vector(31 downto 0):= (others => '0');
    signal output_1_tb : std_logic_vector(31 downto 0):= (others => '0');
    
    begin
        SRA_Impl : ShiftRightArithmetic
            port map(
                input_1 => input_1_tb,
                input_2 => input_2_tb,
                output_1 => output_1_tb
            );

        process
            begin
                wait for 10 ps;
                input_1_tb <= "00000000000000000000000000000001";
                input_2_tb <= "00000000000000000000000000000000";

                wait for 10 ps;
                input_1_tb <= "01000000000000000000000000000000";
                input_2_tb <= "00000000000000000000000000000001";

                wait for 10 ps;
                input_1_tb <= "10100000000000000000000000000000";
                input_2_tb <= "00000000000000000000000000000010";

        end process;

end architecture SRA_TB_Architecture;

        



