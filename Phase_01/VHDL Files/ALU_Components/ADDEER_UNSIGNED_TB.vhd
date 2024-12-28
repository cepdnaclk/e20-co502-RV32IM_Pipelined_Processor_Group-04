library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ADD_UNSIGNED_TB is
end ADD_UNSIGNED_TB;

architecture ADD_UNSIGNED_TB_ARCHITECTURE of ADD_UNSIGNED_TB is
    component adder_unsigned is
        port(
            input_1 , input_2 : in std_logic_vector(31 DOWNTO 0);
            output_1 : out std_logic_vector(31 DOWNTO 0)
        );
        
    end component;

    signal A_tb , B_tb , C_tb  : std_logic_vector(31 downto 0) := (others => '0');

    begin

        ADD_Unsigned_Impl : adder_unsigned
            port map(
                input_1 => A_tb,
                input_2 => B_tb,
                output_1 => C_tb
            );

            process
                begin
                    wait for 10 ps;
                    --Edge case 01
                    A_tb <= "00000000000000000000000000000000";
                    B_tb <= "00000000000000000000000000000000";
                    
                    
                    wait for 10 ps;
                    --Edge case 02
                    A_tb <= "00000000000000000000000000000000";
                    B_tb <= "00000000000000000000000000000001";

                    

                    wait for 10 ps;
                    --Edge case 03
                    A_tb <= "11111111111111111111111111111111";
                    B_tb <= "00000000000000000000000000000000";

                    wait for 10 ps;
                    --Edge case 04
                    A_tb <= "11111111111111111111111111111111";
                    B_tb <= "00000000000000000000000000000001";

                    wait for 10 ps;
                    --Edge case 05
                    A_tb <= "11111111111111111111111111111111";
                    B_tb <= "11111111111111111111111111111111";

                    wait for 10 ps;

                    --Edge case 06
                    A_tb <= "11111111111111111111111111111110";
                    B_tb <= "00000000000000000000000000000010";

                    wait for 10 ps;

                    --Edge case 07
                    A_tb <= "11111111111111111111111111111111";
                    B_tb <= "00000000000000000000000000000010";

                    wait for 10 ps;

                    --Normal case 01
                    A_tb <= "00000000000000000000000000000001";
                    B_tb <= "00000000000000000000000000000001";

                    wait for 10 ps;

                    --Normal case 02
                    A_tb <= "11111111111111111111111111111000";
                    B_tb <= "00000000000000000000000000000011";
                    
                    wait for 10 ps;

                    --Normal case 03
                    A_tb <= "11000000000000000000000000000000";
                    B_tb <= "00000000000000000000000000000001";

                    wait for 10 ps;

                    --Normal case 04
                    A_tb <= "11000000000000000000000000000000";
                    B_tb <= "11000000000000000000000000000000";

            end process;
end architecture ADD_UNSIGNED_TB_ARCHITECTURE;