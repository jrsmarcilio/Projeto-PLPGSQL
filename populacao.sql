--
-- Sequence drop FUNCTIONS, PROCEDURES, VIEWS
--

-- DROP VIEW qnt_prontuario;
-- DROP VIEW dados_pacientes;
-- DROP VIEW vw_dados_medicos;
-- DROP VIEW vw_atendimentos_agendados;
-- DROP VIEW vw_atendimentos_realizados;
-- DROP VIEW vw_dados_medicos;
-- DROP PROCEDURE inserir_prescricao;
-- DROP PROCEDURE deletar_prescricao;
-- DROP PROCEDURE fecharatendimento;
-- DROP PROCEDURE financeiro_diario;
-- DROP FUNCTION medicosporespecializacao;
-- DROP FUNCTION metadataporidprontuario;
-- DROP FUNCTION qnt_atendimentos_hoje;

--
-- Sequence drop table
--

-- DROP TABLE financeiro_consultorio_dia;
-- DROP TABLE prescricao;
-- DROP TABLE prontuario;
-- DROP TABLE atendimento;
-- DROP TABLE paciente;
-- DROP TABLE medico;
-- DROP TABLE especializacao;


--
-- Table structure for table especializacao
--
CREATE TABLE especializacao (
  id SERIAL NOT NULL,
  nome VARCHAR(255) NOT NULL UNIQUE,
  qnt_especializacao integer DEFAULT NULL,
  PRIMARY KEY (id)
);
--
-- Dumping data for table especializacao
--
INSERT INTO
  especializacao
VALUES
  (default, 'Podologista', 3),
  (default, 'Gastroenterologista', 3),
  (default, 'Ginecologista', 3),
  (default, 'Endocrinologista', 3),
  (default, 'Dermatologista', 3);
--
-- Table structure for table medico
--
CREATE TABLE medico (
  id SERIAL NOT NULL,
  registro VARCHAR(20) NOT NULL UNIQUE,
  nome VARCHAR(150) NOT NULL,
  celular VARCHAR(20) DEFAULT NULL,
  email VARCHAR(50) DEFAULT NULL,
  id_especializacao integer NOT NULL,
  CEP VARCHAR(20) NOT NULL,
  numero VARCHAR(10) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id_especializacao) REFERENCES especializacao (id)
);
--
-- Dumping data for table medico
--
INSERT INTO
  medico
VALUES
  (DEFAULT,'015974/PE','Dr João Marcio Garcia','(81) 9 9959-7113','joão_marcio@mail.com',1,'55819-068','55'),
  (DEFAULT,'067439/PE','Dr Haniel Brião Bulhosa','(81) 9 9999-9999','haniel_brião@mail.com',1,'54230-661','57'),
  (DEFAULT,'098755/PE','Dr Eliel Filipe Carmona','(81) 9 9999-9999','eliel_filipe@mail.com',2,'55819-068','55'),
  (DEFAULT,'099935/PE','Henzo Aquino Matias','(81) 9 9999-9999','aquino_matias@mail.com',2,'55608-312','08'),
  (DEFAULT,'036596/SP','Dra Fabiana Argolo Graça','(81) 9 9999-9999','fabiana_argolo@mail.com',3,'53439-430','55'),
  (DEFAULT,'025189/PE','Dr Jair Doutel Cavadas','(81) 9 9999-9999','jair_doutel@mail.com',3,'54735-330','08'),
  (DEFAULT,'054059/PE','Dra Viviana Telinhos','(81) 9 9999-9999','viviana_telinhos@mail.com',4,'53439-430','5'),
  (DEFAULT,'078682/PE','Dr Deivid Meireles Barroso','(81) 9 9999-9999','deivid_meireles@mail.com',4,'54735-330','8'),
  (DEFAULT,'070493/PE','Dra Carmona Viviana Telinhos','(81) 9 9999-9999','carmona_viviana@mail.com',1,'53439-430','5'),
  (DEFAULT,'070198/SP','Dra Camilla Meireles','(81) 9 9999-9999','camilla_meireles@mail.com',2,'54735-330','8'),
  (DEFAULT,'076943/PE','Dr Deivid Farias Vergueiro','(81) 9 9999-9999','deivid_farias@mail.com',3,'54320-136','7');
--
-- Table structure for table paciente
--
CREATE TABLE paciente (
  id SERIAL NOT NULL,
  cpf VARCHAR(20) NOT NULL UNIQUE,
  nome VARCHAR(150) NOT NULL,
  celular VARCHAR(20) DEFAULT NULL,
  email VARCHAR(50) NOT NULL,
  tipoSanguineo VARCHAR(5) NOT NULL,
  CEP VARCHAR(20) NOT NULL,
  numero VARCHAR(10) NOT NULL,
  PRIMARY KEY (id)
);
--
-- Dumping data for table paciente
--
INSERT INTO
  paciente
VALUES
  (DEFAULT,'311.954.500-79','Jorge Casqueira Godinho','(81) 9 9959-7113','jorge_ca@email.com','AB','50610-300','35'),
  (DEFAULT,'353.122.974-53','Isadora Guterres Bogado','(81) 8 2760-2296','isadora_gu@email.com','A+','50110-435','45'),
  (DEFAULT,'452.215.184-57','Melany Moura Saraiva','(81) 9 2211-2901','melany_mo@email.com','B+','50640-030','1621'),
  (DEFAULT,'934.783.604-47','Zayn Fernandes Magalhães','(81) 8 3321-6582','zayn_fe@email.com','O+','50610-300','888'),
  (DEFAULT,'563.576.984-58','Romeu Meira Modesto','(81) 9 4539-5543','romeu_ma@email.com','AB+','50110-110','2165'),
  (DEFAULT,'475.444.784-08','Thomas Porciúncula Regodeiro','(81) 9 8699-9509','thomas_porciúncula@email.com','A-','51335-220','1421'),
  (DEFAULT,'775.323.504-44','Zhen Caniça Machado','(81) 8 4518-8601','zhen_caniça@email.com','B-','52125-150','714'),
  (DEFAULT,'447.896.964-72','Cloe Valverde Gaspar','(81) 9 2078-6747','cloe_valverde@email.com','O-','52125-150','17'),
  (DEFAULT,'813.731.074-64','Rubim Pegado Bicalho','(81) 9 8325-9152','rubim_pegado@email.com','AB-','50770-220','13'),
  (DEFAULT,'486.071.744-95','Haniela Quadros Rabelo','(81) 9 4886-5968','haniela_quadros@email.com','A+','53240-390','324'),
  (DEFAULT,'906.974.024-95','Alonso Eiró Matias','(81) 9 3951-3405','alonso_eiró@email.com','B+','53320-633','2017'),
  (DEFAULT,'655.507.694-17','Johnny Guterres Canejo','(81) 9 1228-1522','johnny_gu@email.com','O+','53270-092','486'),
  (DEFAULT,'057.897.364-24','Ânia Ruela Holanda','(81) 9 4836-8113','ânia_ruela@email.com','AB+','53060-507','543'),
  (DEFAULT,'554.462.394-58','Tiffany Palma Cordeiro','(81) 9 9224-7692','tiffany_pal@email.com','A-','53020-091','91'),
  (DEFAULT,'759.392.504-83','Inara Vidigal Breia','(81) 8 5510-9651','inara_vidigal@email.com','B-','53330-570','77'),
  (DEFAULT,'608.923.814-77','Júlia Cipriano Travassos','(81) 8 9491-4349','júlia_cipriano@email.com','O-','54360-123','23'),
  (DEFAULT,'150.006.254-55','Luiz Caeira Castilho','(81) 9 4995-6849','luiz_caeira@email.com','AB-','54410-745','82'),
  (DEFAULT,'349.547.314-96','Indira Barreno Maciel','(81) 9 1217-4021','indira_barreno@email.com','A+','54355-321','1258');
--
-- Table structure for table prontuario
--
CREATE TABLE prontuario (
  id SERIAL NOT NULL,
  dataAbertura TIMESTAMP NOT NULL,
  id_paciente integer NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id_paciente) REFERENCES paciente (id)
);
--
-- Dumping data for table prontuario
--
INSERT INTO
  prontuario
VALUES
  (DEFAULT, CURRENT_DATE, 1),
  (DEFAULT, CURRENT_DATE, 2),
  (DEFAULT, CURRENT_DATE, 3),
  (DEFAULT, CURRENT_DATE, 4),
  (DEFAULT, CURRENT_DATE, 5),
  (DEFAULT, CURRENT_DATE, 6),
  (DEFAULT, CURRENT_DATE, 7),
  (DEFAULT, CURRENT_DATE, 8),
  (DEFAULT, CURRENT_DATE, 9),
  (DEFAULT, CURRENT_DATE, 10),
  (DEFAULT, CURRENT_DATE, 11),
  (DEFAULT, CURRENT_DATE, 12),
  (DEFAULT, CURRENT_DATE, 13),
  (DEFAULT, CURRENT_DATE, 14),
  (DEFAULT, CURRENT_DATE, 15),
  (DEFAULT, CURRENT_DATE, 16),
  (DEFAULT, CURRENT_DATE, 17);
--
-- Table structure for table prescricao
--
CREATE TABLE prescricao (
  id SERIAL NOT NULL,
  medicamento VARCHAR(255) NOT NULL,
  administracao VARCHAR(255) NOT NULL,
  id_prontuario integer NOT NULL,
  id_medico integer NOT NULL,
  data TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id_prontuario) REFERENCES prontuario (id)
  ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (id_medico) REFERENCES medico (id)
  ON DELETE NO ACTION ON UPDATE NO ACTION
);
--
-- Dumping data for table prescricao
--
INSERT INTO
  prescricao
VALUES
  (DEFAULT,'Tomat 1(um) comprimido','por via oral, a cada 12 horas, por 7 dias.',1,1,'2022-01-25 03:44:57'),
  (DEFAULT,'Mantidan 100 mg COMP Marca','Administrar 1 cp',1,1,'2022-01-25 15:22:16'),
  (DEFAULT,'DIPIRONA 500MG, CP 444 MG','COMPRIMIDO Administrar 3 MILIGRAMA, VIA FD - FEDIDIUM 1 x ao Dia Início: 23:00 - Diluir Conforme Protocolo da Unidade.',2,2,'2022-01-25 15:03:57'),
  (DEFAULT,'SORO FISIOLOGICO 0,9% - 10 ML 10,000 ML - FLACONETE, 100,00 ML - CLORETO DE SODIO 20% - 20 ML 20,000 ML - AMPOLA - ML 100,000 MILILITRO','Iniciar com 6,670 gt/min - Durante: 10:00 hora(s), Volume Total: 200,00 ML, Via EV - ENDOVENOSO 1x ao Dia',2,2,'2022-01-25 15:06:16'),
  (DEFAULT,'SORO FISIOLOGICO 0,9% - 10 ML 10,000 ML - FLACONETE, 100,00 ML - CLORETO DE SODIO 20% - 20 ML 20,000 ML - AMPOLA - ML 100,000 MILILITRO','Iniciar com 6,670 gt/min - Durante: 10:00 hora(s), Volume Total: 200,00 ML, Via EV - ENDOVENOSO 1x ao Dia',3,3,'2022-01-25 15:07:09'),
  (DEFAULT,'AAS 100 mg Comp Similar','Administrar 1 cp',3,3,'2022-01-25 15:07:38'),
  (DEFAULT,'Digoxina 0,5 mb COMP Marca','Administrar 1 CP',4,4,'2022-01-25 15:08:00'),
  (DEFAULT,'Mantidan 100 mg COMP Marca','Administrar 1 cp',5,5,'2022-01-25 15:08:19'),
  (DEFAULT,'Rocefin 1 gr FA IV Po Liof. Marca - 1g. 2º Soro Glicosado 5 % FR 250 ml Marca - 250 ml. - 3º Complexo B, AMP 2 ml Marca - 2 ml','Esquema de soro: correr durante 8 horas. Seq.: 1 - 1º Rocefin 1 gr FA IV Po Liof. Marca - 1g. 2º Soro Glicosado 5 % FR 250 ml Marca - 250 ml. - 3º Complexo B, AMP 2 ml Marca - 2 ml',5,5,'2022-01-25 15:10:29'),
  (DEFAULT,'Insulina H um N P H 100 Ul/ml FA 10 Marca','Conforme dextro - 0 - 200 administrar 5 ui - 201 - 300 administrar 7 ui - > ou = 301 administrar 10 ui',6,6,'2022-01-25 15:11:09'),
  (DEFAULT,'Insulina H um N P H 100 Ul/ml FA 10 Marca','Conforme dextro - 0 - 200 administrar 5 ui - 201 - 300 administrar 7 ui - > ou = 301 administrar 10 ui',7,7,'2022-01-25 15:11:56'
  );
--
-- Table structure for table atendimento
--
CREATE TABLE atendimento (
  id_medico integer NOT NULL,
  id_paciente integer NOT NULL,
  data_atendimento TIMESTAMP NOT NULL,
  data_agendamento TIMESTAMP NOT NULL,
  status_atendimento VARCHAR(20) NOT NULL DEFAULT 'Agendado',
  valor decimal(7, 2) NOT NULL,
  PRIMARY KEY (id_medico, id_paciente, data_atendimento),
  FOREIGN KEY (id_medico) REFERENCES medico (id),
  FOREIGN KEY (id_paciente) REFERENCES paciente (id)
);
--
-- Dumping data for table atendimento
--
INSERT INTO
  atendimento
VALUES
  (1,1,'2022-01-25 03:34:05','2022-01-02 00:00:00','Realizado',150.00  ),
  (1,13,'2022-01-25 03:39:38','2022-01-25 00:00:00','Agendado',799.99  ),
  (1,17,'2022-01-25 03:39:23','2022-01-25 00:00:00','Agendado',399.99  ),
  (1,18,'2022-01-25 03:39:29','2022-01-25 00:00:00','Agendado',399.99  ),
  (2,2,'2022-01-25 03:36:47','2022-01-04 00:00:00','Realizado',250.00  ),
  (2,2,'2022-01-25 03:37:25','2022-01-04 00:00:00','Agendado',250.00  ),
  (2,16,'2022-01-25 03:39:49','2022-01-25 00:00:00','Agendado',199.99  ),
  (3,3,'2022-01-25 03:37:52','2022-01-25 00:00:00','Agendado',250.00  ),
  (4,4,'2022-01-25 03:38:07','2022-01-25 00:00:00','Agendado',300.00  ),
  (4,6,'2022-01-25 03:38:25','2022-01-25 00:00:00','Agendado',399.99  ),
  (4,12,'2022-01-25 03:39:03','2022-01-25 00:00:00','Cancelado',399.99  );
--
-- Table structure for table atendimento
--
CREATE TABLE financeiro_consultorio_dia (
  data TIMESTAMP NOT NULL,
  total numeric NOT NULL,
  PRIMARY KEY (data)
);


--
-- CREATE FUNCTIONS, TRIGGERS, PROCEDURES, EXTRAS
--

-- SELEÇÃO DOS ATENDIMENTOS REALIZADOS NO DIA ATUAL DA CONSULTA

CREATE OR REPLACE FUNCTION qnt_atendimentos_hoje()
RETURNS integer
LANGUAGE PLPGSQL AS $$
  DECLARE atendimentos integer;
  BEGIN
    SELECT
      COUNT(*) AS QNT_ATENDIMENTOS
    FROM
      atendimento
    WHERE
      data_atendimento = CURRENT_DATE INTO atendimentos;
    RETURN atendimentos;
  END;
$$;

-- CRIAÇÃO DE METADATA (JSON) COM OS DADOS DO PACIENTE A PARTIR DO ID DO PRONTUÁRIO

CREATE OR REPLACE FUNCTION metadataPorIdProntuario(id INTEGER)
RETURNS TEXT
LANGUAGE PLPGSQL AS $$
  DECLARE metadata TEXT;
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
  END;
$$;


-- CRIAÇÃO DE TABELA COM OS DADOS DE MÉDICO, REALIZADO A PARTIR DA ESPECIALIZAÇÃO

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
  END;
$$;

-- INSERIR NOVA PRESCRIÇÃO NA TABELA

CREATE OR REPLACE PROCEDURE inserir_prescricao(medicamento TEXT, administracao TEXT, id_prontuario INTEGER, id_medico INTEGER, data_prescricao TIMESTAMP)
LANGUAGE PLPGSQL AS $$
	BEGIN
		INSERT INTO prescricao VALUES (DEFAULT, medicamento, administracao, id_prontuario, id_medico, data_prescricao);
	END;
$$;

-- DELETAR UMA PRESCRIÇÃO

CREATE OR REPLACE PROCEDURE deletar_prescricao(idPrescricao INTEGER)
LANGUAGE PLPGSQL AS $$
    BEGIN
        DELETE FROM prescricao WHERE prescricao.id = idPrescricao;
    END;
$$;

-- INSERIR RELATÓRIO FINANCEIRO DO DIA

CREATE OR REPLACE PROCEDURE financeiro_diario()
LANGUAGE PLPGSQL AS $$
  DECLARE total integer;
  BEGIN
      SELECT SUM(valor) AS total_arrecadado FROM atendimento WHERE data_atendimento = CURRENT_DATE INTO total;
      INSERT INTO financeiro_consultorio_dia VALUES (CURRENT_DATE, total);
  END;
$$;

-- VISUALIZAR OS ATENDIMENTOS REALIZADOS NO CONSULTÓRIO POR ORDEM DECRESCENTE DE DATA

CREATE VIEW vw_atendimentos_realizados AS
  SELECT
      paciente.nome AS Paciente,
      medico.nome AS "Médico",
      atendimento.data_atendimento AS "Data do Atendimento",
      atendimento.valor AS Valor
  FROM 
      atendimento
  JOIN paciente ON atendimento.id_paciente = paciente.id
  JOIN medico ON atendimento.id_medico = medico.id
  WHERE
      atendimento.status_atendimento = 'Realizado'
  ORDER BY
      atendimento.data_atendimento DESC;

-- VISUALIZAR OS ATENDIMENTOS AGENDADOS NO CONSULTÓRIO POR ORDEM DECRESCENTE DE DATA

CREATE VIEW vw_atendimentos_agendados AS
  SELECT
  	paciente.nome AS Paciente,
    medico.nome AS "Médico",
    atendimento.data_atendimento AS "Data do Atendimento",
    atendimento.valor AS Valor
  FROM
  	atendimento
  JOIN paciente ON atendimento.id_paciente = paciente.id
  JOIN medico ON atendimento.id_medico = medico.id
  WHERE
  	atendimento.status_atendimento = 'Agendado'
  ORDER BY
  	atendimento.data_atendimento DESC;

-- VISUALIZAR OS DADOS PROFISSIONAIS E DE CONTATO DOS MÉDICOS QUE ATENDEM NO CONSULTÓRIO

CREATE VIEW vw_dados_medicos AS
  SELECT
    medico.nome AS Nome,
    especializacao.nome AS "Especialização",
    medico.registro AS Registro,
    medico.celular AS Celular,
    medico.email AS "E-mail"
  FROM medico
  JOIN especializacao ON medico.id_especializacao = especializacao.id
  ORDER BY medico.nome ASC;

-- VISUALIZAR OS DADOS DE CONTATO DOS PACIENTES CADASTRADOS NO CONSULTÓRIO

CREATE VIEW dados_pacientes AS
  SELECT
    paciente.nome AS Nome,
    paciente.celular AS Celular,
    paciente.email AS "E-mail"
  FROM paciente
  ORDER BY paciente.nome ASC;

-- VISUALIZAR O NÚMERO DOS PRONTUÁRIOS DOS PACIENTES CADASTRADOS NO CONSULTÓRIO

CREATE VIEW qnt_prontuario AS
	SELECT paciente.nome AS Paciente,
    prontuario.id AS "Número do Prontuário"
	FROM paciente
	JOIN prontuario ON paciente.id = prontuario.id;


-- FECHAR ATENDIMENTO (ALTERANDO O STATUS DE ATENDIMENTO PARA REALIZADO E INSERINDO A PRESCRIÇÃO)

CREATE OR REPLACE PROCEDURE fecharAtendimento(idAtendimento INTEGER, prescricao VARCHAR)
LANGUAGE PLPGSQL AS $$
    DECLARE
      idProntuario integer;
      statusAtend VARCHAR;
    BEGIN
    	SELECT status_atendimento FROM atendimento WHERE id = $1 INTO statusAtend;
        IF statusAtend = "Agendado" THEN
            UPDATE atendimento
            SET status_atendimento = "Realizado"
            WHERE id = $1;

            SELECT p.id
            FROM prontuario p
            WHERE p.id = (SELECT a.id_paciente FROM atendimento a WHERE a.id = $1) INTO idProntuario;

            INSERT INTO prescricao VALUES ($2, idProntuario, CURRENT_DATE);
        ELSE
            RAISE EXCEPTION 'Erro ao fechar atendimento!';
        END IF;
END;
$$;
