library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity div_unit_tb is
end div_unit_tb;

architecture tb_arch of div_unit_tb is
    -- Component Declaration
    component div_unit
        port(
            A, B       : in  std_logic_vector(31 downto 0);
            DIV_RESULT : out std_logic_vector(31 downto 0);
            DIVU_RESULT: out std_logic_vector(31 downto 0);
            REM_RESULT : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Signals for testing
    signal A, B       : std_logic_vector(31 downto 0);
    signal DIV_RESULT : std_logic_vector(31 downto 0);
    signal DIVU_RESULT: std_logic_vector(31 downto 0);
    signal REM_RESULT : std_logic_vector(31 downto 0);

begin
    -- Instantiate the Division Unit
    uut: div_unit
        port map(
            A          => A,
            B          => B,
            DIV_RESULT => DIV_RESULT,
            DIVU_RESULT=> DIVU_RESULT,
            REM_RESULT => REM_RESULT
        );

    -- Test Process
    stim_proc: process
    begin
        -- Test Case 1: Normal Signed Division
        A <= std_logic_vector(to_signed(50, 32)); 
        B <= std_logic_vector(to_signed(5, 32)); 
        wait for 10 ns;

        -- Test Case 2: Normal Unsigned Division
        A <= std_logic_vector(to_unsigned(100, 32)); 
        B <= std_logic_vector(to_unsigned(10, 32)); 
        wait for 10 ns;

        -- Test Case 3: Signed Negative Division
        A <= std_logic_vector(to_signed(-30, 32)); 
        B <= std_logic_vector(to_signed(7, 32));  
        wait for 10 ns;

        -- Test Case 4: Signed Negative Division (Both Negative)
        A <= std_logic_vector(to_signed(-100, 32)); 
        B <= std_logic_vector(to_signed(-5, 32));  
        wait for 10 ns;

        -- Test Case 5: Unsigned Division (Larger Dividend)
        A <= std_logic_vector(to_unsigned(400, 32)); 
        B <= std_logic_vector(to_unsigned(20, 32));  
        wait for 10 ns;

        -- Test Case 6: Unsigned Division (Smaller Dividend)
        A <= std_logic_vector(to_unsigned(5, 32)); 
        B <= std_logic_vector(to_unsigned(10, 32));  
        wait for 10 ns;

        -- Test Case 7: Division by Zero
        A <= std_logic_vector(to_signed(50, 32)); 
        B <= (others => '0');  
        wait for 10 ns;

        -- End Simulation
        wait;
    end process stim_proc;

end tb_arch;
