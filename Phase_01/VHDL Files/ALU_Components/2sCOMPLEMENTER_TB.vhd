library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;


entity Complementer2s_TB is
end entity Complementer2s_TB;

architecture testbench_2s of Complementer2s_TB is

    
    component Complementer2s is
        port(
            input_1_comp : IN std_logic_vector(31 downto 0);
            output_1_comp : OUT std_logic_vector(31 downto 0)
        );
    end component;

    signal input_1_tb : std_logic_vector(31 downto 0) := (others => '0');
    signal output_1_tb : std_logic_vector(31 downto 0) := (others => '0');


    begin

        Comp2s_Impl : Complementer2s
            port map(
                input_1_comp => input_1_tb,
                output_1_comp => output_1_tb
            );
        

        process
            begin
                wait for 10 ps;
                input_1_tb <= "00000000000000000000000000000000";
                report "one";
                
                wait for 10 ps;
                input_1_tb <= "00000000000000000000000000000001";
                report "two";

                wait for 10 ps;
                input_1_tb <= "00000000000000000000000000000010";
                report "three";

                wait for 10 ps;
                input_1_tb <= "11111111111111111111111111111111";
                report "four";
                
                wait for 10 ps;
                input_1_tb <= "11111111111111111111111111111110";
                report "five";
        end process;

end architecture testbench_2s;

