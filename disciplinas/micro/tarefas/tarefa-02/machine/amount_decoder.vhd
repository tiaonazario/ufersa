LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY amount_decoder IS
  PORT (
    amount : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

    amount_decoded : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END ENTITY amount_decoder;

ARCHITECTURE amount_decoder_arch OF amount_decoder IS
BEGIN

  PROCESS (amount)
  BEGIN
    CASE amount IS
      WHEN "01" => amount_decoded <= b"00000101"; -- 50 centavos
      WHEN "10" => amount_decoded <= b"00001010"; -- 1 real
      WHEN OTHERS => amount_decoded <= b"00000000"; -- sem moeda
    END CASE;
  END PROCESS;

END ARCHITECTURE amount_decoder_arch;
