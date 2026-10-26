library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator_su is
  generic (
    N : positive := 8                       -- ancho de los vectores
  );
  port (
    a   : in  std_logic_vector(N-1 downto 0);
    b   : in  std_logic_vector(N-1 downto 0);
    sel : in  std_logic;                    -- '0' = unsigned, '1' = signed
    eq  : out std_logic;                    -- A = B
    lg  : out std_logic;                    -- A > B
    ls  : out std_logic                     -- A < B
  );
end entity comparator_su;

architecture rtl of comparator_su is
  signal a_u, b_u : unsigned(N-1 downto 0);
  signal a_s, b_s : signed(N-1 downto 0);
begin

  a_u <= unsigned(a);
  b_u <= unsigned(b);
  a_s <= signed(a);
  b_s <= signed(b);

  -- La igualdad es la misma con o sin signo
  eq <= '1' when a_u = b_u else '0';

  lg <= '1' when (sel = '0' and a_u > b_u) or
                 (sel = '1' and a_s > b_s) else '0';

  ls <= '1' when (sel = '0' and a_u < b_u) or
                 (sel = '1' and a_s < b_s) else '0';

end architecture rtl;