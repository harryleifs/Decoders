library ieee;
use ieee.std_logic_1164.all;

entity decoder_2to4 is
  port (
    en : in  std_logic;                      -- habilitacion (activo en '1')
    a  : in  std_logic_vector(1 downto 0);   -- entrada de seleccion
    y  : out std_logic_vector(3 downto 0)    -- salidas (one-hot)
  );
end entity decoder_2to4;

architecture rtl of decoder_2to4 is
begin
  y <= "0000" when en = '0'   else
       "0001" when a = "00"   else
       "0010" when a = "01"   else
       "0100" when a = "10"   else
       "1000";                               -- a = "11"
end architecture rtl;