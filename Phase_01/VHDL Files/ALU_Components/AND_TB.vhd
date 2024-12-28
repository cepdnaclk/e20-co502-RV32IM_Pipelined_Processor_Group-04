library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity AND_TB is
end AND_TB;

architecture AND_TB_ARCHITECTURE of AND_TB is
    component ander is
        port(
            input_1 , input_2 : in std_logic_vector(31 DOWNTO 0);
            output_1 : out std_logic_vector(31 DOWNTO 0)
        );
        
    end component;

    signal A_tb , B_tb , C_tb  : std_logic_vector(31 downto 0);

    begin

        AND_Impl : ander
            port map(
                input_1 => A_tb,
                input_2 => B_tb,
                output_1 => C_tb
            );

            process
                begin
                    A_tb <= "00000000000000000000000000000010";
                    B_tb <= "00000000000000000000000000000000";
                    
                    
                    wait for 10 ps;

                    A_tb <= "00000000000000000000000000000000";
                    B_tb <= "00000000000000000000000000000001";

                    

                    wait for 10 ps;

                    A_tb <= "00000000000000000000000000000001";
                    B_tb <= "00000000000000000000000000000001";

                    wait for 10 ps;

                    A_tb <= "00000000000000000000000000000001";
                    B_tb <= "00000000000000000000000000000010";
            end process;
end architecture AND_TB_ARCHITECTURE;