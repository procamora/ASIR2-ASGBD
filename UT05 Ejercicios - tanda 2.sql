Ejercicio_5_2_1.txt
Procedimiento �ActualizaTarifa�, al que se le pasa como argumento un porcentaje (de 0 a 100) e incrementa los precios de todos los art�culos en el porcentaje indicado. Por ejemplo, si se le pasa 20 incrementar�a todos los precios en un 20% (esto es, los multiplica por 1,2).
El procedimiento deber� lanzar un error si el porcentaje es inferior o igual a cero o superior a 100.

CREATE OR REPLACE PROCEDURE ActualizaTarifa (p_porcentaje ARTICULOS.PRECIO%TYPE)
AS
	v_precio ARTICULOS.PRECIO%TYPE;
	v_por NUMBER
BEGIN
	IF	p_porcentaje BETWEEN 0 AND 100 
	THEN
		SELECT PRECIO
		INTO v_precio
		FROM ARTICULOS;

		v_por := v_precio*1+(p_porcentaje/100)
		UPDATE ARTICULOS
		SET PRECIO=v_por;
		
	ELSE
		RAISE_APPLICATION_ERROR(-20001,'Introduce un numero entre 0 y 100');
	END IF;
END; 


Ejercicio_5_2_2.txt
Vamos a completar la tabla albaranes con un campo que determine su estado: A-Abierto o C-Confirmado. Estableceremos los existentes en estado �A�:
ALTER TABLE ALBARANES ADD ESTADO CHAR(1);
UPDATE ALBARANES SET ESTADO=�A�;
Entendemos que un albar�n confirmado es aquel que est� correcto y ya se puede facturar.
Procedimiento �ConfirmaAlbaran�, al que se le pasa como argumento el id de un albar�n y realiza estas comprobaciones:
? El albar�n debe estar previamente en estado �A�, para poder ser confirmado.
? El albar�n debe poseer al menos una l�nea de detalle relacionada.
? El albar�n debe poseer importe distinto de cero.
? El cliente no puede estar dado de baja (su fecha de baja debe ser nula).
S�lo si todas las condiciones se cumplen, el albar�n se marcar� en estado �C�. Si alguna no se cumple, se deber� alertar con una excepci�n personalizada.

CREATE OR REPLACE PROCEDURE ConfirmaAlbaran (p_id_albaran ALBARANES.ID%TYPE)
AS
	v_estado ALBARANES.ESTADO%TYPE;
	v_linea ALBARANES_DET.LINEA%TYPE;
	v_importe ALBARANES_DET.IMPORTE%TYPE;
	v_fec_baja CLIENTES.FEC_BAJA%TYPE;
BEGIN
	/*PUNTO 1*/
	SELECT ESTADO
	INTO v_estado
	FROM ALBARANES
	WHERE ID=p_id_albaran;
	
	/*PUNTO 2*/
	SELECT LINEA
	INTO v_linea
	FROM ALBARANES_DET
	WHERE ID=p_id_albaran;
	
	/*PUNTO 3*/
	SELECT IMPORTE
	INTO v_importe
	FROM ALBARANES_DET
	WHERE ID=p_id_albaran;
	
	/*PUNTO 4*/
	SELECT FEC_BAJA
	INTO v_fec_baja
	FROM CLIENTES
	WHERE ID=p_id_albaran;
	
	IF v_estado = 'A' AND v_linea >= 1 AND v_importe <> 0 AND v_fec_baja IS NULL
	THEN
	UPDATE ALBARANES
	SET ESTADO='C'
	WHERE ID=p_id_albaran;

	ELSE IF v_estado != 'A' 
	THEN
		RAISE_APPLICATION_ERROR(-20002,'El estado debe ser A');
	END IF;
	
	ELSE IF v_linea = 0 
	THEN
		RAISE_APPLICATION_ERROR(-20003,'El albar�n debe poseer al menos una l�nea de detalle relacionada');
	END IF;
	
	ELSE IF v_importe = 0 
	THEN
		RAISE_APPLICATION_ERROR(-20004,'El albar�n debe poseer importe distinto de cero');
	END IF;
	
	ELSE IF v_fec_baja IS NOT NULL 
	THEN
		RAISE_APPLICATION_ERROR(-20005,'El cliente no puede estar dado de baja');
	END IF;
	
	ELSE
		RAISE_APPLICATION_ERROR(-20006,'Fallo desconocido');
	END IF;
END;



Ejercicio_5_2_3.txt
Procedimiento �CopiaAlbaran� al que se le pase como argumento el id de un albar�n existente, el id de un cliente y una fecha, para que, de esa forma, genere un nuevo albar�n con los valores pasados en los argumentos y conteniendo el mismo detalle, precios, impuestos e importes que el albar�n que se pasa como par�metro de entrada.
AYUDA: la duplicaci�n de l�neas de detalle puede hacerse con un comando �insert� basado en una subconsulta (se insertan los registros que arroja una subconsulta). Esto es:


CREATE OR REPLACE PROCEDURE CopiaAlbaran 
(p_id_albaran ALBARANES.ID%TYPE; 
p_id_cliente ALBARANES.ID_CLIENTE%TYPE;%TYPE;
p_fecha ALBARANES.FECHA%TYPE;)

SELECT COUNT(*)
INTO v_num
FROM ALBARANES


INSERT INTO ALBARANES (ID, ID_CLIENTE, FECHA)
VALUES (SELECT atributos_o_constantes 
		FROM <tabla>
		WHERE);


