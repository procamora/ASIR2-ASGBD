CREATE TABLE CLIENTES
(
  ID NUMBER (6,0) NOT NULL PRIMARY KEY,
  NOMBRE VARCHAR2(60) NOT NULL,
  CIF VARCHAR2(15) NOT NULL,
  DIR1 VARCHAR2(100),
  DIR2 VARCHAR2(100),
  DIR3 VARCHAR2(100),
  FEC_ALTA DATE NOT NULL,
  FEC_BAJA DATE
);

CREATE TABLE ARTICULOS
(
  ID VARCHAR2(15) NOT NULL PRIMARY KEY,
  DESCRIPCION VARCHAR2(100) NOT NULL,
  COD_BARRAS VARCHAR2(15),
  PRECIO NUMBER(10,4)
);

CREATE TABLE ALBARANES
(
  ID NUMBER(8,0) NOT NULL PRIMARY KEY,
  FECHA DATE NOT NULL,
  ID_CLIENTE NUMBER(6,0) NOT NULL REFERENCES CLIENTES(ID),
  BASE NUMBER(12,2),
  PIVA NUMBER(4,2),
  CIVA NUMBER(12,2),
  TOTAL NUMBER(12,2)
);

CREATE TABLE ALBARANES_DET
(
  ID NUMBER(8,0) NOT NULL REFERENCES ALBARANES(ID),
  LINEA NUMBER(6,0) NOT NULL,
  ORDEN NUMBER(6,0),
  ID_ARTICULO VARCHAR2(15) NOT NULL REFERENCES ARTICULOS(ID),
  DESCRIPCION VARCHAR2(100) NOT NULL,
  PRECIO NUMBER (10,4),
  CANTIDAD NUMBER (10,4),
  IMPORTE NUMBER (12,2),
  PRIMARY KEY (ID,LINEA)
);

insert into clientes (id,nombre,cif,fec_alta) values (1,'PEPE' ,'12345678Z','1/1/2010');
insert into clientes (id,nombre,cif,fec_alta) values (2,'PACO' ,'23456781Z','2/2/2011');
insert into clientes (id,nombre,cif,fec_alta) values (3,'MARIA','34567812Z','3/3/2012');

insert into articulos (id,descripcion,precio) values ('VAR','Varios',0);
insert into articulos (id,descripcion,precio) values ('HD1T','Disco duro 1TB',60);
insert into articulos (id,descripcion,precio) values ('MD4G','Memoria DDR3 4GB',20);

insert into albaranes (id,fecha,id_cliente) values (1,'5/1/2013',3);
insert into albaranes (id,fecha,id_cliente) values (2,'5/1/2013',1);
insert into albaranes (id,fecha,id_cliente) values (3,'7/1/2013',2);
insert into albaranes (id,fecha,id_cliente) values (4,'7/1/2013',2);
insert into albaranes (id,fecha,id_cliente) values (5,'7/1/2013',1);
insert into albaranes (id,fecha,id_cliente) values (6,'8/1/2013',3);

insert into albaranes_det (id,linea,orden,id_articulo,descripcion,precio,cantidad) values (1,1,1,'VAR','Mano de obra',25,2);
insert into albaranes_det (id,linea,orden,id_articulo,descripcion,precio,cantidad) values (1,2,2,'VAR','Desplazamiento',25,1);
insert into albaranes_det (id,linea,orden,id_articulo,descripcion,precio,cantidad) values (1,3,3,'MD4G','Memoria 4GB',21,1);

commit;