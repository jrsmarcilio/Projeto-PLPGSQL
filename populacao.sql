CREATE DATABASE consultorio;

--
-- Table structure for table especializacao
--

CREATE TABLE especializacao (
  id int(11) NOT NULL AUTO_INCREMENT,
  nome varchar(255) NOT NULL,
  qnt_especializacao int(11) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY nome (nome)
);
--
-- Dumping data for table especializacao
--

INSERT INTO especializacao VALUES (1,'Gastroenterologista',3),(2,'Ginecologista',3),(3,'Endocrinologista',3),(4,'Dermatologista',3);

--
-- Table structure for table medico
--

CREATE TABLE medico (
  id int(11) NOT NULL AUTO_INCREMENT,
  registro varchar(20) NOT NULL,
  nome varchar(150) NOT NULL,
  celular varchar(20) DEFAULT NULL,
  email varchar(50) DEFAULT NULL,
  id_especializacao int(11) NOT NULL,
  CEP varchar(20) NOT NULL,
  numero varchar(10) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY registro (registro),
  KEY id_especializacao (id_especializacao),
  CONSTRAINT medico_ibfk_1 FOREIGN KEY (id_especializacao) REFERENCES especializacao (id)
);

--
-- Dumping data for table medico
--

INSERT INTO medico VALUES (1,'015974/PE','Dr João Marcio Garcia','(81) 9 9959-7113',NULL,1,'55819-068','55'),(2,'067439/PE','Dr Haniel Brião Bulhosa',NULL,NULL,1,'54230-661','57'),(3,'098755/PE','Dr Eliel Filipe Carmona',NULL,NULL,2,'55819-068','55'),(4,'099935/PE','Henzo Aquino Matias',NULL,NULL,2,'55608-312','08'),(5,'036596/SP','Dra Fabiana Argolo Graça',NULL,NULL,3,'53439-430','55'),(6,'025189/PE','Dr Jair Doutel Cavadas',NULL,NULL,3,'54735-330','08'),(7,'054059/PE','Dra Viviana Telinhos Carmona',NULL,NULL,4,'53439-430','5'),(8,'078682/PE','Dr Deivid Meireles Barroso',NULL,NULL,4,'54735-330','8'),(9,'070493/PE','Dra Carmona Viviana Telinhos',NULL,NULL,1,'53439-430','5'),(10,'070198/SP','Dra Camilla Meireles Barroso',NULL,NULL,2,'54735-330','8'),(11,'076943/PE','Dr Deivid Farias Vergueiro',NULL,NULL,3,'54320-136','7');

--
-- Table structure for table paciente
--

CREATE TABLE paciente (
  id int(11) NOT NULL AUTO_INCREMENT,
  cpf varchar(20) NOT NULL,
  nome varchar(150) NOT NULL,
  celular varchar(20) DEFAULT NULL,
  email varchar(50) NOT NULL,
  tipoSanguineo varchar(5) NOT NULL,
  CEP varchar(20) NOT NULL,
  numero varchar(10) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uk_paciente (cpf)
);

--
-- Dumping data for table paciente
--

INSERT INTO paciente VALUES (1,'311.954.500 -79','Jorge Casqueira Godinho','(81) 9 9959-7113','jorge_casqueira@email.com','AB','50610-300','35'),(2,'353.122.974-53','Isadora Guterres Bogado','(81) 8 2760-2296','isadora_guterres@email.com','A+','50110-435','45'),(3,'452.215.184-57','Melany Moutinho Saraiva','(81) 9 2211-2901','melany_moutinho@email.com','B+','50640-030','1621'),(4,'934.783.604-47','Zayn Fernandes Magalhães','(81) 8 3321-6582','zayn_fernandes@email.com','O+','50610-300','888'),(5,'563.576.984-58','Romeu Meira Modesto','(81) 9 4539-5543','romeu_meira@email.com','AB+','50110-110','2165'),(6,'475.444.784-08','Thomas Porciúncula Regodeiro','(81) 9 8699-9509','thomas_porciúncula@email.com','A-','51335-220','1421'),(7,'775.323.504-44','Zhen Caniça Machado','(81) 8 4518-8601','zhen_caniça@email.com','B-','52125-150','714'),(8,'447.896.964-72','Cloe Valverde Gaspar','(81) 9 2078-6747','cloe_valverde@email.com','O-','52125-150','1778'),(9,'813.731.074-64','Rubim Pegado Bicalho','(81) 9 8325-9152','rubim_pegado@email.com','AB-','50770-220','1308'),(10,'486.071.744-95','Haniela Quadros Rabelo','(81) 9 4886-5968','haniela_quadros@email.com','A+','53240-390','324'),(11,'906.974.024-95','Alonso Eiró Matias','(81) 9 3951-3405','alonso_eiró@email.com','B+','53320-633','2017'),(12,'655.507.694-17','Johnny Guterres Canejo','(81) 9 1228-1522','johnny_guterres@email.com','O+','53270-092','486'),(13,'057.897.364-24','Ânia Ruela Holanda','(81) 9 4836-8113','ânia_ruela@email.com','AB+','53060-507','543'),(14,'554.462.394-58','Tiffany Palma Cordeiro','(81) 9 9224-7692','tiffany_palma@email.com','A-','53020-091','91'),(15,'759.392.504-83','Inara Vidigal Breia','(81) 8 5510-9651','inara_vidigal@email.com','B-','53330-570','77'),(16,'608.923.814-77','Júlia Cipriano Travassos','(81) 8 9491-4349','júlia_cipriano@email.com','O-','54360-123','23'),(17,'150.006.254-55','Luiz Caeira Castilho','(81) 9 4995-6849','luiz_caeira@email.com','AB-','54410-745','82'),(18,'349.547.314-96','Indira Barreno Maciel','(81) 9 1217-4021','indira_barreno@email.com','A+','54355-321','1258');

--
-- Table structure for table prontuario
--

CREATE TABLE prontuario (
  id int(11) NOT NULL AUTO_INCREMENT,
  dataAbertura datetime NOT NULL,
  id_paciente int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY fk_prontuario (id_paciente),
  CONSTRAINT fk_prontuario FOREIGN KEY (id_paciente) REFERENCES paciente (id)
);

--
-- Dumping data for table prontuario
--

INSERT INTO prontuario VALUES (1,'2022-01-25 03:42:09',1),(2,'2022-01-25 03:42:22',2),(3,'2022-01-25 03:42:23',3),(4,'2022-01-25 03:42:24',4),(5,'2022-01-25 03:42:25',5),(6,'2022-01-25 03:42:27',6),(7,'2022-01-25 03:42:29',7),(8,'2022-01-25 03:42:30',8),(9,'2022-01-25 03:42:33',9),(10,'2022-01-25 03:42:34',10),(11,'2022-01-25 03:42:36',11),(12,'2022-01-25 03:42:37',12),(13,'2022-01-25 03:42:38',13),(14,'2022-01-25 03:42:39',14),(15,'2022-01-25 03:42:40',15),(16,'2022-01-25 03:42:42',16);

--
-- Table structure for table prescricao
--

CREATE TABLE prescricao (
  descricao varchar(255) NOT NULL,
  id_prontuario int(11) NOT NULL,
  data datetime NOT NULL,
  PRIMARY KEY (id_prontuario,data),
  KEY id_prontuario (id_prontuario),
  CONSTRAINT prescricao_ibfk_1 FOREIGN KEY (id_prontuario) REFERENCES prontuario (id)
);

--
-- Dumping data for table prescricao
--

INSERT INTO prescricao VALUES ('Tomat 1(um) comprimido, por via oral, a cada 12 (doze) horas, por 7 (sete) dias.',1,'2022-01-25 03:44:57'),('Mantidan 100 mg COMP Marca - Administrar 1 cp',1,'2022-01-25 15:22:16'),('Não esquecer de tomar os medicamentos na hora certa. Não interromper o tratamento, mesmo havendo desaparecimento dos sintomas.',2,'2022-01-25 03:45:38'),('DIPIRONA 500MG, CP 444 MG - COMPRIMIDO Administrar 3 MILIGRAMA, VIA FD - FEDIDIUM 1 x ao Dia Início: 23:00 - Diluir Conforme Protocolo da Unidade.',3,'2022-01-25 15:03:57'),('SORO FISIOLOGICO 0,9% - 10 ML 10,000 ML - FLACONETE, 100,00 ML - CLORETO DE SODIO 20% - 20 ML 20,000 ML - AMPOLA - ML 100,000 MILILITRO - Iniciar com 6,670 gt/min - Durante: 10:00 hora(s), Volume Total: 200,00 ML, Via EV - ENDOVENOSO 1x ao Dia',4,'2022-01-25 15:06:16'),('SORO FISIOLOGICO 0,9% - 10 ML 10,000 ML - FLACONETE, 100,00 ML - CLORETO DE SODIO 20% - 20 ML 20,000 ML - AMPOLA - ML 100,000 MILILITRO - Iniciar com 6,670 gt/min - Durante: 10:00 hora(s), Volume Total: 200,00 ML, Via EV - ENDOVENOSO 1x ao Dia',5,'2022-01-25 15:07:09'),('AAS 100 mg Comp Similar - Administrar 1 cp',6,'2022-01-25 15:07:38'),('Digoxina 0,5 mb COMP Marca - Administrar 1 CP',7,'2022-01-25 15:08:00'),('Mantidan 100 mg COMP Marca - Administrar 1 cp',8,'2022-01-25 15:08:19'),('Esquema de soro: correr durante 8 horas. Seq.: 1 - 1º Rocefin 1 gr FA IV Po Liof. Marca - 1g. 2º Soro Glicosado 5 % FR 250 ml Marca - 250 ml. - 3º Complexo B, AMP 2 ml Marca - 2 ml',9,'2022-01-25 15:10:29'),('Insulina H um N P H 100 Ul/ml FA 10 Marca',10,'2022-01-25 15:11:09'),('Insulina H um N P H 100 Ul/ml FA 10 Marca - Conforme dextro - 0 - 200 administrar 5 ui - 201 - 300 administrar 7 ui - > ou = 301 administrar 10 ui',11,'2022-01-25 15:11:56');

--
-- Table structure for table atendimento
--

CREATE TABLE atendimento (
  id_medico int(11) NOT NULL,
  id_paciente int(11) NOT NULL,
  data_atendimento datetime NOT NULL,
  data_agendamento datetime NOT NULL,
  status_atendimento varchar(20) NOT NULL DEFAULT 'Agendado',
  valor float(7,2) NOT NULL,
  PRIMARY KEY (id_medico,id_paciente,data_atendimento),
  KEY id_paciente (id_paciente),
  CONSTRAINT atendimento_ibfk_1 FOREIGN KEY (id_medico) REFERENCES medico (id),
  CONSTRAINT atendimento_ibfk_2 FOREIGN KEY (id_paciente) REFERENCES paciente (id)
);
--
-- Dumping data for table atendimento
--
INSERT INTO atendimento VALUES (1,1,'2022-01-25 03:34:05','2022-01-02 00:00:00','Realizado',150.00),(1,13,'2022-01-25 03:39:38','2022-01-25 00:00:00','Agendado',799.99),(1,17,'2022-01-25 03:39:23','2022-01-25 00:00:00','Agendado',399.99),(1,18,'2022-01-25 03:39:29','2022-01-25 00:00:00','Agendado',399.99),(2,2,'2022-01-25 03:36:47','2022-01-04 00:00:00','Realizado',250.00),(2,2,'2022-01-25 03:37:25','2022-01-04 00:00:00','Agendado',250.00),(2,16,'2022-01-25 03:39:49','2022-01-25 00:00:00','Agendado',199.99),(3,3,'2022-01-25 03:37:52','2022-01-25 00:00:00','Agendado',250.00),(4,4,'2022-01-25 03:38:07','2022-01-25 00:00:00','Agendado',300.00),(4,6,'2022-01-25 03:38:25','2022-01-25 00:00:00','Agendado',399.99),(4,12,'2022-01-25 03:39:03','2022-01-25 00:00:00','Cancelado',399.99);











