# Projeto-PLPGSQL
<i>Elaborado por Marcílio Júnior e Elielson Natan</i>

### Criar 5 funções

- [x] uma retornando um valor
- [x] outra retornando um tipo
- [x] outra retornando uma tabela
- [x] outra deve receber argumentos
- [x] outra não precisa receber argumentos

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
```
```sql
SELECT metadataPorIdProntuario(7);
```

##### CRIAÇÃO DE TABELA COM OS DADOS DE MÉDICO, REALIZADO A PARTIR DA ESPECIALIZAÇÃO

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
```
```sql
SELECT medicosPorEspecializacao('Gastroenterologista');
```

##### LISTAGEM DOS DADOS DOS MÉDICOS A PARTIR DA VIEW

```sql
CREATE OR REPLACE FUNCTION buscador_medicos()
RETURNS void
LANGUAGE plpgsql AS $$
  DECLARE f record;
  BEGIN
    FOR f IN
      SELECT
        vw.nome, vw."Especialização", vw.registro
      FROM
        vw_dados_medicos vw
      ORDER BY
        vw.nome
      LOOP
        RAISE NOTICE '% - % - %', f.nome, f."Especialização", f.registro;
    END LOOP;
  END;
$$;
```
```sql
SELECT buscador_medicos();
```

##### FECHANDO UM ATENDIMENTO COM:
 - VERIFICAÇÃO SE O STATUS DE ATEND. ESTÁ AGENDADO
 - ALTERANDO O STATUS DE ATENDIMENTO PARA REALIZADO
 - VERIFICAÇÃO SE PRONTUARIO EXISTE E
 - INSERINDO A PRESCRIÇÃO

```sql
CREATE OR REPLACE PROCEDURE fechar_atendimento(idAtendimento INTEGER, medicamento VARCHAR, administrar VARCHAR)
LANGUAGE PLPGSQL AS $$
    DECLARE
      idProntuario integer;
      statusAtend VARCHAR;
      idPaciente integer;
      idMedico integer;
    BEGIN
    	SELECT status_atendimento FROM atendimento WHERE id = $1 INTO statusAtend;
        IF statusAtend = 'Agendado' THEN
            UPDATE atendimento SET status_atendimento = 'Realizado', data_atendimento = NOW() WHERE id = $1;
            
            SELECT a.id_paciente FROM atendimento a WHERE a.id = $1 INTO idPaciente;
            
            IF EXISTS (SELECT p.id FROM prontuario p WHERE p.id = idPaciente) THEN
            	SELECT p.id FROM prontuario p WHERE p.id = idPaciente INTO idProntuario;
			ELSE
            	INSERT INTO prontuario VALUES(default, NOW(), idPaciente);
                SELECT p.id FROM prontuario p WHERE p.id = idPaciente INTO idProntuario;
            END IF;
            
            SELECT a.id_medico FROM atendimento a WHERE a.id = $1 INTO idMedico;
            
            INSERT INTO prescricao VALUES (DEFAULT, medicamento, administrar, idProntuario, idMedico, NOW());
        ELSE
            RAISE EXCEPTION 'Erro ao fechar atendimento!';
        END IF;
	END;
$$;
```
```sql
CALL fechar_atendimento(4, 'Ciprofloxacino 500mg',  'Tomar 14 comprimidos');
```

##### SELEÇÃO DOS ATENDIMENTOS REALIZADOS NO DIA ATUAL DA CONSULTA

```sql
CREATE OR REPLACE FUNCTION qnt_atendimentos_hoje()
RETURNS integer
LANGUAGE PLPGSQL AS $$
  DECLARE atendimentos integer;
  BEGIN
    SELECT COUNT(*)
    FROM atendimento
    WHERE data_atendimento >= CURRENT_DATE INTO atendimentos;
  RETURN atendimentos;
  END;
$$;
```
```sql
SELECT qnt_atendimentos_hoje() AS QNT_ATENDIMENTOS;
```

### CRIAR 3 PROCEDIMENTOS

- [x] recebe argumentos
- [x] recebe argumentos
- [x] não recebe argumentos

##### INSERIR NOVA PRESCRIÇÃO NA TABELA

```sql
CREATE OR REPLACE PROCEDURE inserir_prescricao(medicamento TEXT, administracao TEXT, id_prontuario INTEGER, id_medico INTEGER, data_prescricao TIMESTAMP)
LANGUAGE PLPGSQL AS $$
	BEGIN
		INSERT INTO prescricao VALUES (DEFAULT, medicamento, administracao, id_prontuario, id_medico, data_prescricao);
	END;
$$;
```
```sql
CALL inserir_prescricao('ESSA PRESCRICAO', 'SERA DELETADA', 1, 1, CURRENT_DATE);
```

##### DELETAR UMA PRESCRIÇÃO

```sql
CREATE OR REPLACE PROCEDURE deletar_prescricao(idPrescricao INTEGER)
LANGUAGE PLPGSQL AS $$
  BEGIN
    DELETE FROM prescricao WHERE prescricao.id = idPrescricao;
  END;
$$;
```

```sql
SELECT MAX(id) FROM prescricao; -- number id
```
```sql
CALL deletar_prescricao(n);
```

##### INSERIR RELATÓRIO FINANCEIRO DO DIA

```sql
CREATE OR REPLACE PROCEDURE relatorio_financeiro_dia()
LANGUAGE PLPGSQL AS $$
  DECLARE total integer;
  BEGIN
      SELECT SUM(valor) AS total_arrecadado FROM atendimento WHERE data_atendimento >= CURRENT_DATE INTO total;
      INSERT INTO financeiro_consultorio_dia VALUES (NOW(), total);
  END;
$$;
```
```sql
CALL relatorio_financeiro_dia();
```

### CRIAR 5 VIEWS

##### VISUALIZAR OS ATENDIMENTOS REALIZADOS NO CONSULTÓRIO POR ORDEM DECRESCENTE DE DATA

```sql
CREATE "vw_atendimentos_realizados" AS
SELECT paciente.nome AS "Paciente",
  medico.nome AS "Médico",
  atendimento.data_atendimento AS "Data do Atendimento",
  atendimento.valor AS "Valor"
FROM atendimento
  JOIN paciente ON atendimento.id_paciente = paciente.id
  JOIN medico ON atendimento.id_medico = medico.id
WHERE atendimento.status_atendimento = 'Realizado'
ORDER BY atendimento.data_atendimento DESC;
```
```sql
SELECT * FROM vw_atendimentos_realizados;
```

##### VISUALIZAR OS ATENDIMENTOS AGENDADOS NO CONSULTÓRIO POR ORDEM DECRESCENTE DE DATA

```sql
CREATE VIEW "vw_atendimentos_agendados" AS
SELECT paciente.nome AS "Paciente",
  medico.nome AS "Médico",
  atendimento.data_atendimento AS "Data do Atendimento",
  atendimento.valor AS "Valor"
FROM atendimento
JOIN paciente ON atendimento.id_paciente = paciente.id
JOIN medico ON atendimento.id_medico = medico.id
WHERE atendimento.status_atendimento = 'Agendado'
ORDER BY atendimento.data_atendimento DESC
```
```sql
SELECT * FROM vw_atendimentos_agendados;
```


##### VISUALIZAR OS DADOS PROFISSIONAIS E DE CONTATO DOS MÉDICOS QUE ATENDEM NO CONSULTÓRIO

```sql
CREATE VIEW "vw_dados_medicos" AS
SELECT
  medico.nome AS "Nome",
  especializacao.nome AS "Especialização",
  medico.registro AS "Registro",
  medico.celular AS "Celular",
  medico.email AS "E-mail"
FROM medico
JOIN especializacao ON medico.id_especializacao = especializacao."id";
ORDER BY medico.nome ASC
```
```sql
SELECT * FROM vw_dados_medicos;
```
##### VISUALIZAR OS DADOS DE CONTATO DOS PACIENTES CADASTRADOS NO CONSULTÓRIO

```sql
CREATE VIEW "dados_pacientes" AS
SELECT
  paciente.nome AS "Nome",
  paciente.celular AS "Celular",
  paciente.email AS "E-mail"
FROM paciente
ORDER BY paciente.nome ASC;
```
```sql
SELECT * FROM dados_pacientes;
```

##### RELATÓRIO COM O NOME E NÚMERO DOS PRONTUÁRIOS DOS PACIENTES CADASTRADOS NO CONSULTÓRIO

```sql
CREATE VIEW "relatorio_pacientes" AS SELECT paciente.nome AS "Paciente", prontuario."id" AS "Número do Prontuário"
FROM paciente
JOIN prontuario ON paciente."id" = prontuario."id";
```
```sql
SELECT * FROM relatorio_pacientes;
```