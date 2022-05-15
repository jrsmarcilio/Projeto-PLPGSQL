-- --------------------------------------------
-- Questão 4
create view musica_artista AS
select M.titulo, A.nome_artista
from musica m LEFT JOIN artista a ON M.cod_artista=a.codigo
LEFT JOIN faz_parte fp on fp.cod_musica=m.codigo
where cod_musica is null;

create view musica_artista2 AS
select M.titulo, A.nome_artista as compositor
from musica m LEFT JOIN artista a ON M.cod_artista=a.codigo
where m.codigo not in (select cod_musica from faz_parte)

-- --------------------------------------------
-- Questão 5
create view Artista_qtdeMusica as
select A.nome_artista, COUNT( M.titulo) as qtde_musica 
from musica m right JOIN artista a ON M.cod_artista=a.codigo
group by A.nome_artista;

-- --------------------------------------------
-- QUESTÃO 6
SELECT nome_artista FROM artista_qtdemusica
WHERE qtde_musica >= 3
order by qtde_musica desc

-- --------------------------------------------
-- QUESTÃO 7
CREATE OR REPLACE FUNCTION qtdeMusicas_album (p_nome text)
returns INTEGER
language PLPGSQL AS $$
DECLARE
  v_retorno integer;
BEGIN
  SELECT COUNT(fp.cod_musica) INTO v_retorno
    FROM ALBUM left JOIN faz_parte FP ON codigo=fp.cod_musica
    WHERE nome = p_nome
    GROUP BY NOME ;
  return v_retorno;
END;$$;

select qtdemusicas_album('Romântico Teste');

-- --------------------------------------------
-- QUESTÃO 8
CREATE OR REPLACE PROCEDURE inserirAlbum (p_nome text)
language PLPGSQL AS $$
DECLARE
  novoID INTEGER;
BEGIN
	select max(codigo)+1 from album INTO novoID;
  	insert into album values (novoID,p_nome,false,null);
END;$$;

CREATE OR REPLACE PROCEDURE inserirAlbum2 (p_nome text)
language SQL AS $$	 
  	insert into album values ((select max(codigo)+1 from album),p_nome,false,null);
$$;

call inseriralbum2('Músicas de Carol 2');
select * from album;

-- Se precisasse verificar o nome como único:
CREATE OR REPLACE PROCEDURE inserirAlbum3 (p_nome text)
language PLPGSQL AS $$
DECLARE
  novoID INTEGER;
  v_jaExiste boolean;
BEGIN
	Select true into v_jaExiste from album where nome=p_nome;
    if v_jaExiste IS NULL THEN
      select max(codigo)+1 from album INTO novoID;
      insert into album values (novoID,p_nome,false,null);
    ELSE
      raise EXCEPTION 'Nome já existe na base!' p_nome;
    end IF;
END;$$;

call inseriralbum3('Músicas de Carol 3');

-- --------------------------------------------
-- Questão 9
CREATE OR REPLACE PROCEDURE inserirMusica (m_titulo text, m_duracao integer, a_nome text)
language PLPGSQL AS $$
DECLARE
  v_codArtista INTEGER;
  v_jaExiste boolean;
BEGIN
	Select codigo into v_codArtista from artista where nome_artista=a_nome;
    if v_codArtista is null THEN
    	select max(codigo)+1 from artista INTO v_codArtista;
    	insert into artista values (v_codArtista, a_nome, null, null);
    end if;
    insert into musica values ((select max(codigo)+1 from musica), m_titulo, 2020, m_duracao, v_codArtista);
END;$$;

call inserirmusica('Musica Nova', 145, 'Carolina Torres 2');
select * from musica;

-- --------------------------------------------
-- Questão 10
create view v_questao10 AS
select al.nome, m.titulo, a.nome_artista
from artista a join musica M on M.cod_artista=A.codigo
join faz_parte fp on m.codigo=fp.cod_musica
join album al on al.codigo=fp.cod_album;

drop FUNCTION musicasArtista_deAlbum;
CREATE OR REPLACE FUNCTION musicasArtista_deAlbum (p_nomeAlbum text)
returns table (A_nome varchar(30), qtdeMusicas bigint)
language PLPGSQL AS $$
DECLARE
  v_retorno integer;
BEGIN
  return query select nome_artista, count(titulo) from v_questao10
    where nome = p_nomeAlbum
    group by nome_artista;
END;$$;
select * from musicasArtista_deAlbum('Romântico Misto');

CREATE OR REPLACE FUNCTION musicasArtista_deAlbum2 (p_nomeAlbum text)
returns table (A_nome varchar(30), qtdeMusicas bigint)
language PLPGSQL AS $$
DECLARE
  v_retorno integer;
BEGIN
  return query 
  	select a.nome_artista, count(m.titulo)
      from artista a join musica M on M.cod_artista=A.codigo
      join faz_parte fp on m.codigo=fp.cod_musica
      join album al on al.codigo=fp.cod_album      
      where al.nome = p_nomeAlbum
   	  group by nome_artista;    
END;$$;
select * from musicasArtista_deAlbum2('Romântico Misto');

-- --------------------------------------------
-- Questão 11
CREATE OR REPLACE PROCEDURE associarMusicacomAlbum (m_titulo text, a_nome text)
language PLPGSQL AS $$
DECLARE
  v_codMusica INTEGER;
  v_codAlbum integer;
BEGIN
	Select codigo into v_codMusica from musica where título=m_titulo;
    Select codigo into v_codAlbum from album where nome=a_nome;
    if v_codMusica is null THEN
    	raise exception 'Música não existe!';
    elseif v_codAlbum is null THEN
    	raise EXCEPTION 'Album não existe!';
    ELSE
    	insert into faz_parte values (v_codMusica,v_codAlbum);
    end if;
END;$$;

call associarmusicacomalbum('Meu Bem Querer', 'Romântico Internacional');

-- --------------------------------------------
-- Questão 12
CREATE or replace FUNCTION atualizar_podeLancar()
RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
DECLARE	
	qtde_musicas integer;
BEGIN
    select count(cod_musica) from faz_parte where cod_album=new.cod_album INTO qtde_musicas;
    if qtde_musicas >=5 THEN
    	update album set pode_lancar=true where codigo=new.cod_album;
    end if;
	return new;
END; $$;

CREATE or replace TRIGGER tr_podeLancarT
after insert ON faz_parte
FOR EACH ROW
EXECUTE PROCEDURE atualizar_podeLancar();

insert into album values (10,'Teste', false,null);
insert into faz_parte values (1,10),(2,10),(3,10),(4,10);
select * from album where codigo=10; -- ainda está false
insert into faz_parte values (5,10);
select * from album where codigo=10; -- Aqui já está true

-- --------------------------------------------
-- Questão 13
CREATE or replace FUNCTION atualizar_podeLancar2()
RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
DECLARE	
	qtde_musicas integer;
BEGIN
    select count(cod_musica) from faz_parte where cod_album=old.cod_album INTO qtde_musicas;
    if qtde_musicas < 5 THEN
    	update album set pode_lancar=false where codigo=old.cod_album;
    end if;
	return old;
END; $$;

CREATE or replace TRIGGER tr_podeLancarF
before delete ON faz_parte
FOR EACH ROW
EXECUTE PROCEDURE atualizar_podeLancar2();

select * from album where codigo=10; -- ainda está true
delete from faz_parte where cod_musica=4 and cod_album=10;
select * from album where codigo=10; -- Aqui já está false

-- --------------------------------------------
-- Questão 14
CREATE or replace FUNCTION atualizar_dtLancamento()
RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
DECLARE	
	v_podeLancar boolean;
BEGIN
    select pode_lancar from album where codigo=new.codigo INTO v_podeLancar;
    if v_podeLancar = False THEN
    	raise EXCEPTION 'Não pode marcar o lançamento de um album sem ele estar apto';
    end if;
	return new;
END; $$;

CREATE or replace TRIGGER tr_dtLancamento
before update ON album
FOR EACH ROW
EXECUTE PROCEDURE atualizar_dtLancamento();

select * from album;
update album set dt_lancamento='2022-06-20' where codigo=10;
select * from album;