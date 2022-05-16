-- PRESTAR ATENÇÃO POIS ESSA TABELA APARENTA JÁ ESTAR CRIADA, PRECISANDO SÓ SER ATUALIZADA

CREATE TABLE prescricao (
	"id" SERIAL NOT NULL,
  "medicamento" varchar(255) NOT NULL,
  "administracao" varchar(255) NOT NULL,
	"id_prontuario" int4 NOT NULL,
	"id_medico" int4 NOT NULL,
	CONSTRAINT "id_prontuario" FOREIGN KEY ("id_prontuario") REFERENCES "public"."prontuario" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT "id_medico" FOREIGN KEY ("id_medico") REFERENCES "public"."medico" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
  "data" timestamp NOT NULL,
	PRIMARY KEY ("id")
);

INSERT INTO prescricao VALUES
(default,'Azitromicina 500 mg','Tomar 1(um) comprimido, por dia, por 3 (três) dias, por via oral.', 1, 1,'2022-01-25 03:44:57'),
(default,'Dipirona 500MG','Tomar 1(um) comprimido, se sentir dor ou febre, por via oral.', 1, 1,'2022-01-25 03:44:57'),
(default,'Primogyna 2mg', 'Tomar 1(um) comprimido, por dia, sempre que possível na mesma hora, por via oral,', 2, 2, '2022-01-25 03:44:57');

CREATE TABLE "financeiro_consultorio_dia" (
  "data" DATA,
  "total" numeric NOT NULL,
  PRIMARY KEY ("data"),
);