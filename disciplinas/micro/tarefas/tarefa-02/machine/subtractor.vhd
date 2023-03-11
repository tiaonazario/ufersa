LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY subtractor IS
  PORT (
    tot : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    price : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

    sub : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END ENTITY subtractor;

ARCHITECTURE subtractor_arch OF subtractor IS

BEGIN

  PROCESS (tot, price)
  BEGIN
    sub <= STD_LOGIC_VECTOR(unsigned(tot) - unsigned(price));
  END PROCESS;

END ARCHITECTURE subtractor_arch;
