-- Proyecto Final Bases de Datos
-- Consultas utilizadas para el analisis final


--Calles mas peligrosas 
WITH accidentes_per_calle AS (
SELECT on_street_name, 
       count (*) as tot_acc_calle, 
       (select count (*) from nm.lugar) as tot_acc
FROM nm.lugar
GROUP BY on_street_name
)

SELECT *, 
	   (tot_acc_calle/tot_acc :: NUMERIC)*100 as promedio
FROM accidentes_per_calle
ORDER BY promedio DESC
LIMIT 10;


--analisis de tipos de carros con más accidentes 
WITH accidentes_per_coche AS (
SELECT tipo_de_vehiculo, 
       count (*) as tot_acc_auto, 
       (select count (*) from nm.vehiculos) as tot_acc
FROM nm.vehiculos
JOIN nm.tipo_de_vehiculo ON vehiculos.tipo_de_vehiculo_id = tipo_de_vehiculo.tipo_de_vehiculo_id
GROUP BY tipo_de_vehiculo
)

SELECT *, 
	   (tot_acc_auto/tot_acc :: NUMERIC)*100 as promedio
FROM accidentes_per_coche
ORDER BY promedio DESC
LIMIT 10;

--analisis de factores con más accidentes 
WITH accidentes_per_factor AS (
SELECT tipo_de_factor, 
       count (*) as tot_acc_factor, 
       (select count (*) from nm.factores) as tot_acc
FROM nm.factores
JOIN nm.tipo_de_factor ON factores.tipo_de_factor_id = tipo_de_factor.tipo_de_factor_id
GROUP BY tipo_de_factor
)

SELECT *, 
	   (tot_acc_factor/tot_acc :: NUMERIC)*100 as promedio
FROM accidentes_per_factor
ORDER BY promedio DESC
LIMIT 10;

--gravedad
WITH afectados_per_accidente AS (
SELECT count(*) as tot_afectados,
	   (select count (*) from nm.lugar) as tot_acc
FROM nm.afectados
WHERE people_injured > 0
)
SELECT *, 
	   (tot_afectados/tot_acc :: NUMERIC)*100 as promedio
FROM afectados_per_accidente;

WITH muertes_per_accidente AS (
SELECT count(*) as tot_muertes,
	   (select count (*) from nm.lugar) as tot_acc
FROM nm.afectados
WHERE people_killed > 0
)
SELECT *, 
	   (tot_muertes/tot_acc :: NUMERIC)*100 as promedio
FROM muertes_per_accidente;

-- gravedad por distrito 
WITH afectados_por_distrito AS (
	SELECT borough,
			COUNT(*) as tot_afectados
	FROM nm.afectados
	JOIN nm.lugar ON afectados.collision_id = lugar.collision_id
	WHERE people_injured > 0
	GROUP BY borough
),
accidentes_por_distrito AS (
	SELECT borough,
		   COUNT(*) as tot_accidentes
	FROM nm.afectados
	JOIN nm.lugar ON afectados.collision_id = lugar.collision_id
	GROUP BY borough
)
SELECT afectados_por_distrito.borough,
		tot_afectados,
		tot_accidentes,
		(tot_afectados/tot_accidentes :: NUMERIC)*100 as promedio
FROM afectados_por_distrito
JOIN accidentes_por_distrito ON afectados_por_distrito.borough = accidentes_por_distrito.borough
;

WITH muertes_por_distrito AS (
	SELECT borough,
			COUNT(*) as tot_muertes
	FROM nm.afectados
	JOIN nm.lugar ON afectados.collision_id = lugar.collision_id
	WHERE people_killed > 0
	GROUP BY borough
),
accidentes_por_distrito AS (
	SELECT borough,
		   COUNT(*) as tot_accidentes
	FROM nm.afectados
	JOIN nm.lugar ON afectados.collision_id = lugar.collision_id
	GROUP BY borough
)
SELECT muertes_por_distrito.borough,
		tot_muertes,
		tot_accidentes,
		(tot_muertes/tot_accidentes :: NUMERIC)*100 as promedio
FROM muertes_por_distrito
JOIN accidentes_por_distrito ON muertes_por_distrito.borough = accidentes_por_distrito.borough
;