#Esboco geral da lógica, necassario mudar as chaves e colocar as restrições

CREATE TABLE classe(
	aviao CHAR(6),
    nome CHAR(2),
--
	CONSTRAINT pk_classe
		PRIMARY KEY (aviao, nome),
--
	CONSTRAINT fk_classe_aviao
		FOREIGN KEY (aviao) REFERENCES aviao (tail_number) 
        ON DELETE CASCADE,
--
	CONSTRAINT ck_classe_nome
		CHECK (nome IN ('fc','bu','ec'))
);


CREATE TABLE lugar (
	aviao CHAR(6), 
    classe CHAR(2),
	fila CHAR(1),
	numero SMALLINT,
--
	CONSTRAINT pk_lugar_pk
		PRIMARY KEY (aviao,classe,fila,numero),
--
	CONSTRAINT fk_lugar_classe
    FOREIGN KEY (aviao,classe) REFERENCES classe(tail_number,nome) ON DELETE CASCADE
);

CREATE TABLE preço (
	classe CHAR(2),
    voo_programado VARCHAR(10),
    valor NUMERIC(6,2) NOT NULL,	 #valor > 0 #valor vai ate quanto?
--
	CONSTRAINT pk_preço
		PRIMARY KEY (nome, ID_voo),
--
	CONSTRAINT fk_preço_classe
		FOREIGN KEY (classe) REFERENCES classe (nome),
--
	CONSTRAINT
		FOREIGN KEY (voo_programado) REFERENCES voo_programado (data),
--	
	CONSTRAINT 
		CHECK (valor > 0)
);
CREATE TABLE passageiro (
	nic NUMERIC(9) , 
	email VARCHAR(30) NOT NULL,
	telemovel VARCHAR(20) NOT NULL,
    nome VARCHAR(20) NOT NULL,
    nif NUMERIC(9),
--
	CONSTRAINT pk_passageiro
		PRIMARY KEY (nic),
--
	CONSTRAINT un_passageiro_telemovel
		UNIQUE (telemovel),
--
	CONSTRAINT un_passageiro_email
		UNIQUE (email)
);

CREATE TABLE frequent_flyer ( # cada passageiro pode se inscrever no max em 5 companhias aereas
	companhia CHAR(3),
	passageiro NUMERIC(9),
    tipo_de_cliente CHAR(20) NOT NULL, 
-- 
	CONSTRAINT pk_frequent_flyer
		PRIMARY KEY (companhia,passageiro),
--
	CONSTRAINT fk_frequent_flyer_passageiro
		FOREIGN KEY (passageiro) REFERENCES passageiro,
--
	CONSTRAINT fk_frequent_flyer_companhia
    FOREIGN KEY (companhia) REFERENCES companhia,
    
--
	CONSTRAINT ck_frequent_flyer_tipo_de_cliente
		CHECK (tipo_de_cliente IN ('classic','special'))
--
# falta constrain das 5 relações
);
CREATE TABLE bilhete (
	voo_programado DATE,
    fila_lugar CHAR(1),
    numero_lugar SMALLINT,
    passageiro NUMERIC(9) NOT NULL,
--
	CONSTRAINT pk_bilhete
    PRIMARY KEY(voo_programado, fila_lugar, numero_lugar),
--
	CONSTRAINT fk_bilhete_lugar
    FOREIGN KEY (fila_lugar,numero_lugar) REFERENCES lugar(fila,numero),
-- 
	CONSTRAINT fk_bilhete_voo_programado
    FOREIGN KEY (voo_programado) REFERENCES voo_programado,
--
	CONSTRAINT fk_bilhete_passageiro
		FOREIGN KEY(passageiro) REFERENCES passageiro(nic)
);
    

    
	
	
    

    
    
    
    
    
    





