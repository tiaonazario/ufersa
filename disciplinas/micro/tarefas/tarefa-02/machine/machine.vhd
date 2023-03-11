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

    change : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    detect : OUT STD_LOGIC
  );
END machine;

ARCHITECTURE machine_arch OF machine IS

  COMPONENT control IS
    PORT (
      reset : IN STD_LOGIC;
      clock : IN STD_LOGIC;
      coin : IN STD_LOGIC;
      totLessThanPrice : IN STD_LOGIC;

      totLoad : OUT STD_LOGIC;
      totClear : OUT STD_LOGIC;
      detect : OUT STD_LOGIC
    );
  END COMPONENT control;

  COMPONENT operative IS
    PORT (
      reset : IN STD_LOGIC;
      clock : IN STD_LOGIC;

      amount : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      price : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      totLoad : IN STD_LOGIC;
      totClear : IN STD_LOGIC;

      change : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      totLessThanPrice : OUT STD_LOGIC
    );
  END COMPONENT operative;

  SIGNAL totLessThanPrice : STD_LOGIC;
  SIGNAL totLoad : STD_LOGIC;
  SIGNAL totClear : STD_LOGIC;

BEGIN

  PC : control PORT MAP(
    reset => reset,
    clock => clock,
    coin => coin,
    totLessThanPrice => totLessThanPrice,
    totLoad => totLoad,
    totClear => totClear,
    detect => detect
  );

  PO : operative PORT MAP(
    reset => reset,
    clock => clock,
    amount => amount,
    price => price,
    totLoad => totLoad,
    totClear => totClear,
    change => change,
    totLessThanPrice => totLessThanPrice
  );

END ARCHITECTURE machine_arch;
