library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity XOR_TB is
end XOR_TB;

architecture XOR_TB_ARCHITECTURE of XOR_TB is
    component xorer is
        port(
            input_1 , input_2 : in std_logic_vector(31 DOWNTO 0);
            output_1 : out std_logic_vector(31 DOWNTO 0)
        );
        
    end component;

    signal A_tb , B_tb , C_tb  : std_logic_vector(31 downto 0):= (others => '0');

    begin

        XOR_Impl : xorer
            port map(
                input_1 => A_tb,
                input_2 => B_tb,
                output_1 => C_tb
            );

            process
                begin
                    wait for 10 ps;
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

                    wait for 10 ps;

                    A_tb <= "10101010101010101010101010101010";
                    B_tb <= "10101010101010101010101010101010";

                    wait for 10 ps;

                    A_tb <= "10101010101010101010101010101010";
                    B_tb <= "01010101010101010101010101010101";

            end process;
end architecture XOR_TB_ARCHITECTURE;