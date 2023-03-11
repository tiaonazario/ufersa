LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY tot_register IS
  PORT (
    reset : IN STD_LOGIC;
    clock : IN STD_LOGIC;

    totLoad : IN STD_LOGIC;
    totClear : IN STD_LOGIC;
    sum : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

    tot : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END tot_register;

ARCHITECTURE tot_register_arch OF tot_register IS
BEGIN

  PROCESS (reset, clock, totLoad, totClear, sum)
  BEGIN
    IF reset = '1' THEN
      tot <= b"00000000";

    ELSIF rising_edge(clock) THEN
      IF totClear = '1' THEN
        tot <= b"00000000";
      ELSIF totLoad = '1' THEN
        tot <= sum;
      END IF;
    END IF;
  END PROCESS;

END ARCHITECTURE tot_register_arch;
