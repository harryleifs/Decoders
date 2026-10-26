library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_decoder_3to8 is
end entity tb_decoder_3to8;

architecture sim of tb_decoder_3to8 is
  signal en : std_logic := '0';
  signal a  : std_logic_vector(2 downto 0) := "000";
  signal y  : std_logic_vector(7 downto 0);
begin

  dut : entity work.decoder_3to8
    port map (en => en, a => a, y => y);

  stim : process
    variable expected : std_logic_vector(7 downto 0);
    variable errors   : integer := 0;
  begin
    for e in 0 to 1 loop
      for i in 0 to 7 loop
        if e = 1 then en <= '1'; else en <= '0'; end if;
        a <= std_logic_vector(to_unsigned(i, 3));
        wait for 10 ns;

        expected := (others => '0');
        if e = 1 then expected(i) := '1'; end if;

        if y /= expected then
          errors := errors + 1;
          report "ERROR: en=" & integer'image(e) & " a=" & integer'image(i)
                 severity error;
        end if;
      end loop;
    end loop;

    if errors = 0 then
      report "Decoder 3:8 -> TODAS LAS PRUEBAS PASARON" severity note;
    else
      report "Decoder 3:8 -> errores: " & integer'image(errors) severity failure;
    end if;
    wait;
  end process stim;

end architecture sim;