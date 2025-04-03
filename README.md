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
