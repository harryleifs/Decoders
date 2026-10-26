library ieee;
use ieee.std_logic_1164.all;

entity decoder_3to8 is
  port (
    en : in  std_logic;
    a  : in  std_logic_vector(2 downto 0);
    y  : out std_logic_vector(7 downto 0)
  );
end entity decoder_3to8;

architecture structural of decoder_3to8 is
  signal en_lo : std_logic;
  signal en_hi : std_logic;
begin

  en_lo <= en and (not a(2));   -- a(2)='0' -> y(3 downto 0)
  en_hi <= en and a(2);         -- a(2)='1' -> y(7 downto 4)

  u_lo : entity work.decoder_2to4
    port map (en => en_lo, a => a(1 downto 0), y => y(3 downto 0));

  u_hi : entity work.decoder_2to4
    port map (en => en_hi, a => a(1 downto 0), y => y(7 downto 4));

end architecture structural;