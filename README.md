# Proyecto Final -Bases de Datos
##### Mariana Aguayo, Aylin Ocampo, Mario Guillen, Santiago Gatica y Marcio Tellez

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

| Atributo     | Explicacion del atributo |
| -------------| ------------- |
`collision_id` | Llave primaria de la tabla. |
| `crash_date`, `crash_time`      | Fecha y hora del accidente.   |
| `borough`, `zip_code`, `on_street_name`, `cross_street_name`, `off_street_name`      | Ubicación urbana.     |
| `latitude`, `longitude`, `location`      | Coordenadas geoespaciales.     |
| `number_of_persons_injured`, `number_of_persons_killed`| Personas heridas y fallecidas.|
| `number_of_pedestrians_injured`, `number_of_pedestrians_killed`| Peatones heridos y fallecidos.|
| `number_of_cyclist_injured`, `number_of_cyclist_killed`|Ciclistas heridos y fallecidos|
| `number_of_motorists_njured`, `number_of_motorists_killed`| Motociclistas heridos y fallecidos.|
| `contributing_factor`| Numeradas del 1 al 5, causa atribuida al accidente.|
| `vehicle_type_code`| Numerados del 1 al 5, tipo de vehículo involucrado.|


| Atributos Numéricos |
|---------------------|
`collision_id`, `latitude`, `longitude`, `location`, `number _of_persons_injured`, `number_of_persons_killed`, `number_of_pedestrians_injured`, `number_of_pedestrians_killed`, `number_of_cyclist_injured`, `number_of_cyclist_killed`, `number_of_motorists_njured`, `number_of_motorists_killed`

| Atributos Categóricos|
|---------------------|
|`borough`, `zip_code`, `contributing_factor`|

| Atributos Textuales|
|---------------------|
|`vehicle_type_code`, `on_street_name`, `cross_street_name`, `off_street_name`|

| Atributos Temporales|
|---------------------|
|`crash_date`, `crash_time`|

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
## Clonación del repositorio
Para la correcta utilziación de los scripts incluidos en el repositorio y que estos puedan ser ejecutados de forma automática, se requiere de la clonación del repositorio, por favor utilice el siguiente código:
```
git clone https://github.com/Mario200-crypto/Bases-de-Datos.git
cd Bases-de-Datos
```
## Limpieza de Datos
Antes de empezar la limpieza de datos, si se quiere preservar la tabla original, se puede copiar el siguiente comando. Este hará una copia de la tabla original y entonces se podrá trabajar con la nueva tabla sin perder ningún dato.
```
CREATE TABLE IF NOT EXISTS limpieza AS
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
UPDATE limpieza
SET zip_code = NULL
	WHERE zip_code LIKE '     ';
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
Despues, para la limpieza de las columnas relacionadas al nombre de las calles (`on_street_name`, `off_street_name` y `cross_street_name`), se reemplazaron los valores llenos de espacios por NULL y finalmente, se arreglaron discrepancias relacionadas a la palabra AVENUE dentro de la base de datos (donde la palabra estaba escrita de diferentes formas en las tuplas).

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

Encontramos en los reportes varias incidencias de `contributing_factor` siendo igual a 80 o a 1. Investigando un poco hemos encontrado que significan `UNSPECIFIED` y `DRIVER INATTENTION` respectivamente. Usando el siguiente codigo los cambiaremos para una lectura mas sencilla. (El codigo puede utilizarse para todos los `contributing_factor`)
```
UPDATE limpieza
SET contributing_factor_1 = 'DRIVER INATTENTION/DISTRACTION'
WHERE contributing_factor_1 = '1';
UPDATE limpieza
SET contributing_factor_1 = 'UNSPECIFIED'
WHERE contributing_factor_1 = '80';
```


La siguiente parte de la limpieza es el cambio de los valores `TEXT` a su version en mayusculas (para facilitar el manejo y analisis de datos). Para los atributos con numero, es decir `vehicle_code_#` y `contributing_factor_#` el codigo puede y debe utilizarse para todos los numeros disponibles.  
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

-- vehiculos
UPDATE limpieza
SET vehicle_code_1 = UPPER(vehicle_code_1)
  WHERE vehicle_code_1 NOT LIKE UPPER(vehicle_code_1);

```
Para la limpieza de los tipos de vehicle_codes, es decir tratar de unificar la mayor cantidad posible se utilizara el siguiente codigo, este puede y debe ser utilizado para todos los vehicle_code:
```
UPDATE limpieza
SET vehicle_code_1 = CASE
    WHEN vehicle_code_1 IS NULL OR TRIM(vehicle_code_1) = '' THEN NULL
    WHEN UPPER(TRIM(vehicle_code_1)) IN ('SUV', 'SPORT UTILITY VEHICLE', 'STATION WAGON/SPORT UTILITY VEHICLE', 'SPORT UTILITY', 'SPORT UTILITY / STATION WAGON') THEN 'SUV'
    WHEN UPPER(TRIM(vehicle_code_1)) IN ('PICK-UP TRUCK', 'PICKUP', 'PICK UP', 'PICK-') THEN 'PICKUP TRUCK'
    WHEN UPPER(TRIM(vehicle_code_1)) IN ('SEDAN', '4 DR SEDAN', '4DSD', '2 DR SEDAN', '2DSD') THEN 'SEDAN'
    WHEN UPPER(TRIM(vehicle_code_1)) IN ('VAN', 'MINIVAN', 'REFRIGERATED VAN', 'CARGO VAN') THEN 'VAN'
    WHEN UPPER(TRIM(vehicle_code_1)) IN ('TAXI', 'YELLOW TAXI', 'GREEN TAXI', 'CHASSIS CAB', 'CAB') THEN 'TAXI'
    WHEN UPPER(TRIM(vehicle_code_1)) IN ('BUS', 'SCHOOL BUS', 'SCHOO') THEN 'BUS'
    WHEN UPPER(TRIM(vehicle_code_1)) IN ('BICYCLE', 'BIKE', 'MINIBIKE', 'MINICYCLE') THEN 'BICYCLE'
    WHEN UPPER(TRIM(vehicle_code_1)) IN ('MOTORCYCLE', 'MOTOR BIKE', 'MOTORBIKE') THEN 'MOTORCYCLE'
    WHEN UPPER(TRIM(vehicle_code_1)) IN ('TRUCK', 'TRACTOR TRUCK', 'BOX TRUCK', 'TRACTOR', 'TOW TRUCK', 'PICKUP TRUCK', 'TRACTOR TRUCK DIESEL', 'TRACTOR TRUCK GASOLINE', 'TOW TRUCK / WRECKER', 'ARMORED TRUCK', 'BEVERAGE TRUCK', 'TRACT', 'TOW T', 'BOX T', 'FDNY TRUCK', 'MAIL TRUCK', 'UTILITY TR') THEN 'TRUCK'
    WHEN UPPER(TRIM(vehicle_code_1)) IN ('UNKNOWN', 'UNKNO') THEN 'UNKNOWN'
    WHEN UPPER(TRIM(vehicle_code_1)) IN ('SCOOTER', 'MOPED', 'VESPA', 'MOTORSCOOTER',  'E-SCO', 'E-SCOOTER', 'E-BIKE', 'E-BIK', 'SCOOT', 'GAS SCOOTE', 'E BIK') THEN 'SCOOTER/MOPED'
    WHEN UPPER(TRIM(vehicle_code_1)) IN ('FIRE TRUCK', 'FIRE', 'FIRET', 'FDNY', 'FIRETRUCK', 'FDNY FIRE') THEN 'FDNY'
    WHEN UPPER(TRIM(vehicle_code_1)) IN ('AMBULANCE', 'AMBUL', 'AMBU', 'FDNY AMBUL', 'AMB', 'AMBULETTE', 'NYS AMBULA') THEN 'AMBULANCE'
    WHEN UPPER(TRIM(vehicle_code_1)) IN ('DELIVERY', 'DELIV', 'USPS', 'DELV', 'USPS TRUCK', 'UHAUL', 'POSTAL TRU', 'US POSTAL') THEN 'DELIVERY'
    WHEN UPPER(TRIM(vehicle_code_1)) IN ('PASS', 'PASSE', 'PASSENGER VEHICLE') THEN 'PASSENGER VEHICLE'
    ELSE UPPER(TRIM(vehicle_code_1))
END;
```

Dentro de los archivos del repositorio se puede encontrar uno llamado `script_limpieza.sql` este archivo contiene los códigos listados anteriormente y puede ser corrido usando el siguiente comando desde una consola SQL. El codigo ya contiene los codigos para todos los atributos con numero., es decir los codigos mostrados para solo un `contributing_factor` se ejecutaran para todos.
```
\i /ruta/al/archivo/script_limpieza.sql
```
## Normalización de datos hasta cuarta forma normal 

### Diagrama de entidad-relación intuitivo

Antes de ofrecer el diagrama de entidad-relación final en cuarta forma normal, primero ofrecemos el modelo relacional intuitivo sin tomar en cuenta la teoría de normalización. El diagrama de entidad-relación intuitivo es el siguiente:

![image](https://github.com/user-attachments/assets/eec1bf7d-1356-41b3-9403-3756bffad90b)


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

![image](https://github.com/user-attachments/assets/8a945fe0-c337-4ba5-8578-6e0ca27b6b47)


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
Dentro de los archivos del repositorio se puede encontrar uno llamado `script_normalizacion.sql` este archivo contiene los códigos listados anteriormente y puede ser corrido usando el siguiente comando desde una consola SQL.
```
\i /ruta/al/archivo/script_normalizacion.sql
```
Aclaramos que este script no contiene las ultimas dos lineas mostradas, es decir la eliminacion de las tablas original y limpieza.
#### Algunas notas sobre la normalización
Uno de los aspectos importantes que encontramos es que `latitude` y `longitude` deberian de poder darnos `zip_code` y todos los `*_street_name`, al menos teoricamente. En una base de datos sin atributos en `null` esta seria una dependencia funcional y podriamos mejorar el diseño ERD. Lamentablemente en nuestro caso, los atributos de `latitude` y `longitude` se dejan en null en muchos casos, los suficientes como para que no aplique la dependencia funcional. Por lo anterior se ha decidido dejar todos los atributos como estaban, evitando una perdida de datos.

## Análisis de Datos y Atributos Analíticos
Recordando nuestro objetivo original, hemos encontrado los siguientes datos. Las consultas utlizadas pueden ser encontradas en el archivo `script_analisis.sql` dentro del repositorio.Dicho archivo puede ser corrido usando el siguiente comando desde una consola SQL en caso de que el usuario quiera ver los resultados por su cuenta.
```
\i /ruta/al/archivo/script_analisis.sql
```

### Estadísticas Básicas
#### Calles con más accidentes
![Top_calle](https://github.com/user-attachments/assets/6a027352-668f-4b52-aad4-b202c76a85f2)
> Podemos observar que la mayoria de accidentes no reportan una calle principal involucrada, estas omisiones podemos atribuirlas a la NYPD. En general, podemos observar a Broadway como la calle con más accidentes, dicha calle atraviesa Manhattan y Bronx.

#### Principales tipos de carros involucrados
![Top_vehiculo](https://github.com/user-attachments/assets/f38ffbd4-389a-4d9a-89d8-490376d5bf57)
> Podemos observar que la mayoría de accidentes involucran a SUV y sedanes, que son los coches más populares para familias e individuos. Observamos también un porcentaje significativo de transportes publicos, como taxi y bus, dado que solo el 54% [*(Hunter College, 2024)*](https://www.hunterurban.org/wp-content/uploads/2024/06/Car-Light-NYC-Infographics-May-2024.pdf) de los hogares en Nueva York poseen un coche, esta incidencia toma sentido, esto es asumiendo que no existen taxis dentro de los vehículos catalogados como sedan.

#### Principales factores contribuyentes
![Top_factor](https://github.com/user-attachments/assets/e5001c87-65a3-427b-adb7-2595ba070a7c)
> En el análisis de los principales factores de accidentes en Nueva York, se observa que el 58.6% de los casos no especifican la causa, lo cual representa una limitación en la calidad de los datos. Aun así, la distracción del conductor resalta como el factor identificado más común (12.9%), seguido por no ceder el paso (3.5%) y conducir demasiado cerca de otro vehículo (3.3%).

#### Tasa de gravedad de los accidentes
| Acc. con Lesiones | Total Accidentes |  Promedio [%] |
| -------------     | :-------------:  |:----------:|
|     517,870	      |     2,175,582	     |    23.80    |

> De los más de 2 millones de accidentes registrados, alrededor del 23.8% resultaron en lesiones. Esto indica que, aunque no todos los choques son graves, una parte considerable termina afectando físicamente a los involucrados.

| Acc. con Muertes  | Total Accidentes |  Promedio [%]  |
| -------------     | :-------------:  |:----------:|
|       3,248	      |      2,175,582	     |   0.1492   |

> Solo el 0.14% de los accidentes registrados terminaron en una muerte, lo cual es un porcentaje bajo, pero sigue siendo preocupante considerando el volumen total de incidentes.
### Análisis 
#### Análisis frecuencia-zona
> Los mapas de 2022, 2023 y 2024 muestran una distribución bastante consistente de accidentes en Nueva York. A lo largo de los tres años se repiten patrones similares: los accidentes se concentran principalmente en áreas muy transitadas como Manhattan, Brooklyn y Queens. Aunque la intensidad varía un poco de un año a otro, las zonas más afectadas tienden a ser las mismas, lo que sugiere que ciertos sectores siguen siendo más propensos a los accidentes. Esta consistencia puede ayudar a identificar puntos críticos donde convendría implementar medidas de prevención.

##### **2024**
![Distribucion Accidentes 2024](https://github.com/user-attachments/assets/816139f9-f8f5-473d-be28-b3b986aeb61d "Distribucion de accidentes durante 2024")

##### **2023**
![Distribucion Accidentes 2023](https://github.com/user-attachments/assets/0e557f08-cf28-4d78-9561-666dd900e61a "Distribucion de accidentes 2023")

##### **2022**
![Distribucion Accidentes 2022](https://github.com/user-attachments/assets/11fefca8-7505-473f-882f-c8ce9c7c6d30 "Distribucion de accidentes 2022")
######
Para una distribución de todos los accidentes ocurridos desde 2012 (el dato más viejo de la base de datos), ingrese al siguiente link: [Incidentes por distrito](https://aguayo-0107.github.io/mapa_NYC/). Ahi encontrara la cantidad de accidentes catalogados por su distrito, el mapa tambien muestra los distritos de color diferente segun la cantidad de colisiones ocurridos dentro de ellos.

#### Análisis gravedad-zona
|Distrito      | Acc. con Lesiones | Acc. en Distrito  | Promedio [%] |
| -------------|:------------:|:---------------:|:--------: |
|BRONX	       |55,527	      |221,614	          |24.84      |
|BROOKLYN	     |123,916	      |478,105	          |25.67      |
|MANHATTAN	   |61,969	      |332,624	          |18.44      |
|QUEENS	       |94,597	      |401,324	          |23.38      |
|STATEN ISLAND |13,622        |62,750	            |21.53      |
|NULL 	       |168,239       |671,565            |25.05     |

> Brooklyn y Bronx son los distritos con mayor proporción de accidentes con lesiones, con promedios cercanos al 25%. Seguidos por Queens, mientras que Manhattan presenta el promedio más bajo (18.44%).


|Distrito      | Acc. con Muertes | Acc. en Distrito  | Promedio [%] |
| -------------|:------------:|:---------------:|:--------:  |
|BRONX	       |299	          |222,720	          |0.1342     |
|BROOKLYN	     |664	          |480,808	          |0.1381      |
|MANHATTAN	   |355	          |334,155	          |0.1062      |
|QUEENS	       |538	          |403,286	          |0.1334      |
|STATEN ISLAND |100	          |63,048	            |0.1586      |
|NULL 	       |1,292         |669,660            |0.1921      |
> Staten Island muestra el promedio más alto de accidentes con muertes (0.1586%) a pesar de tener menos accidentes totales que los demás distritos. Mientras que Manhattan presenta el promedio más bajo (0.1062%).
