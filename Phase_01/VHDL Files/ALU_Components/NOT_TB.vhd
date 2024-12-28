library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity NOT_TB is
end NOT_TB;

architecture NOT_TB_ARCHITECTURE of NOT_TB is
    component Noter is
        port(
            input_1 : in std_logic_vector(31 DOWNTO 0);
            output_1 : out std_logic_vector(31 DOWNTO 0)
        );
        
    end component;

    signal A_tb , C_tb  : std_logic_vector(31 downto 0);

    begin

        NOT_Impl : Noter
            port map(
                input_1 => A_tb,
                output_1 => C_tb
            );

            process
                begin
                    A_tb <= "00000000000000000000000000000010";

                    
                    
                    wait for 10 ps;

                    A_tb <= "00000000000000000000000000000000";


                    

                    wait for 10 ps;

                    A_tb <= "00000000000000000000000000000001";


                    wait for 10 ps;

                    A_tb <= "00000000000000000000000000000001";

            end process;
end architecture NOT_TB_ARCHITECTURE;