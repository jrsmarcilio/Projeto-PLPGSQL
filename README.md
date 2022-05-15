# Projeto-PLPGSQL


### Criar 5 funções
  - [x] uma retornando um valor
  - [x] outra retornando um tipo
  - [x] outra retornando uma tabela
  - [x] outra deve receber argumentos
  - [x] outra não precisa receber argumentos


##### SELEÇÃO DOS ATENDIMENTOS REALIZADOS NO DIA ATUAL DA CONSULTA
```sql
CREATE OR REPLACE FUNCTION qnt_atendimentos_hoje() 
RETURNS integer
LANGUAGE PLPGSQL AS $$
DECLARE
   atendimentos integer;
BEGIN
	SELECT COUNT(*) AS QNT_ATENDIMENTOS FROM atendimento WHERE data_atendimento = CURRENT_DATE INTO atendimentos;
RETURN atendimentos;
END;$$;

SELECT qnt_atendimentos_hoje();
```

##### CRIAÇÃO DE METADATA (JSON) COM OS DADOS DO PACIENTE A PARTIR DO ID DO PRONTUÁRIO
```sql
CREATE OR REPLACE FUNCTION metadataPorIdProntuario(id INTEGER) 
RETURNS TEXT
LANGUAGE PLPGSQL AS $$
DECLARE
   metadata TEXT;
BEGIN
  SELECT
    CONCAT(
      '{',
        '"Dados Pessoais":',      DadosPessoais,    ',',
        '"Dados de Endereço":',   Endereco,         ',',
        '"Dados de Prontuario":', DadosProntuario,  ',',
        '"Dados de Prescrição":', DadosPrescricao,
      '}') AS metadata
  FROM
    (
      SELECT
        CONCAT('{', pac_pessoais,   '}') AS DadosPessoais,
        CONCAT('{', pac_endereco,   '}') AS Endereco,
        CONCAT('{', pac_prontuario, '}') AS DadosProntuario,
        CONCAT('{', pac_prescricao, '}') AS DadosPrescricao
      FROM
        (
        SELECT
          CONCAT (
            '"id":', pac.id, ','
            '"cpf":',  '"', pac.cpf, '"', ','
            '"nome":', '"', pac.nome, '"', ','
            '"celular":', '"', pac.celular, '"', ','
            '"email":', '"', pac.email, '"', ','
            '"tiposanguineo":', '"', pac.tiposanguineo, '"'
          ) AS pac_pessoais,
          CONCAT (
            '"cep":',  '"', pac.cep, '"', ','
            '"numero":', '"', pac.numero, '"'
          ) AS pac_endereco,
          CONCAT (
            '"idProntuario":', pront.id, ','
            '"dataAbertura":',  '"', presc.data, '"'
          ) AS pac_prontuario,
          CONCAT (
            '"descricao":',  '"', presc.descricao, '"', ','
            '"dataAtendimento":',  '"', presc.data, '"'
          ) AS pac_prescricao
          FROM
            paciente pac
          INNER JOIN 
            prontuario pront ON pac.id = pront.id_paciente
          INNER JOIN 
            prescricao presc ON presc.id_prontuario = pront.id
          WHERE
            pront.id = $1
        ) AS concat_dados
    ) AS metadata_object INTO metadata;
RETURN metadata;
END;$$;

SELECT metadataPorIdProntuario(7);
```

#### CRIAÇÃO DE TABELA COM OS DADOS DE MÉDICO, REALIZADO A PARTIR DA ESPECIALIZAÇÃO
```sql
CREATE OR REPLACE FUNCTION medicosPorEspecializacao(especializacaoNome VARCHAR) 
	RETURNS TABLE (
    id INT,
    registro VARCHAR,
    nome VARCHAR,
    especializacao VARCHAR
	)
LANGUAGE PLPGSQL AS $$
BEGIN
  RETURN QUERY SELECT
    med.id,
    med.registro,
    med.nome,
    esp.nome
  FROM
    medico med
  INNER JOIN
    especializacao esp ON esp.id = med.id_especializacao
	WHERE
    esp.nome = $1;
END;$$;

SELECT medicosPorEspecializacao('Gastroenterologista');
```

