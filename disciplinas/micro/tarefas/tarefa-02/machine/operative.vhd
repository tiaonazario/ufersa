LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY operative IS
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
END operative;

ARCHITECTURE operative_arch OF operative IS

  COMPONENT register_change IS
    PORT (
      reset : IN STD_LOGIC;
      clock : IN STD_LOGIC;

      totLessThanPrice : IN STD_LOGIC;
      totSubPrice : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

      change : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT register_change;

  COMPONENT register_price IS
    PORT (
      reset : IN STD_LOGIC;
      clock : IN STD_LOGIC;

      totLoad : IN STD_LOGIC;
      totClear : IN STD_LOGIC;
      sum : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

      tot : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT register_price;

  COMPONENT comparator IS
    PORT (
      tot : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      price : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

      totLessThanPrice : OUT STD_LOGIC
    );
  END COMPONENT comparator;

  COMPONENT subtractor IS
    PORT (
      tot : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      price : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

      sub : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT subtractor;

  COMPONENT adder IS
    PORT (
      tot : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      amount : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

      sum : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT adder;

  SIGNAL sum : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL totSubPrice : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL tot : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL lessThan : STD_LOGIC;

BEGIN

  reg_change : register_change PORT MAP(
    reset => reset,
    clock => clock,

    totLessThanPrice => lessThan,
    totSubPrice => totSubPrice,
    change => change
  );

  reg_price : register_price PORT MAP(
    reset => reset,
    clock => clock,
    totLoad => totLoad,
    totClear => totClear,
    sum => sum,
    tot => tot
  );

  compare : comparator PORT MAP(
    tot => tot,
    price => price,
    totLessThanPrice => lessThan
  );

  subtract : subtractor PORT MAP(
    tot => tot,
    price => price,
    sub => totSubPrice
  );

  call_adder : adder PORT MAP(
    tot => tot,
    amount => amount,
    sum => sum
  );

  totLessThanPrice <= lessThan;

END ARCHITECTURE operative_arch;
