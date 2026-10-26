library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_comparator_su is
end entity tb_comparator_su;

architecture sim of tb_comparator_su is
  constant N    : positive := 4;
  constant MAXV : integer  := 2**N - 1;     -- valor maximo sin signo

  signal a, b       : std_logic_vector(N-1 downto 0) := (others => '0');
  signal sel        : std_logic := '0';
  signal eq, lg, ls : std_logic;
begin

  dut : entity work.comparator_su
    generic map (N => N)
    port map (a => a, b => b, sel => sel, eq => eq, lg => lg, ls => ls);

  stim : process
    variable ia, ib           : integer;
    variable e_eq, e_lg, e_ls : std_logic;
    variable errors           : integer := 0;
  begin
    for s in 0 to 1 loop
      if s = 0 then sel <= '0'; else sel <= '1'; end if;

      for i in 0 to MAXV loop
        for j in 0 to MAXV loop
          a <= std_logic_vector(to_unsigned(i, N));
          b <= std_logic_vector(to_unsigned(j, N));
          wait for 10 ns;

          if s = 0 then
            ia := i;
            ib := j;
          else
            ia := to_integer(signed(to_unsigned(i, N)));
            ib := to_integer(signed(to_unsigned(j, N)));
          end if;

          e_eq := '0'; e_lg := '0'; e_ls := '0';
          if ia = ib then e_eq := '1'; end if;
          if ia > ib then e_lg := '1'; end if;
          if ia < ib then e_ls := '1'; end if;

          if eq /= e_eq or lg /= e_lg or ls /= e_ls then
            errors := errors + 1;
            report "ERROR: sel=" & integer'image(s) &
                   " A=" & integer'image(ia) & " B=" & integer'image(ib)
                   severity error;
          end if;
        end loop;
      end loop;
    end loop;

    if errors = 0 then
      report "Comparador -> TODAS LAS PRUEBAS PASARON" severity note;
    else
      report "Comparador -> errores: " & integer'image(errors) severity failure;
    end if;
    wait;
  end process stim;

end architecture sim;