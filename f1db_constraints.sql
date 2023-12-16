--
-- additional foreign key constraints
--

--
-- TABLE constructorresults
--

ALTER TABLE constructorresults
ADD CONSTRAINT constructorresults_races_fkey
FOREIGN KEY (raceid)
REFERENCES races(raceid);

ALTER TABLE constructorresults
ADD CONSTRAINT constructorresults_constructors_fkey
FOREIGN KEY (constructorid)
REFERENCES constructors(constructorid);

--
-- TABLE constructorstandings
--

ALTER TABLE constructorstandings
ADD CONSTRAINT constructorstandings_races_fkey
FOREIGN KEY (raceid)
REFERENCES races(raceid);

ALTER TABLE constructorstandings
ADD CONSTRAINT constructorstandings_constructors_fkey
FOREIGN KEY (constructorid)
REFERENCES constructors(constructorid);

--
-- TABLE driverstandings
--

ALTER TABLE driverstandings
DROP CONSTRAINT IF EXISTS driverstandings_races_fkey;

ALTER TABLE driverstandings
ADD CONSTRAINT driverstandings_races_fkey
FOREIGN KEY (raceid)
REFERENCES races(raceid);

ALTER TABLE driverstandings
DROP CONSTRAINT IF EXISTS driverstandings_drivers_fkey;

ALTER TABLE driverstandings
ADD CONSTRAINT driverstandings_drivers_fkey
FOREIGN KEY (driverid)
REFERENCES drivers(driverid);

--
-- TABLE results
--

ALTER TABLE results
ADD CONSTRAINT results_races_fkey
FOREIGN KEY (raceid)
REFERENCES races(raceid);

ALTER TABLE results
ADD CONSTRAINT results_drivers_fkey
FOREIGN KEY (driverid)
REFERENCES drivers(driverid);

ALTER TABLE results
ADD CONSTRAINT results_constructors_fkey
FOREIGN KEY (constructorid)
REFERENCES constructors(constructorid);

ALTER TABLE results
ADD CONSTRAINT results_status_fkey
FOREIGN KEY (statusid)
REFERENCES status(statusid);

--
-- TABLE sprintresults
--

ALTER TABLE sprintresults
ADD CONSTRAINT sprintresults_races_fkey
FOREIGN KEY (raceid)
REFERENCES races(raceid);

ALTER TABLE sprintresults
ADD CONSTRAINT sprintresults_drivers_fkey
FOREIGN KEY (driverid)
REFERENCES drivers(driverid);

ALTER TABLE sprintresults
ADD CONSTRAINT sprintresults_constructors_fkey
FOREIGN KEY (constructorid)
REFERENCES constructors(constructorid);

ALTER TABLE sprintresults
ADD CONSTRAINT sprintresults_status_fkey
FOREIGN KEY (statusid)
REFERENCES status(statusid);

--
-- TABLE qualifying
--

ALTER TABLE qualifying
ADD CONSTRAINT qualifying_races_fkey
FOREIGN KEY (raceid)
REFERENCES races(raceid);

ALTER TABLE qualifying
ADD CONSTRAINT qualifying_drivers_fkey
FOREIGN KEY (driverid)
REFERENCES drivers(driverid);

ALTER TABLE qualifying
ADD CONSTRAINT qualifying_constructors_fkey
FOREIGN KEY (constructorid)
REFERENCES constructors(constructorid);

--
-- TABLE pitstops
--

ALTER TABLE pitstops
ADD CONSTRAINT pitstops_races_fkey
FOREIGN KEY (raceid)
REFERENCES races(raceid);

ALTER TABLE pitstops
ADD CONSTRAINT pitstops_drivers_fkey
FOREIGN KEY (driverid)
REFERENCES drivers(driverid);

--
-- TABLE laptimes
--

ALTER TABLE laptimes
ADD CONSTRAINT laptimes_races_fkey
FOREIGN KEY (raceid)
REFERENCES races(raceid);

ALTER TABLE laptimes
ADD CONSTRAINT laptimes_drivers_fkey
FOREIGN KEY (driverid)
REFERENCES drivers(driverid);

--
-- TABLE races
--

ALTER TABLE races
ADD CONSTRAINT races_circuits_fkey
FOREIGN KEY (circuitid)
REFERENCES circuits(cirtcuitid);

ALTER TABLE races
ADD CONSTRAINT races_seasons_fkey
FOREIGN KEY (year)
REFERENCES seasons(year);
