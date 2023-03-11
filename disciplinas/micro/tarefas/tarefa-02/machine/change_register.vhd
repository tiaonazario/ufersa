LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY change_register IS
  PORT (
    reset : IN STD_LOGIC;
    clock : IN STD_LOGIC;

    totClear : IN STD_LOGIC;
    totLessThanPrice : IN STD_LOGIC;
    totSubPrice : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

    change : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END change_register;

ARCHITECTURE change_register_arch OF change_register IS
BEGIN

  PROCESS (reset, clock, totLessThanPrice, totClear, totSubPrice)
  BEGIN
    IF reset = '1' THEN
      change <= b"00000000";

    ELSIF rising_edge(clock) THEN
      IF totLessThanPrice = '1' OR totClear = '1' THEN
        change <= b"00000000";
      ELSE
        change <= totSubPrice;
      END IF;
    END IF;
  END PROCESS;

END ARCHITECTURE change_register_arch;
