library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DMEM is
    port (
        clk    : in  std_logic;                     -- Clock signal
        addr   : in  std_logic_vector(31 downto 0); -- Byte address input
        dataW  : in  std_logic_vector(31 downto 0); -- Data to write (32-bit)
        dataR  : out std_logic_vector(31 downto 0); -- Data to read (32-bit)
        memRW  : in  std_logic;                     -- Read/Write control: 1 for write, 0 for read
        func3  : in  std_logic_vector(2 downto 0)   -- Operation type for load/store
    );
end DMEM;

architecture Behavioral of DMEM is
    -- Byte-addressable memory array (8KB)
    type memory_array is array (0 to 8192) of std_logic_vector(7 downto 0); -- 8192 bytes (8KB)
    signal mem : memory_array := (others => (others => '0')); -- Initialize memory to 0
begin
    -- Asynchronous read process
    process(addr, func3, memRW, mem)
        variable byte_addr : integer;
        variable temp_data : std_logic_vector(31 downto 0); -- Temporary data holder
    begin
        if memRW = '0' then
            -- Convert 32-bit address to integer
            byte_addr := to_integer(unsigned(addr(12 downto 0))); -- Use lower 13 bits for 8KB memory

            -- Read operation
            case func3 is
                when "000" => -- lb: Load Byte (signed)
                    temp_data := (others => mem(byte_addr)(7)); -- Sign extend
                    temp_data(7 downto 0) := mem(byte_addr);
                    dataR <= temp_data;

                when "100" => -- lbu: Load Byte Unsigned
                    temp_data := (others => '0'); -- Zero extend
                    temp_data(7 downto 0) := mem(byte_addr);
                    dataR <= temp_data;

                when "001" => -- lh: Load Halfword (signed)
                    temp_data := (others => mem(byte_addr + 1)(7)); -- Sign extend
                    temp_data(15 downto 0) := mem(byte_addr + 1) & mem(byte_addr);
                    dataR <= temp_data;

                when "101" => -- lhu: Load Halfword Unsigned
                    temp_data := (others => '0'); -- Zero extend
                    temp_data(15 downto 0) := mem(byte_addr + 1) & mem(byte_addr);
                    dataR <= temp_data;

                when "010" => -- lw: Load Word
                    dataR <= mem(byte_addr + 3) & mem(byte_addr + 2) & mem(byte_addr + 1) & mem(byte_addr);

                when others =>
                    -- Unsupported operation; return zero
                    dataR <= (others => '0');
            end case;
        else
            -- During write operations, output zero or hold the previous value
            dataR <= (others => '0');
        end if;
    end process;

    -- Synchronous write process
    process(clk)
        variable byte_addr : integer;
    begin
        if rising_edge(clk) then
            if memRW = '1' then
                -- Convert 32-bit address to integer
                byte_addr := to_integer(unsigned(addr(11 downto 0))); -- Use lower 12 bits for 4KB memory

                -- Write operation
                case func3 is
                    when "000" => -- sb: Store Byte
                        mem(byte_addr) <= dataW(7 downto 0); -- Write 1 byte (LSB of dataW)

                    when "001" => -- sh: Store Halfword
                        mem(byte_addr)     <= dataW(7 downto 0);  -- Write first byte
                        mem(byte_addr + 1) <= dataW(15 downto 8); -- Write second byte

                    when "010" => -- sw: Store Word
                        mem(byte_addr)     <= dataW(7 downto 0);   -- Write byte 0
                        mem(byte_addr + 1) <= dataW(15 downto 8);  -- Write byte 1
                        mem(byte_addr + 2) <= dataW(23 downto 16); -- Write byte 2
                        mem(byte_addr + 3) <= dataW(31 downto 24); -- Write byte 3

                    when others =>
                        -- Unsupported operation; do nothing
                end case;
            end if;
        end if;
    end process;
end Behavioral;