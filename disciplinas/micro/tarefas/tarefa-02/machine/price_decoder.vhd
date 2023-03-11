LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY price_decoder IS
  PORT (
    price : IN STD_LOGIC_VECTOR(1 DOWNTO 0);

    price_decoded : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END price_decoder;

ARCHITECTURE price_decoder_arch OF price_decoder IS
BEGIN

  PROCESS
  BEGIN
    CASE(price) IS
      WHEN "01" => price_decoded <= b"00000101"; -- 50 centavos
      WHEN "10" => price_decoded <= b"00011110"; -- 3 reais
      WHEN OTHERS => price_decoded <= b"00000000";
    END CASE;
  END PROCESS;

END ARCHITECTURE price_decoder_arch;
