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
`borough`, `zip_code`, `vehicle_type_code`

* Atributos Textuales:
`contributing_factor`, `on_street_name`, `cross_street_name`, `off_street_name`

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


