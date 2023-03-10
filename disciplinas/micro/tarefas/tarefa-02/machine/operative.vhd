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

    totLessThanPrice : OUT STD_LOGIC
  );
END operative;

ARCHITECTURE operative_arch OF operative IS

  COMPONENT register_price IS
    PORT (
      reset : IN STD_LOGIC;
      clock : IN STD_LOGIC;

      totLoad : IN STD_LOGIC;
      totClear : IN STD_LOGIC;
      sum : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

      tot : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT register_price;

  COMPONENT comparator IS
    PORT (
      tot : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      price : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

      totLessThanPrice : OUT STD_LOGIC
    );
  END COMPONENT comparator;

  COMPONENT adder IS
    PORT (
      tot : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      amount : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

      sum : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT adder;

  SIGNAL sum : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL tot : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

  reg : register_price PORT MAP(
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
    totLessThanPrice => totLessThanPrice
  );

  call_adder : adder PORT MAP(
    tot => tot,
    amount => amount,
    sum => sum
  );

END ARCHITECTURE operative_arch;
