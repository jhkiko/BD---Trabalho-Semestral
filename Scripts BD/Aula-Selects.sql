
SELECT CONVERT(CHAR(2), 12) AS doze_char_convert
SELECT CONVERT(VARCHAR(5), 12.65) AS doze_quebrado_varchar_convert
SELECT CONVERT(INT, 12.54) AS doze_quebrado_varchar
SELECT CONVERT(INT,'12') AS doze_char_int_convert

--103 converte date(datetime) -> char(dd/MM/yyyy) - BR
SELECT CONVERT(CHAR(10), GETDATE(), 103) AS dia_hoje
--108 converte datetime -> char (HH:mm)
SELECT CONVERT(CHAR(5), GETDATE(), 108) AS hora_agora

--Select simples funcionario

SELECT * FROM f
