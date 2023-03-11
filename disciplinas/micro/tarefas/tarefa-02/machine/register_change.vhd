LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY register_change IS
  PORT (
    reset : IN STD_LOGIC;
    clock : IN STD_LOGIC;

    totLessThanPrice : IN STD_LOGIC;
    totSubPrice : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

    change : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END register_change;

ARCHITECTURE register_change_arch OF register_change IS
BEGIN

  PROCESS (reset, clock, totLessThanPrice, totSubPrice)
  BEGIN
    IF reset = '1' THEN
      change <= b"00000000";

    ELSIF rising_edge(clock) THEN
      IF totLessThanPrice = '1' THEN
        change <= b"00000000";
      ELSE
        change <= totSubPrice;
      END IF;
    END IF;
  END PROCESS;

END ARCHITECTURE register_change_arch;
