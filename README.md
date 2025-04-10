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
Para una carga exitosa, se debe definir la tabla de datos con los atributos y tipos respectivos. Pero antes de poder hacer eso, debemos de cambiar el DateStyle de la base a través del siguiente comando. Esto se debe a que la base es de Estados Unidos, donde se utiliza el formato de fecha MM/DD/YYYY, por lo que para evitar errores con diferentes configuraciones horarias se deberá cambiar.
```
SET DateStyle TO ‘US’;
```
El siguiente código es la creación del esquema inicial. Puede ser copiado en `SQL SHELL (psql)` o cualquier DBMS compatible con PostgreSQL.
```
DROP TABLE IF EXISTS original;
CREATE TABLE original (
   crash_date DATE,
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

Antes de poder importar los datos, debemos de cambiar el DateStyle de la base a través del siguiente comando. Esto se debe a que la base es de Estados Unidos, donde se utiliza el formato de fecha MM/DD/YYYY, por lo que para evitar errores con diferentes configuraciones horarias se deberá cambiar.
```
SET DateStyle TO ‘US’;
```
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

En general podemos observar inconsistencias en ciertos atributos, en su mayoría debido a errores humanos. Ya que estos reportes son escritos con la presión de todos los afectados sobre los policías, hay problemas en redacción, atributos incompletos o dejados en blanco. A través del siguiente query podemos encontrar la cantidad de tuplas con algún valor null.
```
SELECT COUNT(*) as cant
FROM original
WHERE crash_date is null or crash_time is null or borough is null or zip_code is null or latitude is null or longitude is null or location is null or (on_street_name is null and off_street_name is null and cross_street_name is null ) or (contributing_factor_1 is null  and contributing_factor_2 is null and contributing_factor_3 is null and contributing_factor_4 is null and contributing_factor_5 is null) or collision_id is null or (vehicle_code_1 is null and vehicle_code_2 is null and vehicle_code_3 is null and vehicle_code_4 is null and vehicle_code_5 is null);
```
> Tomando en cuenta que puede haber valores null en 4 de 5 de los atributos repetidos ya que puede haber hasta 5 vehículos involucrados. 

## Limpieza de Datos
Antes de empezar la limpieza de datos, si se quiere preservar la tabla original, se puede copiar el siguiente comando. Este hará una copia de la tabla original y entonces se podrá trabajar con la nueva tabla sin perder ningún dato.
```
CREATE TABLE limpieza AS 
SELECT * FROM original;
```
Para optimizar el proyecto, hemos decidido eliminar las columnas de latitude y longitude, ya que es información que podemos extraer de location. También hemos decidido combinar crash_date y crash_time a un solo atributo crash_timestamp, ya que consideramos redundante tener dos atributos que pueden ser solo uno. 

Los siguientes comandos deben ser copiados en alguna DBMS, por ejemplo TablePlus.
```
ALTER TABLE limpieza 
ADD COLUMN crash_timestamp TIMESTAMP;
UPDATE limpieza
SET crash_timestamp = crash_date + crash_time;

ALTER TABLE limpieza
	DROP COLUMN latitude,
	DROP COLUMN longitude,
	DROP COLUMN crash_date,
	DROP COLUMN crash_time;
```
Algunas otras cosas que se ha hecho fue cambiar los valores de zip_code en blanco a null. El comando utilizado fue el siguiente.
```
UPDATE limpieza
SET zip_code = null
WHERE zip_code LIKE ' ';
```
