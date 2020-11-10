USE tienda;

# Reto 1
#¿Cuál es el nombre de los empleados cuyo sueldo es menor a $10,000?
SELECT nombre,apellido_paterno,apellido_materno FROM empleado WHERE id_puesto IN (SELECT id_puesto FROM puesto WHERE salario<10000);
#¿Cuál es la cantidad mínima y máxima de ventas de cada empleado?
SELECT id_empleado,max(total) AS ventas_max,min(total) AS ventas_min FROM (SELECT clave, id_empleado, count(*) AS total FROM venta GROUP BY clave, id_empleado) AS maxmin GROUP BY id_empleado;
#¿Cuáles claves de venta incluyen artículos cuyos precios son mayores a $5,000?
SELECT id_venta,id_articulo,clave FROM venta WHERE id_articulo IN (SELECT id_articulo FROM articulo WHERE precio>5000);

# Reto 2
#¿Cuál es el nombre de los empleados que realizaron cada venta?
SELECT clave,nombre,apellido_paterno,apellido_materno FROM venta JOIN empleado ON venta.id_empleado=empleado.id_empleado;
#¿Cuál es el nombre de los artículos que se han vendido?
SELECT clave,nombre FROM articulo JOIN venta ON articulo.id_articulo=venta.id_articulo;
#¿Cuál es el total de cada venta?
SELECT clave,sum(precio) AS total FROM venta JOIN articulo ON articulo.id_articulo=venta.id_articulo GROUP BY clave;

# Reto 3
#Obtener el puesto de un empleado.
CREATE VIEW puesto_empleado_012 AS SELECT empleado.nombre,apellido_paterno,apellido_materno,puesto.nombre AS puesto FROM empleado JOIN puesto ON empleado.id_puesto=puesto.id_puesto;
SELECT * FROM puesto_empleado_012;
#Saber qué artículos ha vendido cada empleado.
CREATE VIEW venta_articulo_empleado_012 AS SELECT clave,empleado.nombre,apellido_paterno,apellido_materno,articulo.nombre AS articulo FROM venta JOIN articulo ON venta.id_articulo=articulo.id_articulo JOIN empleado ON empleado.id_empleado=venta.id_empleado;
SELECT * FROM venta_articulo_empleado_012;
#Saber qué puesto ha tenido más ventas.
CREATE VIEW puesto_venta_012 AS SELECT puesto.nombre,count(clave) AS ventas FROM venta JOIN empleado ON venta.id_empleado=empleado.id_empleado JOIN puesto ON puesto.id_puesto=empleado.id_puesto GROUP BY puesto.nombre;
SELECT * FROM puesto_venta_012 WHERE ventas=(SELECT max(ventas) FROM puesto_venta_012);