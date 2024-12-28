library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity subtractor is
    port(
        input_1 : IN std_logic_vector(31 downto 0);
        input_2 : IN std_logic_vector(31 downto 0);
        output_1 : OUT std_logic_vector(31 downto 0)
    );
end entity subtractor;


architecture logic_1 of subtractor is
    
    component adder_signed is
        port(
            input_1 : IN std_logic_vector(31 downto 0);
            input_2 : IN std_logic_vector(31 downto 0);
            output_1 : OUT std_logic_vector(31 downto 0)
        );
    end component;
    
    component Complementer2s is
        port(
            input_1_comp : IN std_logic_vector(31 downto 0);
            output_1_comp : OUT std_logic_vector(31 downto 0)
        );
    end component;
    

    signal temp_comp_output : std_logic_vector(31 downto 0);
    
    begin
        
        -- instantiate the components
        --Complementer2s
        Complementer2s_1 : Complementer2s
            port map(
                input_1_comp => input_2,
                output_1_comp => temp_comp_output
            );

        --Adder
        adder_signed_1 : adder_signed
            port map(
                input_1 => input_1,
                input_2 => temp_comp_output,
                output_1 => output_1
            );

        
    
end architecture logic_1;