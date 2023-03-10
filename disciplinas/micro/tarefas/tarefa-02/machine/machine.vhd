LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY machine IS
  PORT (
    reset : IN STD_LOGIC;
    clock : IN STD_LOGIC;

    coin : IN STD_LOGIC;
    amount : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    price : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

    detect : OUT STD_LOGIC
  );
END machine;

ARCHITECTURE machine_arch OF machine IS

  COMPONENT control IS
    PORT (
      reset : IN STD_LOGIC,
      clock : IN STD_LOGIC,
      coin : IN STD_LOGIC,
      totLessThan : IN STD_LOGIC,
      totLoad : OUT STD_LOGIC,
      totClear : OUT STD_LOGIC,
      detect : OUT STD_LOGIC
    );
  END COMPONENT control;

  SIGNAL totLessThan : STD_LOGIC;
  SIGNAL totLoad : STD_LOGIC;
  SIGNAL totClear : STD_LOGIC;

BEGIN

  PC : control PORT MAP(
    reset => reset,
    clock => clock,
    coin => coin,
    totLessThan => totLessThan,
    totLoad => totLoad,
    totClear => totClear,
    detect => detect
  );

END ARCHITECTURE machine_arch;
