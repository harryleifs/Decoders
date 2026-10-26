library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_gray_encoder is
end entity tb_gray_encoder;

architecture sim of tb_gray_encoder is
  signal b : std_logic_vector(3 downto 0) := "0000";
  signal g : std_logic_vector(3 downto 0);

  function bits_diff(x, y : std_logic_vector) return integer is
    variable n : integer := 0;
  begin
    for k in x'range loop
      if x(k) /= y(k) then n := n + 1; end if;
    end loop;
    return n;
  end function;
begin

  dut : entity work.gray_encoder
    port map (b => b, g => g);

  stim : process
    variable expected : std_logic_vector(3 downto 0);
    variable prev_g   : std_logic_vector(3 downto 0) := "0000";
    variable errors   : integer := 0;
  begin
    for i in 0 to 15 loop
      b <= std_logic_vector(to_unsigned(i, 4));
      wait for 10 ns;

      expected := b xor ('0' & b(3 downto 1));

      if g /= expected then
        errors := errors + 1;
        report "ERROR: b=" & integer'image(i) & " no coincide con el modelo"
               severity error;
      end if;

      if i > 0 and bits_diff(g, prev_g) /= 1 then
        errors := errors + 1;
        report "ERROR: propiedad Gray violada en b=" & integer'image(i)
               severity error;
      end if;
      prev_g := g;
    end loop;

    if errors = 0 then
      report "Gray encoder -> TODAS LAS PRUEBAS PASARON" severity note;
    else
      report "Gray encoder -> errores: " & integer'image(errors) severity failure;
    end if;
    wait;
  end process stim;

end architecture sim;