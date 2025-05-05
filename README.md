# Proyecto Final -Bases de Datos

## Análisis de accidentes automovilísticos en la ciudad de Nueva York
### Descripción General
Este conjunto de datos contiene información sobre colisiones vehiculares ocurridas en la ciudad de Nueva York. Los reportes son de aquellos choques donde una o más personas fueron lastimadas, matadas o hubo daños de al menos 1,000 dólares. Se incluyen detalles como fecha, hora, ubicación, tipo de vehículo, personas involucradas, factores contribuyentes y consecuencias del accidente.

### Sobre la Fuente de Datos
* *Recolección:* El Departamento de Policía de Nueva York (NYPD).
* *Propósito:* Registrar los reportes policiacos de accidentes automovilísticos para la mejora de la seguridad vial mediante el análisis de patrones de accidentes, identificación de áreas de riesgo y formulación de políticas públicas más efectivas.
* *Frecuencia de actualización:* Los datos son actualizados de manera semanal en la página del NYPD Motor Vehicle Collisions o mensualmente en la página de Vision Zero View.
* *Disponibles en:* [Motor Vehicle Collisions - Crashes - Catalog](https://catalog.data.gov/dataset/motor-vehicle-collisions-crashes).
   
### Sobre la Estructura de los Datos
* *Número de registros:* 2 millones de registros (tuplas) aproximadamente.
* *Número de atributos:* 29 atributos (columnas)
* ***Sobre los atributos:***
   * `collision_id`: Llave primaria de la tabla.
   * `crash_date`, `crash_time`: Fecha y hora del accidente.
   * `borough`, `zip_code`, `on_street_name`, `cross_street_name`, `off_street_name`: Ubicación urbana.
   * `latitude`, `longitude`, `location`: Coordenadas geoespaciales.
   * `number_of_persons_injured`, `number_of_persons_killed`: Personas heridas y fallecidas.
   * `number_of_pedestrians_injured`, `number_of_pedestrians_killed`: Peatones heridos y fallecidos.
   * `number_of_cyclist_injured`, `number_of_cyclist_killed`: Ciclistas heridos y fallecidos
   * `number_of_motorists_njured`, `number_of_motorists_killed`: Motociclistas heridos y fallecidos.
   * `contributing_factor`: Numeradas del 1 al 5, causa atribuida al accidente.
   * `vehicle_type_code`: Numerados del 1 al 5, tipo de vehículo involucrado.

* Atributos Numéricos:
`collision_id`, `latitude`, `longitude`, `location`, `number _of_persons_injured`, `number_of_persons_killed`, `number_of_pedestrians_injured`, `number_of_pedestrians_killed`, `number_of_cyclist_injured`, `number_of_cyclist_killed`, `number_of_motorists_njured`, `number_of_motorists_killed`

* Atributos Categóricos:
`borough`, `zip_code`, `contributing_factor`

* Atributos Textuales:
`vehicle_type_code`, `on_street_name`, `cross_street_name`, `off_street_name`

* Atributos Temporales:
`crash_date`, `crash_time`

### Sobre el Objetivo del Proyecto
El objetivo es analizar los datos recolectados para identificar patrones en la frecuencia, ubicación, gravedad de los incidentes y zonas de mayor riesgo. 

Se iniciará realizando un mapeo general de los accidentes para visualizar tendencias en distintos distritos y tipos de vialidades. Prestando atención a los principales factores contribuyentes, incluyendo errores humanos, fallas mecánicas y condiciones adversas.
Después, el estudio se centrará en un análisis comparativo entre zonas con distintos niveles socioeconómicos, explorando cómo la seguridad vial varía en función del acceso a infraestructura adecuada, regulaciones de tránsito y presencia de medidas de prevención. Se evaluará si existen diferencias significativas en la tasa de accidentes, tasa de gravedad y la percepción de riesgo entre barrios históricamente considerados seguros y aquellos con mayor incidencia de choques.

Este enfoque permitirá comprender las desigualdades en la seguridad vial y contribuir a una discusión más informada sobre movilidad, planeación urbana y acceso equitativo a condiciones seguras de tránsito en Nueva York.

### Sobre las Consideraciones Éticas 
1. *Privacidad:* Los datos no incluyen datos personales de los involucrados, pero son lo suficientemente específicos para identificaciones indirectas si se conoce del accidente en cuestión. 
2. *Imparcialidad:* El proyecto se llevará a cabo evitando generar y/o caer en estigmas hacia ciertas zonas o comunidades, asegurando que las conclusiones reflejen únicamente patrones basados en datos y no refuercen prejuicios.
3. *Transparencia:* Los resultados del estudio serán divulgados de manera clara y accesible, fundamentados en evidencia verificable y replicable.
4. *Uso responsable:* Se considerarán las limitaciones inherentes a los datos, así como su contexto, evitando interpretaciones erróneas o que no tengan en cuenta factores externos que puedan influir en la ocurrencia de los accidentes.

## Carga Inicial de Datos
### Base de Datos
Para la carga inicial de datos, primero se necesita crear la base y tabla correspondiente. Los siguientes comandos deben de ser copiados en `SQL SHELL (psql)`. 
```
DROP DATABASE IF EXISTS motor_vehicle_collisions_nyc;
CREATE DATABASE motor_vehicle_collisions_nyc;
```
Ahora deberá conectarse a la base de datos creada.
```
\c motor_vehicle_collisions_nyc
```

### Esquema Inicial
Para una carga exitosa, se debe definir la tabla de datos con los atributos y tipos respectivos. 

El siguiente código es la creación del esquema inicial. Puede ser copiado en `SQL SHELL (psql)` o cualquier DBMS compatible con PostgreSQL.
```
DROP TABLE IF EXISTS original;
CREATE TABLE original (
   crash_date TEXT,
   crash_time TIME,
   borough TEXT,
   zip_code TEXT,
   latitude DOUBLE PRECISION,
   longitude DOUBLE PRECISION,
   location TEXT,
   on_street_name TEXT,
   cross_street_name TEXT,
   off_street_name TEXT,
   persons_injured SMALLINT,
   persons_killed SMALLINT,
   pedestrians_injured SMALLINT,
   pedestrians_killed SMALLINT,
   cyclists_injured SMALLINT,
   cyclists_killed SMALLINT,
   motorists_injured SMALLINT,
   motorists_killed SMALLINT,
   contributing_factor_1 TEXT,
   contributing_factor_2 TEXT,
   contributing_factor_3 TEXT,
   contributing_factor_4 TEXT,
   contributing_factor_5 TEXT,
   collision_id BIGINT PRIMARY KEY,
   vehicle_code_1 TEXT,
   vehicle_code_2 TEXT,
   vehicle_code_3 TEXT,
   vehicle_code_4 TEXT,
   vehicle_code_5 TEXT
);
```

### Importación de Datos de un CSV
Para la carga de datos es necesario descargar la base de datos, la cual puede ser encontrada en el siguiente link. Asegúrese de descargar el archivo de tipo .CSV. La descarga de archivos se encuentra casi al final de la página. 
* [Motor Vehicle Collisions - Crashes - Catalog](https://catalog.data.gov/dataset/motor-vehicle-collisions-crashes).

También asegúrese de utilizar el siguiente comando para evitar errores en la importación.
```
SET CLIENT_ENCODING TO 'UTF8';
```
Ahora utilice el siguiente comando para importar la base de datos descargada a la tabla creada anteriormente.
> ***NOTA:*** path corresponde a la ruta del archivo en su dispositivo, por ejemplo C:/Users/usuario/Downloads/Motor_Vehicle_Collisions_-_Crashes.csv . Tambien asegurese de que los slash sean a la derecha ( / ) en lugar de a la izquierda ( \ ).
```
\copy original (crash_date, crash_time, borough, zip_code, latitude, longitude, location, on_street_name, cross_street_name, off_street_name, persons_injured, persons_killed, pedestrians_injured, pedestrians_killed, cyclists_injured, cyclists_killed, motorists_injured, motorists_killed, contributing_factor_1, contributing_factor_2, contributing_factor_3, contributing_factor_4, contributing_factor_5, collision_id, vehicle_code_1, vehicle_code_2, vehicle_code_3, vehicle_code_4, vehicle_code_5)
FROM 'path' WITH (FORMAT CSV, HEADER true, DELIMITER ',');
```

### Análisis Preliminar
Durante un análisis inicial de la base de datos, pudimos observar que existen algunas columnas redundantes o que podrían juntarse para tener una menor cantidad de atributos. Por ejemplo, latitude y longitude son la separación de location, por lo que lo ideal sería quedarse con solo location. A su vez, crash_date y crash_time pueden juntarse en un atributo de tipo timestamp. 
A través del siguiente query podemos observar la fecha más antigua y más reciente de las que se tienen registros en la base de datos. Esto es importante ya que podemos observar el tiempo que abarca nuestro análisis y los cambios en tecnología y contexto a través de esos años.
```
SELECT
    MIN(crash_date) AS fecha_minima,
    MAX(crash_date) AS fecha_maxima
FROM original;
```
Algunos de los análisis iniciales se han centrado en máximos, mínimos y promedios. Esto debido a que es importante considerar los casos más extremos, así como cuál es el promedio. Los querys son lo siguientes:
```
SELECT 'persons_injured' as dato,
	   MAX(persons_injured) as maximo,
	   MIN(persons_injured) as minimo,
	   AVG(persons_injured) as promedio	   
FROM original;
```
> Este query puede ser replicado con los atributos `persons_killed`, `pedestrians_injured`, `pedestrians_killed`, `cyclists_injured`, `cyclists_killed`, `motorists_injured` y `motorists_killed`, para valores especificos de cada categoria. 

Los siguientes query nos muestran las categorías que toma la policía de Nueva York como válidas, de esta forma podemos observar que existen 62, 61 ignorando los valores nulos, factores contribuyentes diferentes.
```
SELECT borough,
COUNT(*) as total_duplicados
FROM original
GROUP BY borough;
```
> Este query puede ser replicado con los atributos `zip_code` y todos los `contributing_factor`.

En general podemos observar inconsistencias en ciertos atributos, en su mayoría debido a errores humanos. Ya que estos reportes son escritos con la presión de todos los afectados sobre los policías, hay problemas en redacción, atributos incompletos o dejados en blanco. A través del siguiente query podemos encontrar la cantidad de tuplas con algún valor NULL.
```
SELECT COUNT(*) as cant
FROM original
WHERE crash_date is NULL or crash_time is NULL or borough is NULL or zip_code is NULL or latitude is NULL or longitude is NULL or location is NULL or (on_street_name is NULL and off_street_name is NULL and cross_street_name is NULL ) or (contributing_factor_1 is NULL  and contributing_factor_2 is NULL and contributing_factor_3 is NULL and contributing_factor_4 is NULL and contributing_factor_5 is NULL) or collision_id is NULL or (vehicle_code_1 is NULL and vehicle_code_2 is NULL and vehicle_code_3 is NULL and vehicle_code_4 is NULL and vehicle_code_5 is NULL);
```
> Tomando en cuenta que puede haber valores NULL en 4 de 5 de los atributos repetidos ya que puede haber hasta 5 vehículos involucrados. 

## Limpieza de Datos
Antes de empezar la limpieza de datos, si se quiere preservar la tabla original, se puede copiar el siguiente comando. Este hará una copia de la tabla original y entonces se podrá trabajar con la nueva tabla sin perder ningún dato.
```
CREATE TABLE limpieza AS 
SELECT * FROM original;
```
Para optimizar el proyecto, hemos decidido eliminar la columna de location, ya que ésta contiene la información de latitude y longitud, para lo cuál es más eficiente tenerlas por separado. También hemos decidido combinar crash_date y crash_time a un solo atributo crash_timestamp, ya que consideramos redundante tener dos atributos que pueden ser solo uno. 

Los siguientes comandos deben ser copiados en alguna DBMS, por ejemplo TablePlus.
```
ALTER TABLE limpieza
	ADD COLUMN crash_timestamp TIMESTAMP;

UPDATE limpieza
SET crash_timestamp = to_date(crash_date, 'mm-dd-yyyy') + crash_time;

ALTER TABLE limpieza
	DROP COLUMN location,
	DROP COLUMN crash_date,
	DROP COLUMN crash_time;
UPDATE limpieza
SET zip_code = NULL
	WHERE zip_code LIKE ' ';
```
De la misma forma, utilizando el codigo a continuacion, cambiamos todas las latitudes y longitudes iguales a cero, a nulos. A la vez, eliminaremos aquellas coliciones que hayan ocurrido fuera de la ciudad de Nueva York, las delimitaciones geograficas utilizadas son:
> Latitud mínima: 40.4774
> Latitud máxima: 40.9176
> Longitud mínima: -74.2591
> Longitud máxima: -73.7004
```
UPDATE limpieza
SET latitude = NULL
	WHERE latitude = 0;

UPDATE limpieza
SET longitude = NULL
	WHERE longitude = 0;

DELETE
FROM limpieza 
  WHERE NOT (latitude BETWEEN 40.4774 AND 40.9176) 
  AND NOT (longitude BETWEEN -74.2591 AND -73.7004);
```
Despues, para la limpieza de las columnas relacionadas al nombre de las calles (`on_street_name`, `off_street_name` y `cross_street_name`), se ***sobbaron???*** los prompts llenos de espacios (remplazados por NULL) y finalmente, se arreglaron discrepancias relacionadas a la palabra AVENUE dentro de la base de datos (donde la palabra estaba escrita de diferentes formas en las tuplas).

Para ello, es necesario llevar a cabo el siguiente codigo, en el orden correspondiente.
```
UPDATE limpieza
SET on_street_name = NULL
	WHERE on_street_name LIKE '                                ';
	
UPDATE limpieza
SET on_street_name = TRIM(on_street_name);

UPDATE limpieza
SET on_street_name = REPLACE(on_street_name, 'AVENUENUE', 'AVENUE')
	WHERE on_street_name ILIKE '%AVE%' AND on_street_name NOT LIKE '% AVENUE %';
	
UPDATE limpieza
SET on_street_name = REPLACE(on_street_name, 'ave', 'AVENUE')
	WHERE on_street_name ILIKE '%AVE%' AND on_street_name NOT LIKE '% AVENUE %';

UPDATE limpieza
SET on_street_name = REPLACE(on_street_name, 'avenue', 'AVENUE')
	WHERE on_street_name ILIKE '%AVE%' AND on_street_name NOT LIKE '% AVENUE %';

UPDATE limpieza
SET on_street_name = REPLACE(on_street_name, 'Avenue', 'AVENUE')
	WHERE on_street_name ILIKE '%AVE%' AND on_street_name NOT LIKE '% AVENUE %';

UPDATE limpieza
SET on_street_name = REPLACE(on_street_name, 'AVENUEnue', 'AVENUE')
	WHERE on_street_name ILIKE '%AVE%' AND on_street_name NOT LIKE '% AVENUE %';

UPDATE limpieza
SET on_street_name = REPLACE(on_street_name, 'vAVENUE', 'AVENUE')
	WHERE on_street_name ILIKE '%vAVENUE%' AND on_street_name NOT LIKE '% AVENUE %';
```



La siguiente parte de la limpieza es el cambio de los valores `TEXT` a su version en mayusculas (para facilitar el manejo y analisis de datos) 
```
-- borough
UPDATE limpieza
SET borough = UPPER(borough)
  WHERE borough NOT LIKE UPPER(borough);

-- calles
UPDATE limpieza
SET on_street_name = UPPER(on_street_name)
	WHERE on_street_name NOT LIKE UPPER(on_street_name);
UPDATE limpieza
SET cross_street_name = UPPER(cross_street_name)
	WHERE cross_street_name NOT LIKE UPPER(cross_street_name);
UPDATE limpieza
SET off_street_name = UPPER(off_street_name)
	WHERE off_street_name NOT LIKE UPPER(off_street_name);

-- factores
UPDATE limpieza
SET contributing_factor_1 = UPPER(contributing_factor_1)
  WHERE contributing_factor_1 NOT LIKE UPPER(contributing_factor_1);
  
UPDATE limpieza
SET contributing_factor_2 = UPPER(contributing_factor_2)
  WHERE contributing_factor_2 NOT LIKE UPPER(contributing_factor_2);

UPDATE limpieza
SET contributing_factor_3 = UPPER(contributing_factor_3)
  WHERE contributing_factor_3 NOT LIKE UPPER(contributing_factor_3);

UPDATE limpieza
SET contributing_factor_4 = UPPER(contributing_factor_4)
  WHERE contributing_factor_4 NOT LIKE UPPER(contributing_factor_4);

UPDATE limpieza
SET contributing_factor_5 = UPPER(contributing_factor_5)
  WHERE contributing_factor_5 NOT LIKE UPPER(contributing_factor_5);

-- vehiculos
UPDATE limpieza
SET vehicle_code_1 = UPPER(vehicle_code_1)
  WHERE vehicle_code_1 NOT LIKE UPPER(vehicle_code_1);
  
UPDATE limpieza
SET vehicle_code_2 = UPPER(vehicle_code_2)
  WHERE vehicle_code_2 NOT LIKE UPPER(vehicle_code_2);

UPDATE limpieza
SET vehicle_code_3 = UPPER(vehicle_code_3)
  WHERE vehicle_code_3 NOT LIKE UPPER(vehicle_code_3);

UPDATE limpieza
SET vehicle_code_4 = UPPER(vehicle_code_4)
  WHERE vehicle_code_4 NOT LIKE UPPER(vehicle_code_4);

UPDATE limpieza
SET vehicle_code_5 = UPPER(vehicle_code_5)
  WHERE vehicle_code_5 NOT LIKE UPPER(vehicle_code_5);
```
## Normalización de datos hasta cuarta forma normal 

### Diagrama de entidad-relación intuitivo

Antes de ofrecer el diagrama de entidad-relación final en cuarta forma normal, primero ofrecemos el modelo relacional intuitivo sin tomar en cuenta la teoría de normalización. El diagrama de entidad-relación intuitivo es el siguiente:

![image](https://github.com/user-attachments/assets/7d429df8-e69c-4b03-b189-df960037fa4a)




 - **lugar**: Contiene información principal del evento de colisión, incluyendo la fecha y hora (`crash_timestamp`), la ubicación geográfica (`borough`, `zip_code`, `latitude`, `longitude`) y las calles involucradas (`on_street_name`, `off_street_name` y `cross_street_name`).
	- Clave primaria: `collision_id`
 	- Relaciones: Se conecta con **afectados**, **factores** y **vehiculos** mediante `collision_id`.

 - **afectados**: Almacena el número de personas heridas o fallecidas en la colisión, desglosado por tipo de usuario: peatones, ciclistas, motociclistas y personas en general.
	- Clave primaria: `collision_id`
 	- Relaciones: relación 1 a 1 con Lugar
    
 - **factores**: Registra los factores que contribuyeron al accidente, como distracción del conductor o condiciones del camino.
	- Clave primaria: `factor_id`
 	- Claves foráneas: `collision_id` → referencia a **lugar**, `tipo_de_factor_id` → referencia a **tipo_de_factor**
    
 - **tipo_de_factor**: Catálogo de posibles factores contribuyentes a una colisión. Permite estandarizar y evitar duplicidad en la descripción de factores (también evita anomalías de inserción, borrado y modificación).
	- Clave primaria: `tipo_de_factor_id`
 	- Relaciones: se relaciona con **factores** a través de `tipo_de_factor_id` (relación muchos a uno)

 - **vehiculos**: Almacena los vehículos involucrados en una colisión, indicando el tipo y su orden (`num_vehiculo`).
	- Clave primaria: `vehiculo_id`
 	- Claves foráneas: `collision_id` → referencia a Lugar, `tipo_de_vehiculo_id` → referencia a **tipo_de_vehiculo**
    
 - **tipo_de_vehiculo**: Catálogo con los distintos tipos de vehículos registrados en colisiones (por ejemplo, automóvil, camión, bicicleta).
	- Clave primaria: `tipo_de_vehículo_id`
 	- Relaciones: Se relaciona con **vehiculos** mediante `tipo_de_vehiculo_id` (relación muchos a uno)

### Diagrama de entidad-relación en 4FN
Ahora enunciaremos todas las DF y las DMV de cada tabla, para después verficar que el diagrama este en cuarta formal y en caso de no estarlo ajustar el diagrama.

Depndencias funcionales:
- `collision_id` → `crash_timestamp`, `borough`, `zip_code`, `latitude`, `longitude`, `on_street_name`, `cross_street_name`, `end_street_name`
- `collision_id` → `people_injured`, `people_killed`, `pedestrians_injured`, `pedestrians_killed`, `cyclists_injured`, `cyclists_killed`, `motorcyclists_injured`, `motorcyclists_killed`
- `factor_id` → `collision_id`, `tipo_de_factor_id`, `num_factor`
- `tipo_de_factor_id` → `tipo_de_factor`
- `vehiculo_id` → `collision_id`, `tipo_de_vehiculo_id`, `num_vehiculo`
- `tipo_de_vehiculo_id` → `tipo_de_vehiculo`

Dependencias multivaluadas:
- `collision_id` ↠ `tipo_de_factor_id`   (puede tener hasta 5 factores)
- `collision_id` ↠ `tipo_de_vehiculo_id`  (puede tener hasta 5 tipos de vehículos)

Como podemos notar, el diagrama de entidad-relación está en *FNBC* porque cada relación tiene una clave primaria que determina el resto de sus atributos. Más aún, también se encuentra en *4FN* porque las dos DMV han sido aisladas en relaciones independientes (**factores**, **vehiculos**), evitando combinaciones cruzadas de valores. En esas relaciones (**factores**, **vehiculos**), `collision_id` es una superclave, cumpliendo la condición que exige *4FN*. Por lo tanto, el digrama de entidad-relación final de la base de datos ya en *4FN* será el mostrado al inicio del apartado.

![image](https://github.com/user-attachments/assets/3ed86ae6-74b0-432f-ae5d-b3a24468b778)


### Código para hacer la descomposición de la tabla original
Antes de empezar con la creación de tablas, se creara un *SCHEMA* donde se almacenaran las nuevas tablas. Esto con el proposito de mantenerlas separadas de las tablas originales.
```
CREATE SCHEMA nm;
```
#### Creacion de tablas
```
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

```

#### Poblar las tablas con los datos
Tabla **lugar**
```
INSERT INTO nm.lugar (collision_id, crash_timestamp, borough, latitude, longitude, zip_code, on_street_name, cross_street_name, end_street_name)
SELECT collision_id, crash_timestamp, borough, latitude, longitude, zip_code, on_street_name, cross_street_name, off_street_name
FROM limpieza;

```
Tabla **afectados**
```
INSERT INTO nm.afectados (collision_id, people_injured, people_killed, pedestrians_injured, pedestrians_killed, cyclists_injured, cyclists_killed, motorcyclists_injured, motorcyclists_killed)
SELECT collision_id, persons_injured, persons_killed, pedestrians_injured, pedestrians_killed, cyclists_injured, cyclists_killed, motorists_injured, motorists_killed
FROM limpieza;
```
Tabla **tipo_de_factor**
```
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
```
Tabla **tipo_de_vehiculo**
```
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

```
Tabla **factores**
```
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

```
Tabla **vehiculo**
```
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
```
Ya que quedaron las tablas, de manera opcional, se puede borrar la tabla original asi como la de limpieza
```
DROP TABLE original;
DROP TABLE limpieza;
```
## Análisis de Datos y Atributos Analíticos
Recordando nuestro objetivo original, hemos encontrado los siguientes datos. Las consultas utlizadas pueden ser encontradas en el archivo `queries.sql` dentro del repositorio.

### Estadísticas Básicas
#### Calles con más accidentes
![Top_calle](https://github.com/user-attachments/assets/8212747e-9722-4638-9de9-584792d4cc39)


#### Principales tipos de carros involucrados
![Top_vehiculo](https://github.com/user-attachments/assets/5fcaa3db-f10f-4c14-9ba3-b358b8b83089)


#### Principales factores contribuyentes
![Top_factor](https://github.com/user-attachments/assets/723cf719-4a31-46c4-a299-9ae3def26766)


#### Tasa de gravedad de los accidentes
| Acc. con Lesiones | Total Accidentes |  Promedio  |
| -------------     | :-------------:  |:----------:|
|     513848	      |     2166077	     |    23.72   |

>AH

| Acc. con Muertes  | Total Accidentes |  Promedio  |
| -------------     | :-------------:  |:----------:|
|       3226	      |     2166077	     |   0.1489   |
>AH
### Análisis 
#### Análisis frecuencia-nivel socioeconómico
![ME VOY A MATAR](https://github.com/user-attachments/assets/863fc9ac-36ae-45c9-aebf-e6d266608390)

#### Análisis gravedad-nivel socioeconómico
|Distrito      | Acc. con Lesiones | Acc. en Distrito  | Promedio  |
| -------------|:------------:|:---------------:|:--------: |
|BRONX	       |55051	        |221614	          |24.84      |
|BROOKLYN	     |122734	      |478105	          |25.67      |
|MANHATTAN	   |61341	        |332624	          |18.44      |
|QUEENS	       |93826	        |401324	          |23.38      |
|STATEN ISLAND |13512	        |62750	          |21.53      |
|NULL 	       |167384        |669660           |24.99      |


muertes
|Distrito      | Acc. con Muertes | Acc. en Distrito  | Promedio  |
| -------------|:------------:|:---------------:|:--------:  |
|BRONX	       |296	          |221614	          |0.1335      |
|BROOKLYN	     |659	          |478105	          |0.1378      |
|MANHATTAN	   |351	          |332624	          |0.1055      |
|QUEENS	       |533	          |401324	          |0.1328      |
|STATEN ISLAND |100	          |62750	          |0.1593      |
|NULL 	       |1287          |669660           |0.1921      |
