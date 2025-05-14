-- Proyecto Final Bases de Datos
-- Se asume que ya se ha cargado la base de datos .CSV de forma manual
-- Script dedicado para la limpieza de datos


CREATE TABLE IF NOT EXISTS limpieza AS
SELECT *
FROM original;

-- hora y fecha del accidente
ALTER TABLE limpieza
	ADD COLUMN crash_timestamp TIMESTAMP;

UPDATE limpieza
SET crash_timestamp = to_date(crash_date, 'mm-dd-yyyy') + crash_time;

ALTER TABLE limpieza
	DROP COLUMN location,
	DROP COLUMN crash_date,
	DROP COLUMN crash_time;

--zip code
UPDATE limpieza
SET zip_code = NULL
	WHERE zip_code LIKE ' ';
UPDATE limpieza
SET zip_code = NULL
	WHERE zip_code LIKE '     ';	

-- geolocation
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

-- nombres calles
--ON
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

--CROSS
	UPDATE limpieza
	SET cross_street_name = NULL
	WHERE cross_street_name LIKE '                                ';
	
	UPDATE limpieza
	SET cross_street_name = TRIM(cross_street_name);
	
	UPDATE limpieza
	SET cross_street_name = REPLACE(cross_street_name, 'AVENUENUE', 'AVENUE')
	WHERE cross_street_name ILIKE '%AVE%' AND cross_street_name NOT LIKE '% AVENUE %';
	
	UPDATE limpieza
	SET cross_street_name = REPLACE(cross_street_name, 'ave', 'AVENUE')
	WHERE cross_street_name ILIKE '%AVE%' AND cross_street_name NOT LIKE '% AVENUE %';
	
	UPDATE limpieza
	SET cross_street_name = REPLACE(cross_street_name, 'avenue', 'AVENUE')
	WHERE cross_street_name ILIKE '%AVE%' AND cross_street_name NOT LIKE '% AVENUE %';
	
	UPDATE limpieza
	SET cross_street_name = REPLACE(cross_street_name, 'Avenue', 'AVENUE')
	WHERE cross_street_name ILIKE '%AVE%' AND cross_street_name NOT LIKE '% AVENUE %';
	
	UPDATE limpieza
	SET cross_street_name = REPLACE(cross_street_name, 'AVENUEnue', 'AVENUE')
	WHERE cross_street_name ILIKE '%AVE%' AND cross_street_name NOT LIKE '% AVENUE %';
	
	UPDATE limpieza
	SET cross_street_name = REPLACE(cross_street_name, 'vAVENUE', 'AVENUE')
	WHERE cross_street_name ILIKE '%vAVENUE%' AND cross_street_name NOT LIKE '% AVENUE %';

---OFF
	UPDATE limpieza
	SET off_street_name = NULL
	WHERE off_street_name LIKE '                                ';
	
	UPDATE limpieza
	SET off_street_name = TRIM(off_street_name);
	
	UPDATE limpieza
	SET off_street_name = REPLACE(off_street_name, 'AVENUENUE', 'AVENUE')
	WHERE off_street_name ILIKE '%AVE%' AND off_street_name NOT LIKE '% AVENUE %';
	
	UPDATE limpieza
	SET off_street_name = REPLACE(off_street_name, 'ave', 'AVENUE')
	WHERE off_street_name ILIKE '%AVE%' AND off_street_name NOT LIKE '% AVENUE %';
	
	UPDATE limpieza
	SET off_street_name = REPLACE(off_street_name, 'avenue', 'AVENUE')
	WHERE off_street_name ILIKE '%AVE%' AND off_street_name NOT LIKE '% AVENUE %';
	
	UPDATE limpieza
	SET off_street_name = REPLACE(off_street_name, 'Avenue', 'AVENUE')
	WHERE off_street_name ILIKE '%AVE%' AND off_street_name NOT LIKE '% AVENUE %';
	
	UPDATE limpieza
	SET off_street_name = REPLACE(off_street_name, 'AVENUEnue', 'AVENUE')
	WHERE off_street_name ILIKE '%AVE%' AND off_street_name NOT LIKE '% AVENUE %';
	
	UPDATE limpieza
	SET off_street_name = REPLACE(off_street_name, 'vAVENUE', 'AVENUE')
	WHERE off_street_name ILIKE '%vAVENUE%' AND off_street_name NOT LIKE '% AVENUE %';

--mayusculas
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

-- contributing factor 1 y 80
UPDATE limpieza
SET contributing_factor_1 = 'DRIVER INATTENTION'
WHERE contributing_factor_1 = 1;
UPDATE limpieza
SET contributing_factor_1 = 'UNSPECIFIED'
WHERE contributing_factor_1 = 80;

UPDATE limpieza
SET contributing_factor_2 = 'DRIVER INATTENTION'
WHERE contributing_factor_2 = 1;
UPDATE limpieza
SET contributing_factor_2 = 'UNSPECIFIED'
WHERE contributing_factor_2 = 80;

UPDATE limpieza
SET contributing_factor_3 = 'DRIVER INATTENTION'
WHERE contributing_factor_3 = 1;
UPDATE limpieza
SET contributing_factor_3 = 'UNSPECIFIED'
WHERE contributing_factor_3 = 80;

UPDATE limpieza
SET contributing_factor_4 = 'DRIVER INATTENTION'
WHERE contributing_factor_4 = 1;
UPDATE limpieza
SET contributing_factor_4 = 'UNSPECIFIED'
WHERE contributing_factor_4 = 80;

UPDATE limpieza
SET contributing_factor_5 = 'DRIVER INATTENTION'
WHERE contributing_factor_5 = 1;
UPDATE limpieza
SET contributing_factor_5 = 'UNSPECIFIED'
WHERE contributing_factor_5 = 80;

-- vehiculos
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

UPDATE limpieza
SET vehicle_code_2 = CASE
    WHEN vehicle_code_2 IS NULL OR TRIM(vehicle_code_2) = '' THEN NULL
    WHEN UPPER(TRIM(vehicle_code_2)) IN ('SUV', 'SPORT UTILITY VEHICLE', 'STATION WAGON/SPORT UTILITY VEHICLE', 'SPORT UTILITY', 'SPORT UTILITY / STATION WAGON') THEN 'SUV'
    WHEN UPPER(TRIM(vehicle_code_2)) IN ('PICK-UP TRUCK', 'PICKUP', 'PICK UP', 'PICK-') THEN 'PICKUP TRUCK'
    WHEN UPPER(TRIM(vehicle_code_2)) IN ('SEDAN', '4 DR SEDAN', '4DSD', '2 DR SEDAN', '2DSD') THEN 'SEDAN'
    WHEN UPPER(TRIM(vehicle_code_2)) IN ('VAN', 'MINIVAN', 'REFRIGERATED VAN', 'CARGO VAN') THEN 'VAN'
    WHEN UPPER(TRIM(vehicle_code_2)) IN ('TAXI', 'YELLOW TAXI', 'GREEN TAXI', 'CHASSIS CAB', 'CAB') THEN 'TAXI'
    WHEN UPPER(TRIM(vehicle_code_2)) IN ('BUS', 'SCHOOL BUS', 'SCHOO') THEN 'BUS'
    WHEN UPPER(TRIM(vehicle_code_2)) IN ('BICYCLE', 'BIKE', 'MINIBIKE', 'MINICYCLE') THEN 'BICYCLE'
    WHEN UPPER(TRIM(vehicle_code_2)) IN ('MOTORCYCLE', 'MOTOR BIKE', 'MOTORBIKE') THEN 'MOTORCYCLE'
    WHEN UPPER(TRIM(vehicle_code_2)) IN ('TRUCK', 'TRACTOR TRUCK', 'BOX TRUCK', 'TRACTOR', 'TOW TRUCK', 'PICKUP TRUCK', 'TRACTOR TRUCK DIESEL', 'TRACTOR TRUCK GASOLINE', 'TOW TRUCK / WRECKER', 'ARMORED TRUCK', 'BEVERAGE TRUCK', 'TRACT', 'TOW T', 'BOX T', 'FDNY TRUCK', 'MAIL TRUCK', 'UTILITY TR') THEN 'TRUCK'
    WHEN UPPER(TRIM(vehicle_code_2)) IN ('UNKNOWN', 'UNKNO') THEN 'UNKNOWN'
    WHEN UPPER(TRIM(vehicle_code_2)) IN ('SCOOTER', 'MOPED', 'VESPA', 'MOTORSCOOTER',  'E-SCO', 'E-SCOOTER', 'E-BIKE', 'E-BIK', 'SCOOT', 'GAS SCOOTE', 'E BIK') THEN 'SCOOTER/MOPED'
    WHEN UPPER(TRIM(vehicle_code_2)) IN ('FIRE TRUCK', 'FIRE', 'FIRET', 'FDNY', 'FIRETRUCK', 'FDNY FIRE') THEN 'FDNY'
    WHEN UPPER(TRIM(vehicle_code_2)) IN ('AMBULANCE', 'AMBUL', 'AMBU', 'FDNY AMBUL', 'AMB', 'AMBULETTE', 'NYS AMBULA') THEN 'AMBULANCE'
    WHEN UPPER(TRIM(vehicle_code_2)) IN ('DELIVERY', 'DELIV', 'USPS', 'DELV', 'USPS TRUCK', 'UHAUL', 'POSTAL TRU', 'US POSTAL') THEN 'DELIVERY'
    WHEN UPPER(TRIM(vehicle_code_2)) IN ('PASS', 'PASSE', 'PASSENGER VEHICLE') THEN 'PASSENGER VEHICLE'
    ELSE UPPER(TRIM(vehicle_code_2))
END;

UPDATE limpieza
SET vehicle_code_3 = CASE
    WHEN vehicle_code_3 IS NULL OR TRIM(vehicle_code_3) = '' THEN NULL
    WHEN UPPER(TRIM(vehicle_code_3)) IN ('SUV', 'SPORT UTILITY VEHICLE', 'STATION WAGON/SPORT UTILITY VEHICLE', 'SPORT UTILITY', 'SPORT UTILITY / STATION WAGON') THEN 'SUV'
    WHEN UPPER(TRIM(vehicle_code_3)) IN ('PICK-UP TRUCK', 'PICKUP', 'PICK UP', 'PICK-') THEN 'PICKUP TRUCK'
    WHEN UPPER(TRIM(vehicle_code_3)) IN ('SEDAN', '4 DR SEDAN', '4DSD', '2 DR SEDAN', '2DSD') THEN 'SEDAN'
    WHEN UPPER(TRIM(vehicle_code_3)) IN ('VAN', 'MINIVAN', 'REFRIGERATED VAN', 'CARGO VAN') THEN 'VAN'
    WHEN UPPER(TRIM(vehicle_code_3)) IN ('TAXI', 'YELLOW TAXI', 'GREEN TAXI', 'CHASSIS CAB', 'CAB') THEN 'TAXI'
    WHEN UPPER(TRIM(vehicle_code_3)) IN ('BUS', 'SCHOOL BUS', 'SCHOO') THEN 'BUS'
    WHEN UPPER(TRIM(vehicle_code_3)) IN ('BICYCLE', 'BIKE', 'MINIBIKE', 'MINICYCLE') THEN 'BICYCLE'
    WHEN UPPER(TRIM(vehicle_code_3)) IN ('MOTORCYCLE', 'MOTOR BIKE', 'MOTORBIKE') THEN 'MOTORCYCLE'
    WHEN UPPER(TRIM(vehicle_code_3)) IN ('TRUCK', 'TRACTOR TRUCK', 'BOX TRUCK', 'TRACTOR', 'TOW TRUCK', 'PICKUP TRUCK', 'TRACTOR TRUCK DIESEL', 'TRACTOR TRUCK GASOLINE', 'TOW TRUCK / WRECKER', 'ARMORED TRUCK', 'BEVERAGE TRUCK', 'TRACT', 'TOW T', 'BOX T', 'FDNY TRUCK', 'MAIL TRUCK', 'UTILITY TR') THEN 'TRUCK'
    WHEN UPPER(TRIM(vehicle_code_3)) IN ('UNKNOWN', 'UNKNO') THEN 'UNKNOWN'
    WHEN UPPER(TRIM(vehicle_code_3)) IN ('SCOOTER', 'MOPED', 'VESPA', 'MOTORSCOOTER',  'E-SCO', 'E-SCOOTER', 'E-BIKE', 'E-BIK', 'SCOOT', 'GAS SCOOTE', 'E BIK') THEN 'SCOOTER/MOPED'
    WHEN UPPER(TRIM(vehicle_code_3)) IN ('FIRE TRUCK', 'FIRE', 'FIRET', 'FDNY', 'FIRETRUCK', 'FDNY FIRE') THEN 'FDNY'
    WHEN UPPER(TRIM(vehicle_code_3)) IN ('AMBULANCE', 'AMBUL', 'AMBU', 'FDNY AMBUL', 'AMB', 'AMBULETTE', 'NYS AMBULA') THEN 'AMBULANCE'
    WHEN UPPER(TRIM(vehicle_code_3)) IN ('DELIVERY', 'DELIV', 'USPS', 'DELV', 'USPS TRUCK', 'UHAUL', 'POSTAL TRU', 'US POSTAL') THEN 'DELIVERY'
    WHEN UPPER(TRIM(vehicle_code_3)) IN ('PASS', 'PASSE', 'PASSENGER VEHICLE') THEN 'PASSENGER VEHICLE'
    ELSE UPPER(TRIM(vehicle_code_3))
END;

UPDATE limpieza
SET vehicle_code_4 = CASE
    WHEN vehicle_code_4 IS NULL OR TRIM(vehicle_code_4) = '' THEN NULL
    WHEN UPPER(TRIM(vehicle_code_4)) IN ('SUV', 'SPORT UTILITY VEHICLE', 'STATION WAGON/SPORT UTILITY VEHICLE', 'SPORT UTILITY', 'SPORT UTILITY / STATION WAGON') THEN 'SUV'
    WHEN UPPER(TRIM(vehicle_code_4)) IN ('PICK-UP TRUCK', 'PICKUP', 'PICK UP', 'PICK-') THEN 'PICKUP TRUCK'
    WHEN UPPER(TRIM(vehicle_code_4)) IN ('SEDAN', '4 DR SEDAN', '4DSD', '2 DR SEDAN', '2DSD') THEN 'SEDAN'
    WHEN UPPER(TRIM(vehicle_code_4)) IN ('VAN', 'MINIVAN', 'REFRIGERATED VAN', 'CARGO VAN') THEN 'VAN'
    WHEN UPPER(TRIM(vehicle_code_4)) IN ('TAXI', 'YELLOW TAXI', 'GREEN TAXI', 'CHASSIS CAB', 'CAB') THEN 'TAXI'
    WHEN UPPER(TRIM(vehicle_code_4)) IN ('BUS', 'SCHOOL BUS', 'SCHOO') THEN 'BUS'
    WHEN UPPER(TRIM(vehicle_code_4)) IN ('BICYCLE', 'BIKE', 'MINIBIKE', 'MINICYCLE') THEN 'BICYCLE'
    WHEN UPPER(TRIM(vehicle_code_4)) IN ('MOTORCYCLE', 'MOTOR BIKE', 'MOTORBIKE') THEN 'MOTORCYCLE'
    WHEN UPPER(TRIM(vehicle_code_4)) IN ('TRUCK', 'TRACTOR TRUCK', 'BOX TRUCK', 'TRACTOR', 'TOW TRUCK', 'PICKUP TRUCK', 'TRACTOR TRUCK DIESEL', 'TRACTOR TRUCK GASOLINE', 'TOW TRUCK / WRECKER', 'ARMORED TRUCK', 'BEVERAGE TRUCK', 'TRACT', 'TOW T', 'BOX T', 'FDNY TRUCK', 'MAIL TRUCK', 'UTILITY TR') THEN 'TRUCK'
    WHEN UPPER(TRIM(vehicle_code_4)) IN ('UNKNOWN', 'UNKNO') THEN 'UNKNOWN'
    WHEN UPPER(TRIM(vehicle_code_4)) IN ('SCOOTER', 'MOPED', 'VESPA', 'MOTORSCOOTER',  'E-SCO', 'E-SCOOTER', 'E-BIKE', 'E-BIK', 'SCOOT', 'GAS SCOOTE', 'E BIK') THEN 'SCOOTER/MOPED'
    WHEN UPPER(TRIM(vehicle_code_4)) IN ('FIRE TRUCK', 'FIRE', 'FIRET', 'FDNY', 'FIRETRUCK', 'FDNY FIRE') THEN 'FDNY'
    WHEN UPPER(TRIM(vehicle_code_4)) IN ('AMBULANCE', 'AMBUL', 'AMBU', 'FDNY AMBUL', 'AMB', 'AMBULETTE', 'NYS AMBULA') THEN 'AMBULANCE'
    WHEN UPPER(TRIM(vehicle_code_4)) IN ('DELIVERY', 'DELIV', 'USPS', 'DELV', 'USPS TRUCK', 'UHAUL', 'POSTAL TRU', 'US POSTAL') THEN 'DELIVERY'
    WHEN UPPER(TRIM(vehicle_code_4)) IN ('PASS', 'PASSE', 'PASSENGER VEHICLE') THEN 'PASSENGER VEHICLE'
    ELSE UPPER(TRIM(vehicle_code_4))
END;

UPDATE limpieza
SET vehicle_code_5 = CASE
    WHEN vehicle_code_5 IS NULL OR TRIM(vehicle_code_5) = '' THEN NULL
    WHEN UPPER(TRIM(vehicle_code_5)) IN ('SUV', 'SPORT UTILITY VEHICLE', 'STATION WAGON/SPORT UTILITY VEHICLE', 'SPORT UTILITY', 'SPORT UTILITY / STATION WAGON') THEN 'SUV'
    WHEN UPPER(TRIM(vehicle_code_5)) IN ('PICK-UP TRUCK', 'PICKUP', 'PICK UP', 'PICK-') THEN 'PICKUP TRUCK'
    WHEN UPPER(TRIM(vehicle_code_5)) IN ('SEDAN', '4 DR SEDAN', '4DSD', '2 DR SEDAN', '2DSD') THEN 'SEDAN'
    WHEN UPPER(TRIM(vehicle_code_5)) IN ('VAN', 'MINIVAN', 'REFRIGERATED VAN', 'CARGO VAN') THEN 'VAN'
    WHEN UPPER(TRIM(vehicle_code_5)) IN ('TAXI', 'YELLOW TAXI', 'GREEN TAXI', 'CHASSIS CAB', 'CAB') THEN 'TAXI'
    WHEN UPPER(TRIM(vehicle_code_5)) IN ('BUS', 'SCHOOL BUS', 'SCHOO') THEN 'BUS'
    WHEN UPPER(TRIM(vehicle_code_5)) IN ('BICYCLE', 'BIKE', 'MINIBIKE', 'MINICYCLE') THEN 'BICYCLE'
    WHEN UPPER(TRIM(vehicle_code_5)) IN ('MOTORCYCLE', 'MOTOR BIKE', 'MOTORBIKE') THEN 'MOTORCYCLE'
    WHEN UPPER(TRIM(vehicle_code_5)) IN ('TRUCK', 'TRACTOR TRUCK', 'BOX TRUCK', 'TRACTOR', 'TOW TRUCK', 'PICKUP TRUCK', 'TRACTOR TRUCK DIESEL', 'TRACTOR TRUCK GASOLINE', 'TOW TRUCK / WRECKER', 'ARMORED TRUCK', 'BEVERAGE TRUCK', 'TRACT', 'TOW T', 'BOX T', 'FDNY TRUCK', 'MAIL TRUCK', 'UTILITY TR') THEN 'TRUCK'
    WHEN UPPER(TRIM(vehicle_code_5)) IN ('UNKNOWN', 'UNKNO') THEN 'UNKNOWN'
    WHEN UPPER(TRIM(vehicle_code_5)) IN ('SCOOTER', 'MOPED', 'VESPA', 'MOTORSCOOTER',  'E-SCO', 'E-SCOOTER', 'E-BIKE', 'E-BIK', 'SCOOT', 'GAS SCOOTE', 'E BIK') THEN 'SCOOTER/MOPED'
    WHEN UPPER(TRIM(vehicle_code_5)) IN ('FIRE TRUCK', 'FIRE', 'FIRET', 'FDNY', 'FIRETRUCK', 'FDNY FIRE') THEN 'FDNY'
    WHEN UPPER(TRIM(vehicle_code_5)) IN ('AMBULANCE', 'AMBUL', 'AMBU', 'FDNY AMBUL', 'AMB', 'AMBULETTE', 'NYS AMBULA') THEN 'AMBULANCE'
    WHEN UPPER(TRIM(vehicle_code_5)) IN ('DELIVERY', 'DELIV', 'USPS', 'DELV', 'USPS TRUCK', 'UHAUL', 'POSTAL TRU', 'US POSTAL') THEN 'DELIVERY'
    WHEN UPPER(TRIM(vehicle_code_5)) IN ('PASS', 'PASSE', 'PASSENGER VEHICLE') THEN 'PASSENGER VEHICLE'
    ELSE UPPER(TRIM(vehicle_code_5))
END;

