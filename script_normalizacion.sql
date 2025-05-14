-- Proyecto Final Bases de Datos
-- Se asume que ya se ha ejecutado script_limpieza.sql
-- Script dedicado para la normalizacion

CREATE SCHEMA nm;

-- Creacion de tablas

CREATE TABLE nm.lugar (
    collision_id BIGINT PRIMARY KEY,
    crash_timestamp TIMESTAMP,
    borough VARCHAR(100),
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    zip_code VARCHAR(100),
    on_street_name VARCHAR(100),
    cross_street_name VARCHAR(100),
    end_street_name VARCHAR(100)
);

CREATE TABLE nm.afectados (
    afectados_id BIGSERIAL PRIMARY KEY,
    collision_id BIGINT,
    people_injured SMALLINT,
    people_killed SMALLINT,
    pedestrians_injured SMALLINT,
    pedestrians_killed SMALLINT,
    cyclists_injured SMALLINT,
    cyclists_killed SMALLINT,
    motorcyclists_injured SMALLINT,
    motorcyclists_killed SMALLINT,
    CONSTRAINT fk_collision_id FOREIGN KEY (collision_id) REFERENCES nm.lugar(collision_id)
);

CREATE TABLE nm.tipo_de_factor (
    tipo_de_factor_id BIGSERIAL PRIMARY KEY,
    tipo_de_factor VARCHAR(100)
);

CREATE TABLE nm.factores (
    factor_id BIGSERIAL PRIMARY KEY,
    tipo_de_factor_id SMALLINT,
    num_factor SMALLINT,
    collision_id BIGINT,
    CONSTRAINT fk_tipo_de_factor_id FOREIGN KEY (tipo_de_factor_id) REFERENCES nm.tipo_de_factor(tipo_de_factor_id),
    CONSTRAINT fk_collision_id FOREIGN KEY (collision_id) REFERENCES nm.lugar(collision_id)
);

CREATE TABLE nm.tipo_de_vehiculo (
    tipo_de_vehiculo_id SMALLSERIAL PRIMARY KEY,
    tipo_de_vehiculo VARCHAR(100)
);

CREATE TABLE nm.vehiculos (
    vehiculo_id BIGSERIAL PRIMARY KEY,
    tipo_de_vehiculo_id SMALLINT,
    num_vehiculo SMALLINT,
    collision_id BIGINT,
    CONSTRAINT fk_tipo_de_vehículo_id FOREIGN KEY (tipo_de_vehiculo_id) REFERENCES nm.tipo_de_vehiculo(tipo_de_vehiculo_id),
    CONSTRAINT fk_collision_id FOREIGN KEY (collision_id) REFERENCES nm.lugar(collision_id)
);

-- Poblacion de tablas
	
	--lugar
	INSERT INTO nm.lugar (collision_id, crash_timestamp, borough, latitude, longitude, zip_code, on_street_name, cross_street_name, end_street_name)
	SELECT collision_id, crash_timestamp, borough, latitude, longitude, zip_code, on_street_name, cross_street_name, off_street_name
	FROM limpieza;
	
	--afectados
	INSERT INTO nm.afectados (collision_id, people_injured, people_killed, pedestrians_injured, pedestrians_killed, cyclists_injured, cyclists_killed, motorcyclists_injured, motorcyclists_killed)
	SELECT collision_id, persons_injured, persons_killed, pedestrians_injured, pedestrians_killed, cyclists_injured, cyclists_killed, motorists_injured, motorists_killed
	FROM limpieza;
	
	--tipo_de_factor
	INSERT INTO nm.tipo_de_factor (tipo_de_factor)
	SELECT DISTINCT contributing_factor_1
	FROM limpieza
		WHERE contributing_factor_1 IS NOT NULL
	UNION
	SELECT DISTINCT contributing_factor_2
	FROM limpieza
		WHERE contributing_factor_2 IS NOT NULL
	UNION 
	SELECT DISTINCT contributing_factor_3
	FROM limpieza
		WHERE contributing_factor_3 IS NOT NULL
	UNION
	SELECT DISTINCT contributing_factor_4
	FROM limpieza
		WHERE contributing_factor_4 IS NOT NULL
	UNION
	SELECT DISTINCT contributing_factor_5
	FROM limpieza
		WHERE contributing_factor_5 IS NOT NULL;
		
	--tipo_de_vehiculo
	INSERT INTO nm.tipo_de_vehiculo (tipo_de_vehiculo)
	SELECT DISTINCT vehicle_code_1
	FROM limpieza
	  WHERE vehicle_code_1 IS NOT NULL
	UNION
	SELECT DISTINCT vehicle_code_2
	FROM limpieza
	  WHERE vehicle_code_2 IS NOT NULL
	UNION 
	SELECT DISTINCT vehicle_code_3
	FROM limpieza
	  WHERE vehicle_code_3 IS NOT NULL
	UNION
	SELECT DISTINCT vehicle_code_4
	FROM limpieza
	  WHERE vehicle_code_4 IS NOT NULL
	UNION
	SELECT DISTINCT vehicle_code_5
	FROM limpieza
	  WHERE vehicle_code_5 IS NOT NULL;
	  
	  --factores
  	INSERT INTO nm.factores (num_factor, collision_id, tipo_de_factor_id)
	SELECT
	  1 AS num_factor,
	  l.collision_id,
	  t.tipo_de_factor_id
	FROM limpieza l
	JOIN nm.tipo_de_factor t ON l.contributing_factor_1 = t.tipo_de_factor
	WHERE l.contributing_factor_1 IS NOT NULL;
	
	INSERT INTO nm.factores (num_factor, collision_id, tipo_de_factor_id)
	SELECT
	  2 AS num_factor,
	  l.collision_id,
	  t.tipo_de_factor_id
	FROM limpieza l
	JOIN nm.tipo_de_factor t ON l.contributing_factor_2 = t.tipo_de_factor
	WHERE l.contributing_factor_2 IS NOT NULL;
	
	INSERT INTO nm.factores (num_factor, collision_id, tipo_de_factor_id)
	SELECT
	  3 AS num_factor,
	  l.collision_id,
	  t.tipo_de_factor_id
	FROM limpieza l
	JOIN nm.tipo_de_factor t ON l.contributing_factor_3 = t.tipo_de_factor
	WHERE l.contributing_factor_3 IS NOT NULL;
	
	INSERT INTO nm.factores (num_factor, collision_id, tipo_de_factor_id)
	SELECT
	  4 AS num_factor,
	  l.collision_id,
	  t.tipo_de_factor_id
	FROM limpieza l
	JOIN nm.tipo_de_factor t ON l.contributing_factor_4 = t.tipo_de_factor
	WHERE l.contributing_factor_4 IS NOT NULL;
	
	INSERT INTO nm.factores (num_factor, collision_id, tipo_de_factor_id)
	SELECT
	  5 AS num_factor,
	  l.collision_id,
	  t.tipo_de_factor_id
	FROM limpieza l
	JOIN nm.tipo_de_factor t ON l.contributing_factor_5 = t.tipo_de_factor
	WHERE l.contributing_factor_5 IS NOT NULL;
	
	--vehiculo
	INSERT INTO nm.vehiculos (num_vehiculo, collision_id, tipo_de_vehiculo_id)
	SELECT
	  1 AS num_vehiculo,
	  l.collision_id,
	  t.tipo_de_vehiculo_id
	FROM limpieza l
	JOIN nm.tipo_de_vehiculo t ON l.vehicle_code_1 = t.tipo_de_vehiculo
	WHERE l.vehicle_code_1 IS NOT NULL;
	
	INSERT INTO nm.vehiculos (num_vehiculo, collision_id, tipo_de_vehiculo_id)
	SELECT
	  2 AS num_vehiculo,
	  l.collision_id,
	  t.tipo_de_vehiculo_id
	FROM limpieza l
	JOIN nm.tipo_de_vehiculo t ON l.vehicle_code_2 = t.tipo_de_vehiculo
	WHERE l.vehicle_code_2 IS NOT NULL;
	
	INSERT INTO nm.vehiculos (num_vehiculo, collision_id, tipo_de_vehiculo_id)
	SELECT
	  3 AS num_vehiculo,
	  l.collision_id,
	  t.tipo_de_vehiculo_id
	FROM limpieza l
	JOIN nm.tipo_de_vehiculo t ON l.vehicle_code_3 = t.tipo_de_vehiculo
	WHERE l.vehicle_code_3 IS NOT NULL;
	
	INSERT INTO nm.vehiculos (num_vehiculo, collision_id, tipo_de_vehiculo_id)
	SELECT
	  4 AS num_vehiculo,
	  l.collision_id,
	  t.tipo_de_vehiculo_id
	FROM limpieza l
	JOIN nm.tipo_de_vehiculo t ON l.vehicle_code_4 = t.tipo_de_vehiculo
	WHERE l.vehicle_code_4 IS NOT NULL;
	
	INSERT INTO nm.vehiculos (num_vehiculo, collision_id, tipo_de_vehiculo_id)
	SELECT
	  5 AS num_vehiculo,
	  l.collision_id,
	  t.tipo_de_vehiculo_id
	FROM limpieza l
	JOIN nm.tipo_de_vehiculo t ON l.vehicle_code_5 = t.tipo_de_vehiculo
	WHERE l.vehicle_code_5 IS NOT NULL;
