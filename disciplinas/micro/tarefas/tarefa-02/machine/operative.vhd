LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY operative IS
  PORT (
    reset : IN STD_LOGIC;
    clock : IN STD_LOGIC;

    amount : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    price : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    totLoad : IN STD_LOGIC;
    totClear : IN STD_LOGIC;

    change : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    totLessThanPrice : OUT STD_LOGIC
  );
END operative;

ARCHITECTURE operative_arch OF operative IS

  COMPONENT amount_decoder IS
    PORT (
      amount : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

      amount_decoded : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT amount_decoder;

  COMPONENT price_decoder IS
    PORT (
      price : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

      price_decoded : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT price_decoder;

  COMPONENT change_register IS
    PORT (
      reset : IN STD_LOGIC;
      clock : IN STD_LOGIC;

      totClear : IN STD_LOGIC;
      totLessThanPrice : IN STD_LOGIC;
      totSubPrice : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

      change : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT change_register;

  COMPONENT tot_register IS
    PORT (
      reset : IN STD_LOGIC;
      clock : IN STD_LOGIC;

      totLoad : IN STD_LOGIC;
      totClear : IN STD_LOGIC;
      sum : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

      tot : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT tot_register;

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
  SIGNAL amount_decoded : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL price_decoded : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

  deco_amount : amount_decoder PORT MAP(
    amount => amount,
    amount_decoded => amount_decoded
  );

  deco_price : price_decoder PORT MAP(
    price => price,
    price_decoded => price_decoded
  );

  call_change : change_register PORT MAP(
    reset => reset,
    clock => clock,
    totClear => totClear,
    totLessThanPrice => lessThan,
    totSubPrice => totSubPrice,
    change => change
  );

  call_tot : tot_register PORT MAP(
    reset => reset,
    clock => clock,
    totLoad => totLoad,
    totClear => totClear,
    sum => sum,
    tot => tot
  );

  compare : comparator PORT MAP(
    tot => tot,
    price => price_decoded,
    totLessThanPrice => lessThan
  );

  subtract : subtractor PORT MAP(
    tot => tot,
    price => price_decoded,
    sub => totSubPrice
  );

  call_adder : adder PORT MAP(
    tot => tot,
    amount => amount_decoded,
    sum => sum
  );

  totLessThanPrice <= lessThan;

END ARCHITECTURE operative_arch;
