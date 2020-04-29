# Trigger-auditoria-MySql
trigger basico para auditar eventos de las transacciones exitentes en una base de datos en el motor SQL (relacional) MySql.


Esta base de datos es una maqueta cuya funsionalidad es la llevar la administracion de equipos moviles, contiene 5 tablas:
1. Distribuidor: contiene los datos de los distribuidores.
2. Caracteristicas: contiene las caracteristicas de los celulares.
3. Marca: contiene las marcas de los celulares.
4. Celulares: datos de los celulares.
5. Ventas: las ventas de los celulares.

Para cada tabla se creo tres trigger's para los tres eventos principales:
 
1. Insertar.
2. Actualizar.
3. Eliminar.

Para la tabla ventas se creo un trigger que al insertar un nuevo registro actualiza en la tabla celulares el campo cantidad, en este se resta el numero de productos vendidos, actualizando asi la cantidad en la tabla celulares.
