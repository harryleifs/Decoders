library ieee;
use ieee.std_logic_1164.all;

entity gray_encoder is
  port (
    b : in  std_logic_vector(3 downto 0);   -- codigo binario
    g : out std_logic_vector(3 downto 0)    -- codigo Gray
  );
end entity gray_encoder;

architecture rtl of gray_encoder is
begin
  with b select
    g <= "0000" when "0000",
         "0001" when "0001",
         "0011" when "0010",
         "0010" when "0011",
         "0110" when "0100",
         "0111" when "0101",
         "0101" when "0110",
         "0100" when "0111",
         "1100" when "1000",
         "1101" when "1001",
         "1111" when "1010",
         "1110" when "1011",
         "1010" when "1100",
         "1011" when "1101",
         "1001" when "1110",
         "1000" when "1111",
         "XXXX" when others;
end architecture rtl;