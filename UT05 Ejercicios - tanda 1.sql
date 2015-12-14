Ejercicios_5_1_1.txt

Desarollar un procedimiento ActualizaPrecioArticulo, al que se le pase como argumento 
el id de un artículo y ponga su precio en todas las líneas de albarán en las que aparece.
El importe de las líneas debe quedarse bien calculado.

CREATE OR REPLACE PROCEDURE ActualizaPrecioArticulo (p_id_articulo albaranes_det.id%type)
AS
	v_precio ARTICULOS.PRECIO%type;
BEGIN
	SELECT PRECIO
	INTO v_precio
	FROM ARTICULOS
	WHERE ID=p_id_articulo;
	
	UPDATE ALBARANES_DET
	SET PRECIO=v_precio,
	IMPORTE=CANTIDAD*v_precio
	WHERE ID_ARTICULO=p_id_articulo;
END;

Ejercicios_5_1_2.txt

Desarollar un procedimiento DuplicaAlbaran, al que se le pase como argumento 
el id de un albarán y duplique todas las cantidades de sus líneas, 
dejando los importes bien calculados (también los totales del albarán).

CREATE OR REPLACE PROCEDURE DuplicaAlbaran (p_id_albaran albaranes_det.id%type)
AS
	v_cantidad albaranes_det.cantidad%type;
BEGIN
	SELECT CANTIDAD
	INTO v_cantidad
	FROM ALBARANES_DET
	WHERE ID=p_id_albaran;
	
	UPDATE ALBARANES_DET
	SET CANTIDAD=2*v_cantidad,
	IMPORTE=CANTIDAD*PRECIO
	WHERE ID=p_id_albaran;
END;

Ejercicios_5_1_3.txt

Desarrollar un procedimiento BajaCliente, al que se le pase como argumento el 
id de un cliente y le ponga como fecha de baja la del último albarán que se le emitió. 

CREATE OR REPLACE PROCEDURE BajaCliente (p_id_cliente clientes.id%type)
AS 
	v_fecha ALBARANES.FECHA%TYPE;
BEGIN
	SELECT FECHA
	INTO v_fecha
	FROM ALBARANES
	WHERE ID_CLIENTE=p_id_cliente;
	
	UPDATE CLIENTES
	SET FEC_BAJA=v_fecha
	WHERE ID=p_id_cliente;
END;


