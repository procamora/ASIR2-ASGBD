// DESACTIVAR LA SALIDA DE MENSAJES PARA EL ADMINISTRADOR POR LA CONSOLA:

SET SERVEROUTPUT OFF;

// ACTIVAR LA SALIDA DE MENSAJES PARA EL ADMINISTRADOR POR LA CONSOLA:

SET SERVEROUTPUT ON;

// PRIMER BLOQUE ANONIMO: Hola mundo.

BEGIN
  dbms_output.put_line('Hola mundo');
END;
/

// PRIMER USO DE VARIABLES.

DECLARE
  texto VARCHAR2(15);
BEGIN
  texto := 'Hola mundo 2';
  dbms_output.put_line (texto);
END;
/

// PRIMER USO DE MANIPULACION DE DATOS

DECLARE
  v_id  VARCHAR2(15);
  v_des VARCHAR2(100);
  V_pre NUMBER(10,4);
BEGIN

  v_id  := 'CUS2';
  v_des := 'Cable USB 2Mts';
  v_pre := 0.80;

  insert into articulos (id,descripcion,precio)
    values (v_id,v_des,v_pre);
END;
/

// EL EJEMPLO ANTERIOR USANDO ALIAS DE DOMINIOS

DECLARE
  v_id  articulos.id%TYPE;
  v_des articulos.descripcion%TYPE;
  V_pre articulos.precio%TYPE;
BEGIN

  v_id  := 'CUS2';
  v_des := 'Cable USB 2Mts';
  v_pre := 0.80;

  insert into articulos (id,descripcion,precio)
    values (v_id,v_des,v_pre);
END;
/

// PRIMER EJEMPLO DE PROCEDIMIENTO (Stored procedure)

CREATE OR REPLACE PROCEDURE HolaMundo AS
  texto VARCHAR2(15);
BEGIN
  texto := 'Hola mundo 2';
  dbms_output.put_line (texto);
END;
/

// EL PROCEDIMIENTO ANTERIOR PERO PASANDO COMO ARGUMENTO EL TEXTO

CREATE OR REPLACE PROCEDURE HolaMundo2 (texto VARCHAR2) AS
BEGIN
  dbms_output.put_line ('Imprime esto: '||texto);
END;
/

// PROCEDIMIENTO PARA MODIFICAR EL IMPORTE DE UN ALBARAN

CREATE OR REPLACE PROCEDURE TotalizaAlbaran
  (p_id_albaran NUMBER,
   p_base NUMBER,
   p_piva NUMBER)
AS
BEGIN
  update albaranes
    set 
      base=p_base,
      piva=p_piva,
      civa=p_base*(p_piva/100),
      total=p_base*(1+(p_piva/100))
    where id=p_id_albaran;
END;
/

// EJEMPLO DE INVOCACION DEL PROCEDIMIENTO ANTERIOR

exec TotalizaAlbaran(1,200,21);

// PRIMER EJEMPLO DE CONSULTA SELECT

DECLARE
  v_nombre VARCHAR2(15);
BEGIN

  SELECT nombre INTO v_nombre
    FROM CLIENTES
    WHERE id=1;

  dbms_output.put_line (v_nombre);
END;
/

// MEJORA DEL PROCEDIMIENTO ANTERIOR PARA...
// ...QUE CALCULE PRIMERO LOS IMPORTES DE SUS LINEAS...
// ...Y PARA QUE SUME ESOS IMPORTES EN LA BASE AUTOMATICAMENTE

CREATE OR REPLACE PROCEDURE TotalizaAlbaran2
  (p_id_albaran NUMBER,
   p_piva NUMBER)
AS
  v_total_importe albaranes.base%TYPE;
BEGIN

  /* Paso 1: calcular los importes de las líneas relacionadas */
  update albaranes_det
    set importe=precio*cantidad
    where id=p_id_albaran;

  /* Paso 2: sumar los importes recién calculados */
  select sum(importe) into v_total_importe
    from albaranes_det
    where id=p_id_albaran;

  /* Paso 3: lo mismo de antes, pero usando el v_total_importe*/
  update albaranes
    set 
      base=v_total_importe,
      piva=p_piva,
      civa=v_total_importe*(p_piva/100),
      total=v_total_importe*(1+(p_piva/100))
    where id=p_id_albaran;
END;
/

// Prueba del procedimiento anterior

exec TotalizaAlbaran2(1,21);
